Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AB4D1F424
	for <e@80x24.org>; Wed, 27 Dec 2017 18:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbdL0StD (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:49:03 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:45588 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbdL0StC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:49:02 -0500
Received: by mail-qt0-f174.google.com with SMTP id g10so48777577qtj.12
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 10:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VwET4nu3rMkdn2iBTS/hTqE0I7iRU+3P2q+rNhKmxo4=;
        b=ebSkcxtp1cm9Oa6jj1Znxg2z+Bv/7aNUXzr51P0L4eFKUcsvS/uKOf+CS6gDINWN0K
         eQp8nc6+d9MecJxt3Ge+/nq5kh4ezbEHJDyE3e3BvNunQi+PTgathum5T1L/Shql3sQX
         gyoqRXx0T0PwoFoH01Eeq3UyvEjDMgcHhfetrzVjipiCyAPh2/H8aRpcAXVjmAifneSP
         x1tSSv6ICAsH9NhsGjPPA2bJJcvShg7/Z0MtqvXynuvPQr1R3ndrtLRDReWMKAcoyYSP
         5HihtLQoRLb4HvlCrneWxrQHUm4qke+FQ2xJmxJF61NsQsRUt0H0xi7iwFTSkPPAYWk9
         Cl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VwET4nu3rMkdn2iBTS/hTqE0I7iRU+3P2q+rNhKmxo4=;
        b=D+XhAvrM/VJQuLxTAMUEFCI+s/aCOvUlSrSBGb0PET5Stb+O4943FL3fF9iwUFNTPF
         wrGSMU7Dbx7uFt3uaa2umvhZXWmSkRb62RU37/VwMWg4hf5TyxGRjUbSa/LAcJS3exnS
         JLQmVVkpWTWYLx2r/Z6Nh8k1NdtfmkTg4778s2dvm3TxRfDEgFNN2RD8UWR4N98X31Oc
         b+JsmXXBNW4bE5hMD+x4ngCqYcuNDhogCD3uuOov/+WrCyz0fJx0opDqQKRM1mn9k3tr
         UHk+jCmO8RxPjUpMjAwS0QrTVILah8CQjuxH9th3yvGg2U717Wnu3n7qkevTXQslZVo3
         ComA==
X-Gm-Message-State: AKGB3mLWewuecqsEa2rDl60C93AK+ed8Ojf9XBz/jTqEPFe8bzQ114FQ
        ECWwDCk+xIJPE0jjNpXEyTpDVSRvtGWwnjYVYG8JIlYjrOA=
X-Google-Smtp-Source: ACJfBotbLOrnn93rqE2XSOQ11wACz9N/dV1j6qD3w2h0Pr2krxwJz86+buHOvjYdc7ucJrlgdK5XAoyrU84qA6zDGvs=
X-Received: by 10.200.36.22 with SMTP id c22mr39896583qtc.207.1514400541058;
 Wed, 27 Dec 2017 10:49:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 27 Dec 2017 10:49:00 -0800 (PST)
In-Reply-To: <xmqq374cspgw.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kaJgCchQKcRMkW-cjRmx_7eYQDqLs5GgDOgLEb1H=w-0g@mail.gmail.com>
 <20171212012422.123332-1-sbeller@google.com> <20171214212234.GC32842@aiede.mtv.corp.google.com>
 <CAGZ79kZdUuoM79n09ziG0F7WCWNLpZ2AiFA6fb_qgND1b3_F9A@mail.gmail.com>
 <20171214225200.GA44616@aiede.mtv.corp.google.com> <xmqq374cspgw.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 27 Dec 2017 10:49:00 -0800
Message-ID: <CAGZ79kYiL0St-600sjxN5gjLSfyRodS1=AqxyALsidntXkg_xA@mail.gmail.com>
Subject: Re: [PATCH] diffcore: add a filter to find a specific blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 14, 2017 at 6:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> Regarding finding a better name, I would want to hear from others,
>>> I am happy with --find-object, though I can see --pickaxe-object
>>> or --object--filter to be a good narrative as well.
>>
>> Drat, I was hoping for an opinion.
>
> I think it would make it a better companion to --pickaxe but we need
> to align its behaviour a little bit so that it plays better with the
> "--pickaxe-all" option, and also needs to hide mode and name only
> changes just like pickaxe.

I looked into this, and the small changes needed led me to thinking
it could be integrated into the diffcore-pickaxe code completely,
roughly like (spaces mangled):

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 9476bd2108..46f875a7b4 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -124,13 +124,21 @@ static int pickaxe_match(struct diff_filepair
*p, struct diff_options *o,
        mmfile_t mf1, mf2;
        int ret;

-       if (!o->pickaxe[0])
-               return 0;
-
        /* ignore unmerged */
        if (!DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two))
                return 0;

+       if (options->objfind) {
+               if ((DIFF_FILE_VALID(p->one) &&
+                    oidset_contains(options->objfind, &p->one->oid)) ||
+                   (DIFF_FILE_VALID(p->two) &&
+                    oidset_contains(options->objfind, &p->two->oid)))
+                       return 1;
+       }
+
+       if (!o->pickaxe[0])
+               return 0;
+
        if (o->flags.allow_textconv) {
                textconv_one = get_textconv(p->one);
                textconv_two = get_textconv(p->two);
---8<---

But then, it seems as if any pickaxe option is incompatible with
any other, i.e. from reading the code, you cannot combine -S
and -G, or even give one of them twice.

I guess that would be not a big deal for the --pickaxe-object,
but just want to point it out.

> After all, the diffcore-blobfind code was written while looking at
> the diffcore-pickaxe's code in another window shown in the pager,
> and I tend to agree with your earlier message that this is an
> extreme case of -S<contents> where the contents happens to be the
> whole file.

I disagree, as the user doesn't have the content, but the hash
over the content only and wants to know more about it. The new
option cannot be used to find a file whose partial content hashes to
the given sha1, either.

So with these considerations, I would keep the patch as currently\
queued at sb/diff-blobfind.

Thanks,
Stefan
