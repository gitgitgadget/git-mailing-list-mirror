Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1E062021E
	for <e@80x24.org>; Sun, 20 Nov 2016 15:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbcKTPeA (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 10:34:00 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:32968 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753086AbcKTPd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2016 10:33:59 -0500
Received: by mail-yw0-f195.google.com with SMTP id s68so24853584ywg.0
        for <git@vger.kernel.org>; Sun, 20 Nov 2016 07:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nW0YXlYViQGXEiSPqPLhFJz9i4/jlWhZKxZr4EUiJ4M=;
        b=XJm7rhdnR7gEEXqzwwNbUkpXvlPcIiHeIQe35Bf0h2TmAFxzwJ/x6qSGjQRZ3wfjeS
         SAmUBRr6tCuPYQLH/jbbsMH0qNmTTKzlh2pFyUf+tc1I2gpWVWRwv4RrFHFRvugpFZCa
         EwX46v7BFbqhAwLQAvsP3bSp19yAYMSDvsvgJ/V/Igs2NRj0x8Z0jVUh0t1uIH9gyED5
         yGAkapcbjnhuZhkHWj0AHMEbS5kxN6gPz6CpWWGOsd5DLKRVNKWOxIIRTpKBQSI4JOKu
         TrbwJyXZffDCcLBT7hx6EHzd6DrrEKhc45WZRVn9V9IC1O1S9JlKcj0nliOlmh7ja4Bz
         OErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nW0YXlYViQGXEiSPqPLhFJz9i4/jlWhZKxZr4EUiJ4M=;
        b=NgHuaevB9NZ3js0KGzMH35SODJNoXr0tSIoYvQWcMXX89ZxkZhuNPH/g64mwZ7qGHb
         0SAbzOdPrvTmlqack19XiPmsTqpS6Dto7SHRQlVHow9b51odBBoJ95FiKFvfoBP6KrmD
         dJsZixljHVNzGRk98CM8qlrjLBuLij+Uvb2zNRR6WiD5LLJgF8RC9llFxnzm83rR9Adg
         VFDAqpbmPlhKuXjHnDqnvYf+AmEdOu9ZV+k7iQQz2ids1rLAqyEM8UK2i33ZSRveYhzx
         hgkMgYswDiOff19oktwosa7URB7h3g/Jcp6oHL1Uy3CKugckTpgyVwB3RsqRsKaHm3fE
         maxA==
X-Gm-Message-State: AKaTC01LLeIsMGb8ka4vbfRZBFHmWe5UErQvGksBw2GSudDmydXFur/29sXv9O8zMCrUXOs/VielYXzjYxfpNQ==
X-Received: by 10.129.46.133 with SMTP id u127mr9141520ywu.94.1479656038770;
 Sun, 20 Nov 2016 07:33:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Sun, 20 Nov 2016 07:33:28 -0800 (PST)
In-Reply-To: <af0b7bdc-2b29-0d04-85f1-aa1d5a2ba549@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-15-Karthik.188@gmail.com>
 <af0b7bdc-2b29-0d04-85f1-aa1d5a2ba549@gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sun, 20 Nov 2016 21:03:28 +0530
Message-ID: <CAOLa=ZRU--FyFWNvv7RGH2mho36hvUu2ye=JOapXZ6QoEy=nRw@mail.gmail.com>
Subject: Re: [PATCH v7 14/17] ref-filter: allow porcelain to translate
 messages in the output
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cc'in Matthieu since he wrote the patch.

On Sat, Nov 19, 2016 at 4:16 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 08.11.2016 o 21:12, Karthik Nayak pisze:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Introduce setup_ref_filter_porcelain_msg() so that the messages used in
>> the atom %(upstream:track) can be translated if needed. This is needed
>> as we port branch.c to use ref-filter's printing API's.
>>
>> Written-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  ref-filter.c | 28 ++++++++++++++++++++++++----
>>  ref-filter.h |  2 ++
>>  2 files changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index b47b900..944671a 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -15,6 +15,26 @@
>>  #include "version.h"
>>  #include "wt-status.h"
>>
>> +static struct ref_msg {
>> +     const char *gone;
>> +     const char *ahead;
>> +     const char *behind;
>> +     const char *ahead_behind;
>> +} msgs =3D {
>> +     "gone",
>> +     "ahead %d",
>> +     "behind %d",
>> +     "ahead %d, behind %d"
>> +};
>> +
>> +void setup_ref_filter_porcelain_msg(void)
>> +{
>> +     msgs.gone =3D _("gone");
>> +     msgs.ahead =3D _("ahead %d");
>> +     msgs.behind =3D _("behind %d");
>> +     msgs.ahead_behind =3D _("ahead %d, behind %d");
>> +}
>
> Do I understand it correctly that this mechanism is here to avoid
> repeated calls into gettext, as those messages would get repeated
> over and over; otherwise one would use foo =3D N_("...") and _(foo),
> isn't it?
>
> I wonder if there is some way to avoid duplication here, but I don't
> see anything easy and safe (e.g. against running setup_*() twice).
>

That is the intention.

--=20
Regards,
Karthik Nayak
