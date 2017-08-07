Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 390542047F
	for <e@80x24.org>; Mon,  7 Aug 2017 17:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbdHGRSe (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 13:18:34 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36163 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbdHGRSd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 13:18:33 -0400
Received: by mail-pg0-f68.google.com with SMTP id y129so901831pgy.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zE+aKOqjZlrS0s1bL3uKANg0Gg/hrOAhxmEBONY+Src=;
        b=Rkn5yQuZErF5JsCutdmskFGsJNOWVLboUDZMP2JYjRUZUar8ZyzS5vZXDkoSBFamDF
         yYF4O92Y/ULl0OtvrDQ5r8GHOb/HgLyqS2VTbviKDuzp/Yv2Z2FJ374HoSot12yahKEd
         dnhuDPdnHhJ/x1d7jpNw3s5Ej6hiIZ4Q0x7LM6MBoXh1FY341vIdx5pQ/q4s9r+gxhYX
         KubJCnk596w95y4+F8kY1FDBDl73243Iln/KJ794Ug7SEJTI4+1vsFZpbya0O9EELnFy
         uHMLejORyRimhLEx2DlB3cIMCzhbRIZwWloOubHQXUCsIXI6vILe0a253TCfExkZ8It/
         bETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zE+aKOqjZlrS0s1bL3uKANg0Gg/hrOAhxmEBONY+Src=;
        b=aJBBd6wvI1znp4oE+ZKJTNs2wRO6B8Tk/xaQuemygsGCEZMHedq91lhuemy2tyyFJJ
         Ao9nLucJ88vYuxWZyGct0IsQQuJZvp5Hr4ElPO8ARnhP3j4fG9pxwIcgvxm2vvi9vwZJ
         aLYmlVTNityjNFQZF7pL4WwJHrMxSkdpt79clGC40kl5203aP4UiVHXO2WAWKntwspXn
         zJj8s9QRaX55pXfEAriKqesuu+a/DgzWtFISfpbjnF9HnBXfDnX83uqHAhKLQf35KkLn
         MbZ4KwvWITIwjTg/gwZnew4Z38Cu/FF0QjflysyPct30bSliT6jm65yV9L7JV+utkM/G
         46+Q==
X-Gm-Message-State: AHYfb5i7g/NfDyBRaFjzbKNHQpeQh8usJZoyjXpSV/V1cfLKn26SbGuN
        FLNJ+tBrcJ4aT8AQ6iKpXwdktK4XOg==
X-Received: by 10.98.89.140 with SMTP id k12mr1335434pfj.71.1502126312879;
 Mon, 07 Aug 2017 10:18:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.238 with HTTP; Mon, 7 Aug 2017 10:18:32 -0700 (PDT)
In-Reply-To: <fdd74c52-7d9a-b12e-2e1f-524479201701@morey-chaisemartin.com>
References: <9687e182-1e23-f84d-3fad-83fdf15dba4c@morey-chaisemartin.com>
 <CAN0heSoA_Xm+14V49hjJBMT7PS_ge0wyhmuvKiw-MHD99rApYQ@mail.gmail.com> <fdd74c52-7d9a-b12e-2e1f-524479201701@morey-chaisemartin.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 7 Aug 2017 19:18:32 +0200
Message-ID: <CAN0heSqVmrFwP7LdjDJmH0JivoCc+DhGtUiTSBs=8nTppzG79A@mail.gmail.com>
Subject: Re: [PATCH 1/4] imap-send: add wrapper to get server credentials if needed
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 August 2017 at 19:04, Nicolas Morey-Chaisemartin
<nicolas@morey-chaisemartin.com> wrote:
>
>
> Le 07/08/2017 =C3=A0 18:30, Martin =C3=85gren a =C3=A9crit :
>> On 7 August 2017 at 16:03, Nicolas Morey-Chaisemartin
>> <nicolas@morey-chaisemartin.com> wrote:
>>> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.c=
om>
>>> ---
>>>  imap-send.c | 38 ++++++++++++++++++++++++--------------
>>>  1 file changed, 24 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/imap-send.c b/imap-send.c
>>> index b2d0b849b..38b3c817e 100644
>>> --- a/imap-send.c
>>> +++ b/imap-send.c
>>> @@ -926,6 +926,29 @@ static int auth_cram_md5(struct imap_store *ctx, s=
truct imap_cmd *cmd, const cha
>>>         return 0;
>>>  }
>>>
>>> +static void server_fill_credential(struct imap_server_conf *srvc)
>>> +{
>>> +       struct credential cred =3D CREDENTIAL_INIT;
>>> +
>>> +       if (srvc->user && srvc->pass)
>>> +               return;
>>> +
>>> +       cred.protocol =3D xstrdup(srvc->use_ssl ? "imaps" : "imap");
>>> +       cred.host =3D xstrdup(srvc->host);
>>> +
>>> +       cred.username =3D xstrdup_or_null(srvc->user);
>>> +       cred.password =3D xstrdup_or_null(srvc->pass);
>>> +
>>> +       credential_fill(&cred);
>>> +
>>> +       if (!srvc->user)
>>> +               srvc->user =3D xstrdup(cred.username);
>>> +       if (!srvc->pass)
>>> +               srvc->pass =3D xstrdup(cred.password);
>>> +
>>> +       credential_clear(&cred);
>>> +}
>>> +
>>>  static struct imap_store *imap_open_store(struct imap_server_conf *srv=
c, char *folder)
>>>  {
>>>         struct credential cred =3D CREDENTIAL_INIT;
>>> @@ -1078,20 +1101,7 @@ static struct imap_store *imap_open_store(struct=
 imap_server_conf *srvc, char *f
>>>                 }
>>>  #endif
>>>                 imap_info("Logging in...\n");
>>> -               if (!srvc->user || !srvc->pass) {
>>> -                       cred.protocol =3D xstrdup(srvc->use_ssl ? "imap=
s" : "imap");
>>> -                       cred.host =3D xstrdup(srvc->host);
>>> -
>>> -                       cred.username =3D xstrdup_or_null(srvc->user);
>>> -                       cred.password =3D xstrdup_or_null(srvc->pass);
>>> -
>>> -                       credential_fill(&cred);
>>> -
>>> -                       if (!srvc->user)
>>> -                               srvc->user =3D xstrdup(cred.username);
>>> -                       if (!srvc->pass)
>>> -                               srvc->pass =3D xstrdup(cred.password);
>>> -               }
>>> +               server_fill_credential(srvc);
>>>
>>>                 if (srvc->auth_method) {
>>>                         struct imap_cmd_cb cb;
>> "cred.username" is checked further down, but now it will always be NULL,
>> no?
>
> You're right I missed this.
> Not sure if this is needed though.
> From what I understand this means the username/password are store for the=
 next access to credential. but in the current state, there is only one.
> Maybe the credential_approved can be dropped ?

I'm no credentials-expert, but api-credentials.txt says this:

"Credential helpers are programs executed by Git to fetch or save
credentials from and to long-term storage (where "long-term" is simply
longer than a single Git process; e.g., credentials may be stored
in-memory for a few minutes, or indefinitely on disk)."

So the calls to approve/reject probably do matter in some scenarios.

The current code is a bit non-obvious as we just discovered since it
duplicates the strings (for good reasons, I believe) and then still
refers to the originals (also for good reasons, I believe). I suppose
your new function could be called like

server_fill_credential(&cred, srvc);

That should limit the impact of the change, but I'm not sure it's a
brilliant interface. Just my 2c.

Martin
