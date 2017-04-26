Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E41F207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 02:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1948820AbdDZCIZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 22:08:25 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36822 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948632AbdDZCIX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 22:08:23 -0400
Received: by mail-pf0-f196.google.com with SMTP id v14so12298148pfd.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 19:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fw/uPr0SUAi0WhaUt17cj38r4fEig5fd0I4OmaOSw94=;
        b=nbVWeXkn3ldwiTZRM4iTExB4TCb3I23cEWe3U9Z1y6mbqyc6a/2Ym4seAsZOIPPXyS
         dgCAro9GmRiA3JHqU82h9ao7ey7UwLoNoRFCSuS3W8fIzALvp7eZqO8I27Furik33Egq
         9stkVqigB5//JHQt1N2uTl5z+48sTWQJrbVd5NShlbcwQz3crmlf1pWl7LKJZGGd9Dun
         Pvo0CdJIcf6DxE0kmpXVQYLVWlnE3jM1mC0rskcUlP+J6VxVgY+AQvyFM5s/VPDP4j80
         tJQMBTgsipFzCK+p72Bkn8YeVzDJ04xeEKadcHxMR5oqChKA2xsEKTYMKzKHrJyzFdtV
         bqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fw/uPr0SUAi0WhaUt17cj38r4fEig5fd0I4OmaOSw94=;
        b=VjG8nyF//BOPBoS4QuFD70d+te2iSNgLWCSBVgiduHTUO31K0/33H6ymvI/bcPWnyC
         BaValVFweteBAdxE4rHtmUUyd4xQn1LhrHI/y8KVl+WXnZFoBBNacxDRe2XUEtqAcvCV
         p/FOWXipj/aua28PCfRfWPuCqLDa9fQ6iLMTa78WMHGJCF/+K5l9O51RrngBE0sE1Qj1
         VxDlR10PkYmlpDJVCIblnbh2JQJIsgtXcxkzoz9r3Thd2M0E7Pu/f51upTq9oykE8n/K
         0PxJiRmj8GHiweP4mQrZl6b191LN9w4AxWgRj2zd4G6OKk9NTKS6vi9fB1FylSiMWBHM
         H8AQ==
X-Gm-Message-State: AN3rC/5/joo/6XBAwXGM3HHbL0X5kcSJXQhah0+LCbmk+ZATNXxQi6ce
        jQ4lwIglUuEw+w==
X-Received: by 10.98.24.213 with SMTP id 204mr29729747pfy.237.1493172502775;
        Tue, 25 Apr 2017 19:08:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id 76sm24582374pgf.28.2017.04.25.19.08.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 19:08:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, computersforpeace@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] sequencer: require trailing NL in footers
References: <20170425190651.8910-1-jonathantanmy@google.com>
        <20170425235741.32546-1-jonathantanmy@google.com>
        <20170426000741.GS28740@aiede.svl.corp.google.com>
Date:   Tue, 25 Apr 2017 19:08:20 -0700
In-Reply-To: <20170426000741.GS28740@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Tue, 25 Apr 2017 17:07:41 -0700")
Message-ID: <xmqqinlrudij.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Tan wrote:
>
>> Reported-by: Brian Norris <computersforpeace@gmail.com>
>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>> ---
> [...]
>>  sequencer.c              | 11 +++++++++++
>>  t/t3511-cherry-pick-x.sh | 14 ++++++++++++++
>>  2 files changed, 25 insertions(+)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> This is still pretty subtle (using the added newline that is added after
> a non-footer to turn the invalid footer into a valid one), but
>
>  * it is clear from the code that it will work correctly
>  * the new test ensures we'll continue to support this case
>  * it is understandable after a little head scratching
>  * I'm hoping the subtlety will go away once the code learns to deal
>    with ordinary non-footer text that has a missing newline

Hmph, perhaps we need another test that documents a known failure as
well in the meantime?

> [...]
>> --- a/t/t3511-cherry-pick-x.sh
>> +++ b/t/t3511-cherry-pick-x.sh
>> @@ -208,6 +208,20 @@ test_expect_success 'cherry-pick -x -s adds sob even when trailing sob exists fo
>>  	test_cmp expect actual
>>  '
>>  
>> +test_expect_success 'cherry-pick -x handles commits with no NL at end of message' '
>> +	pristine_detach initial &&
>> +	sha1=$(printf "title\n\nSigned-off-by: a" | git commit-tree -p initial mesg-with-footer^{tree}) &&
>
> nit: Should this use a more typical sign-off line with an email
> address, to avoid a false-positive success in case git becomes more
> strict about its signoffs in the future?
>
> Something like
>
> 	printf "title\n\nSigned-off-by: S. I. Gner <signer@example.com>" >msg &&
> 	sha1=$(git commit-tree -p initial mesg-with-footer^{tree} <msg) &&
> 	...

That is a good point and has an added benefit that the test script
becomes easier to follow.

 t/t3511-cherry-pick-x.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 6f518020b2..c2b143802d 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -210,12 +210,14 @@ test_expect_success 'cherry-pick -x -s adds sob even when trailing sob exists fo
 
 test_expect_success 'cherry-pick -x handles commits with no NL at end of message' '
 	pristine_detach initial &&
-	sha1=$(printf "title\n\nSigned-off-by: a" | git commit-tree -p initial mesg-with-footer^{tree}) &&
+	signer="S. I. Gner <signer@example.com>" &&
+	printf "title\n\nSigned-off-by: %s" "$signer" >msg &&
+	sha1=$(git commit-tree -p initial mesg-with-footer^{tree} <msg) &&
 	git cherry-pick -x $sha1 &&
 	cat <<-EOF >expect &&
 		title
 
-		Signed-off-by: a
+		Signed-off-by: $signer
 		(cherry picked from commit $sha1)
 	EOF
 	git log -1 --pretty=format:%B >actual &&
