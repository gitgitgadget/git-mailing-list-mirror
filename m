Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08F8020195
	for <e@80x24.org>; Thu, 21 Jul 2016 06:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbcGUGop (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 02:44:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36573 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbcGUGoo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2016 02:44:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so1313908wma.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 23:44:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=c8llOumKuU//55gefHVQcg3lF9wKKWxa9m5vGfWzhsg=;
        b=c0s2pWSZO0u3pIYqSlRaXuXY7vrBkXa2y28IquaLaMkCe7A6MIn7AE66nZw59Nf+Uj
         UwW8VLWtiPHqc33FFdKHzhdSVKXScAIqwcVl2oNcHKL/vRn/H8xpn9uPTCnz/XTGEo+9
         gZ2vdv0OPHVOJAD9cKppTakF5SNNjAwbPreOSJrr5ZrNQmpZ4/w08BirKkzO2oUSy67s
         Mj3RxK2pezVR8ft34vYRnWZz4ML3lgHy+QvTYeCjkuMdtX9Riqoe40hGZ6yj99rYyKBM
         WS0h3OAwJQwhfsIfxY63PfJIEXs2tN67C3QZ3TrpyhjekndgLbWU8ekDdkZzDdiccxmM
         pPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=c8llOumKuU//55gefHVQcg3lF9wKKWxa9m5vGfWzhsg=;
        b=bjRmSdd0xevjQ2f316TVBQPiT3KW80FO9SYPqKym2/WD/ckeX3qZ3K3foWZIbh/cuq
         yjOMlGeKjQzREiUnLt4poIFZDg7LyqjqdRcaKFvepdr6ZV5t5ykiNnG+n3VYc9ipX0LT
         hNTsNmf61RCP75LX50nyNIxp5E6OCGjPGS9qzjTLHrSUJqyOsSUD/KEuS0LbnHXI3S9B
         ncggz/KTeImTl5KW+FxPwM5b8Hw/lfMmjakCeKAX7S/DFtgbEbV+XO9bgiXpw9ezX0nU
         Epv80cbrhtgbPDbVwtJgnaHVkvCOpM057PKd5rxOFJFYUzVOKr8iZBhTRBe0rbZX8MhF
         /m8g==
X-Gm-Message-State: ALyK8tLWu8CUvacWwPgKJLJS6SRNuF8/FojPDlczRdEoJ8uaoFDgyntgAgbc0ymaMpYY8A==
X-Received: by 10.28.157.214 with SMTP id g205mr15826823wme.34.1469083482874;
        Wed, 20 Jul 2016 23:44:42 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB7915.dip0.t-ipconnect.de. [93.219.121.21])
        by smtp.gmail.com with ESMTPSA id u2sm4772991wjk.32.2016.07.20.23.44.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jul 2016 23:44:42 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] t5541: fix url scrubbing test when GPG is not set
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160720113226.GA18700@sigill.intra.peff.net>
Date:	Thu, 21 Jul 2016 08:44:40 +0200
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <CF132DC4-39D8-42EB-97AC-975E4018E39C@gmail.com>
References: <xmqqk2ghdysg.fsf@gitster.mtv.corp.google.com> <CBEE46F3-5497-43D6-BA5A-217C7AD55B48@gmail.com> <20160720113226.GA18700@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 20 Jul 2016, at 13:32, Jeff King <peff@peff.net> wrote:

> On Wed, Jul 20, 2016 at 10:20:33AM +0200, Lars Schneider wrote:
> 
>>> * jk/push-scrub-url (2016-07-14) 1 commit
>>> (merged to 'next' on 2016-07-19 at 6ada3f1)
>>> + push: anonymize URL in status output
>> 
>> t5541-http-push-smart.sh "push status output scrubs password" fails on 
>> next using Travis CI OS X:
>> https://travis-ci.org/git/git/jobs/145960712
>> https://api.travis-ci.org/jobs/145960712/log.txt?deansi=true (non JS)
>> 
>> I think the test either fails because of OS X or because of the
>> used Apache version (Travis CI Linux uses 2.2.22 and OS X uses 2.2.26).
>> I haven't done any further investigation.
> 
> It's the lack of GPG. Here's a patch.

The tests pass with this patch!

Thanks,
Lars


> 
> -- >8 --
> Subject: t5541: fix url scrubbing test when GPG is not set
> 
> When the GPG prereq is not set, we do not run test 34. That
> test changes the directory of the test script as a side
> effect (something we usually frown on, but which matches the
> style of the rest of this script). When test 35 (the
> url-scrubbing test) runs, it expects to be in the directory
> from test 34. If it's not, the test fails; we are in a
> different sub-repo, our test-commit is built on a different
> history, and the push becomes a non-fast-forward.
> 
> We can fix this by unconditionally moving to the directory
> we expect (again, against our usual style but matching how
> the rest of the script operates).
> 
> As an additional protection, let's also switch from "make a
> new commit and push to master" to just "push to a new
> branch". We don't care about the branch name; we just want
> _some_ ref update to trigger the status output. Pushing to a
> new branch is less likely to run into problems with
> force-updates, changing the checked-out branch, etc.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> t/t5541-http-push-smart.sh | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> index 8068bd2..4840c71 100755
> --- a/t/t5541-http-push-smart.sh
> +++ b/t/t5541-http-push-smart.sh
> @@ -369,8 +369,10 @@ test_expect_success GPG 'push with post-receive to inspect certificate' '
> '
> 
> test_expect_success 'push status output scrubs password' '
> -	test_commit scrub &&
> -	git push --porcelain "$HTTPD_URL_USER_PASS/smart/test_repo.git" >status &&
> +	cd "$ROOT_PATH/test_repo_clone" &&
> +	git push --porcelain \
> +		"$HTTPD_URL_USER_PASS/smart/test_repo.git" \
> +		+HEAD:scrub >status &&
> 	# should have been scrubbed down to vanilla URL
> 	grep "^To $HTTPD_URL/smart/test_repo.git" status
> '
> -- 
> 2.9.2.505.g2705bb6
> 

