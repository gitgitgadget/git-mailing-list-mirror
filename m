Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16374202AB
	for <e@80x24.org>; Thu, 29 Jun 2017 22:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751715AbdF2Wle (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 18:41:34 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:32859 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdF2Wld (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 18:41:33 -0400
Received: by mail-qt0-f172.google.com with SMTP id r30so86453220qtc.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 15:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Q/M21pDmG69/GocAZamuRBaRCtjsi/f8Z0yfDwNTWR4=;
        b=uovHKWLF0Bj3rboWCIYG74y/ugo9i4IL/kayl8WLnttkCLqgJ1D6iFefeRm++nXxUW
         REg8kcZ1l4HCDGjzs+qNWqLpOlCxLKLQ0qw9h88RB+AuSzr5dcuQdSOqw9PjIfrzBz7P
         QDgnQngbKHPLk6w/JOm/bJSKEfxs8SaXJY6z9I9uEC94fYwAJqRsvBEK1c5C8NWCoSx2
         9XWd9NmQcLaj5pDC2uwYPrhFefMTErVZ3DSsAWY0z2GXtKUpGmmE+BwdRSvtUoa+BnwQ
         s1WshGs2hp/rmMeEW/h6AyQIPExjoC49Tt5bfj0nU0htbQSWyEYAYpBBHIVUnCUrlYgL
         ToiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Q/M21pDmG69/GocAZamuRBaRCtjsi/f8Z0yfDwNTWR4=;
        b=OxMY4RdNmpDpbqojmcqaeFk7wT/qziky90xGpYka+6jPnJZdo0jnA/HaS4AVjfThDc
         64fxQ75DbOmM5mZ2jZQsAJpOgcdbJCindusPmh1Fposf3H5VjhxnZEvjQYTkh/O84ITt
         OPO2IfFgo+2bJKFKByy78Ul+9kqO9LrFaCfS+mmhcu8iqsZ0mRC47B9QVEyjjyZPwvtp
         yz5NtbzprBl3+ueLSJuGL97wHOLZVcux+pLhYc/agEOM/GNu0rOA2RtXkor4B4wzNuRz
         zBjnapcUZ6nX98ZWsQcyTAuCNg5gWwHglAvSFyP1jlztaZN2btSNZDvfoDZS3cxK3UaJ
         Eg3Q==
X-Gm-Message-State: AKS2vOzh5aTgpeh67etVfj0OzgvSpTBLH7Qn0ueNhhIoFloi+67nk1bc
        eh77D2n+lte43ZsNkxw9Aa+a+iN+TQ==
X-Received: by 10.237.60.19 with SMTP id t19mr21902171qte.206.1498776087280;
 Thu, 29 Jun 2017 15:41:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.63.198 with HTTP; Thu, 29 Jun 2017 15:41:26 -0700 (PDT)
In-Reply-To: <CAE5ih7-x45MD1H6Ahr5oCVtTjgbBkeP4GbKCGB-Cwk6BSQwTcw@mail.gmail.com>
References: <CAKYtbVY_=aMjcS=r2YyhcxKiUAaJUJA=OELTvXfau4GGz7Lz4Q@mail.gmail.com>
 <20170627191704.4446-1-miguel.torroja@gmail.com> <xmqqk23wycso.fsf@gitster.mtv.corp.google.com>
 <CAE5ih78VwBVT+XHnwgnt-JcLB-c4d_Gf+9Wfb_bL=LcgkjDrUQ@mail.gmail.com>
 <CAKYtbVaLkt6_rFgehgSsrLzo-oO3sEVoMLBtS5XX59ymYYS7=w@mail.gmail.com> <CAE5ih7-x45MD1H6Ahr5oCVtTjgbBkeP4GbKCGB-Cwk6BSQwTcw@mail.gmail.com>
From:   miguel torroja <miguel.torroja@gmail.com>
Date:   Fri, 30 Jun 2017 00:41:26 +0200
X-Google-Sender-Auth: sLn2vuxa_HgTmXiR0ujeF_GJTPk
Message-ID: <CAKYtbVaZ85LAvgz4+p29Q_n7wN0s0ocnXO4LtLDzjS7pnNmZXw@mail.gmail.com>
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
To:     Luke Diamand <luke@diamand.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 29, 2017 at 8:59 AM, Luke Diamand <luke@diamand.org> wrote:
> On 28 June 2017 at 14:14, miguel torroja <miguel.torroja@gmail.com> wrote:
>> Thanks Luke,
>>
>> regarding the error in t9800 (not ok 18 - unresolvable host in P4PORT
>> should display error), for me it's very weird too as it doesn't seem
>> to be related to this particular change, as the patch changes are not
>> exercised with that test.
>
> I had a look at this. The problem is that the old code uses
> p4_read_pipe_lines() which calls sys.exit() if the subprocess fails.
>
> But the new code calls p4CmdList() which has does error handling by
> setting "p4ExitCode" to a non-zero value in the returned dictionary.
>
> I think if you just check for that case, the test will then pass

Thank you for debugging this,  I did as you suggested and it passed that test!

>>
>> The test 21 in t9807 was precisely the new test added to test the
>> change (it was passing with local setup), the test log is truncated
>> before the output of test 21 in t9807 but I'm afraid I'm not very
>> familiar with Travis, so maybe I'm missing something. Is there a way
>> to have the full logs or they are always truncated after some number
>> of lines?
>
> For me, t9807 is working fine.
>
>>
>> I think you get an error with git diff --check because I added spaces
>> after a tab, but those spaces are intentional, the tabs are for the
>> "<<-EOF" and spaces are for the "p4 triggers" specificiation.
>
> OK.
>

In the end, ,the reason t9807 was not passing was precisely the tabs
and spaces of the patch. the original patch had:
<tab><tab><spaces>....., as I explained, the tabs were supposed to be
ignored by "<<-EOF" and the spaces were supposed to be sent to stdin
of p4 triggers, but when the patch was applied to upstream the
<spaces> were substituted by tabs what led to a malformed  "p4
trigger" description. I just collapsed the description in one single
line and now it's passing
>
> Luke


I'm sending a new patch with the two changes I just mentioned.

Thanks,
