Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA6B21FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 18:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934412AbcKVSds (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 13:33:48 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36085 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932657AbcKVSdq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 13:33:46 -0500
Received: by mail-yw0-f196.google.com with SMTP id r204so3007326ywb.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 10:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V7bJJYWR6yTatWk8UKyhabRTypXpEyK0PwKWI1QJVHQ=;
        b=Ld+lXbzfdn6RZuVFGxYstKrv9jLvMTg1tKFqEIF6DaQ+JBIcarWbL1kGxras5YGS67
         psn2IstPI1JmbH3R6SjEj7EzPLO1QFYlhDyNtB7BqB+ldJA1pvVVpL98BmyI/kpykx7A
         GBceo1BJWsWnYt2HR9e2kRu+ApU+NS4rk1h9sP91pd6B+HtMVpnEg0f9lzKUOnUPqONq
         UJ71P5o4OnObiHM97WrmFahTFCS+VenZQhn9fttjR75SoFHFmMAN57UP7ZbuRFplCwaK
         zX/URwnwgnZXVv3F7T43clH6e4fSG+tE9G3YssI8lvSVwp8KQ51BohsmHOTsD5EWUNIs
         Ribw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V7bJJYWR6yTatWk8UKyhabRTypXpEyK0PwKWI1QJVHQ=;
        b=ZsIeyfxjwE3okDA8EBkntFyDbcI4zTm9VgZAmHr8E21eFjwKvRns1KdaIivTKRoIaD
         kSYmf2NdtkcDkNh8A1o1iI2ZzCeCsxc9WeWGNWvU7Opdq429txNyJaUmWXKp03UMWc9u
         3cA4IOqI2GQRiSgnlqCas+gGnWb71E/S1e57P+PHEyXjfPZu5UUOTkEtYuQMhQ0aWoDR
         UN+mkXCZy35YqcfQYrbKYEPxfjRNPql3foZ6x4uhDo56p1APnL8FcNuaMtSY+iWJ/+GG
         UdeRlkY8bDm5hplSkqJOaR8ShKGO02TISY+ZkFzAdv4UtQvmGEF6/PNm1ScldXGz518m
         yjNQ==
X-Gm-Message-State: AKaTC033wrRHsMCD3HLzCfO0e6puaFcg3UOLK2cUs3FElZKLdMRRfTDe2Q+i8DcnEdeg8LWHGjR7JcYOqlHtzg==
X-Received: by 10.13.229.70 with SMTP id o67mr21061655ywe.131.1479839625748;
 Tue, 22 Nov 2016 10:33:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Tue, 22 Nov 2016 10:33:15 -0800 (PST)
In-Reply-To: <vpq1sy58bsl.fsf@anie.imag.fr>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-15-Karthik.188@gmail.com>
 <af0b7bdc-2b29-0d04-85f1-aa1d5a2ba549@gmail.com> <CAOLa=ZRU--FyFWNvv7RGH2mho36hvUu2ye=JOapXZ6QoEy=nRw@mail.gmail.com>
 <vpq1sy58bsl.fsf@anie.imag.fr>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 23 Nov 2016 00:03:15 +0530
Message-ID: <CAOLa=ZTQagQdHAdj0TcOs6OYjw2o+sYFbEV8kRG0SoUiud61=g@mail.gmail.com>
Subject: Re: [PATCH v7 14/17] ref-filter: allow porcelain to translate
 messages in the output
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 2:11 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> cc'in Matthieu since he wrote the patch.
>>
>> On Sat, Nov 19, 2016 at 4:16 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>>> W dniu 08.11.2016 o 21:12, Karthik Nayak pisze:
>>>> From: Karthik Nayak <karthik.188@gmail.com>
>>>>
>>>> Introduce setup_ref_filter_porcelain_msg() so that the messages used i=
n
>>>> the atom %(upstream:track) can be translated if needed. This is needed
>>>> as we port branch.c to use ref-filter's printing API's.
>>>>
>>>> Written-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>>>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>>>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>>>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>>>> ---
>>>>  ref-filter.c | 28 ++++++++++++++++++++++++----
>>>>  ref-filter.h |  2 ++
>>>>  2 files changed, 26 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/ref-filter.c b/ref-filter.c
>>>> index b47b900..944671a 100644
>>>> --- a/ref-filter.c
>>>> +++ b/ref-filter.c
>>>> @@ -15,6 +15,26 @@
>>>>  #include "version.h"
>>>>  #include "wt-status.h"
>>>>
>>>> +static struct ref_msg {
>>>> +     const char *gone;
>>>> +     const char *ahead;
>>>> +     const char *behind;
>>>> +     const char *ahead_behind;
>>>> +} msgs =3D {
>>>> +     "gone",
>>>> +     "ahead %d",
>>>> +     "behind %d",
>>>> +     "ahead %d, behind %d"
>>>> +};
>>>> +
>>>> +void setup_ref_filter_porcelain_msg(void)
>>>> +{
>>>> +     msgs.gone =3D _("gone");
>>>> +     msgs.ahead =3D _("ahead %d");
>>>> +     msgs.behind =3D _("behind %d");
>>>> +     msgs.ahead_behind =3D _("ahead %d, behind %d");
>>>> +}
>>>
>>> Do I understand it correctly that this mechanism is here to avoid
>>> repeated calls into gettext, as those messages would get repeated
>>> over and over; otherwise one would use foo =3D N_("...") and _(foo),
>>> isn't it?
>
> That's not the primary goal. The primary goal is to keep untranslated,
> and immutable messages in plumbing commands. We may decide one day that
> _("gone") is not the best message for the end user and replace it with,
> say, _("vanished"), but the "gone" has to remain the same forever and
> regardless of the user's config for scripts using it.
>
> We could have written
>
>   in_porcelain ? _("gone") : "gone"
>
> here and there in the code, but having a single place where we set all
> the messages seems simpler. Call setup_ref_filter_porcelain_msg() and
> get the porcelain messages, don't call it and keep the plumbing
> messages.
>
> Note that it's not the first place in the code where we do this, see
> setup_unpack_trees_porcelain in unpack-trees.c for another instance.
>
> Karthik: the commit message could be improved, for example:
>
> Introduce setup_ref_filter_porcelain_msg() so that the messages used in
> the atom %(upstream:track) can be translated if needed. By default, keep
> the messages untranslated, which is the right behavior for plumbing
> commands. This is needed as we port branch.c to use ref-filter's
> printing API's.
>
> Why not a comment right below "} msgs =3D {" saying e.g.:
>
>         /* Untranslated plumbing messages: */
>

Will update the commit message and add the comment. Thanks :)

--=20
Regards,
Karthik Nayak
