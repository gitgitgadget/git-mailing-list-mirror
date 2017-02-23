Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2671C2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 20:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751358AbdBWU6n (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 15:58:43 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35669 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdBWU6m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 15:58:42 -0500
Received: by mail-pg0-f66.google.com with SMTP id 1so304806pgz.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 12:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aQYiow5WvpmOODgECim6sPVPDlMTqAx+Tm7T8K1CIaE=;
        b=KxsfbxlZ0+PzJPoSFsybJH0oJx3S8uXp4Va2qKImrJfjnVnxwHrXejbBXc+q687w0P
         JLpfmifubrlJ9uBeJDdHFGYySWILHaJraVfniGVNi0tpaAD6DHg+DHUxLpOOlvhAzWRl
         WtxGyrBDIKzNZED9W+FxtBztBkEZzdbvmkPi64YJhvuEGECDbCiAqre3jrBnHkcvhAI+
         5Sn+32iCRWS6UeE4zC6FvDrfWtPuMDKKWM7NbdTJ3coNbd6WCtjxxakeDTmbwFrFbc9F
         RUWg1UC446qClF2ehEMb19kgQ/yRa4zqWa9B/FFI2kEz/KFToDBY1GhT84lfqNcRmB4G
         dUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aQYiow5WvpmOODgECim6sPVPDlMTqAx+Tm7T8K1CIaE=;
        b=o8YyhPg12HBuUD1IkWzSx1HfEa8VGzbMxk9wpHQ3jUiJXr5uewv8XZLZhDiCZAHZ4W
         iIjBRbPCsHbzgeLQZuTpfmn1bQNKBs9Ljv5PEXxA61Dwz3f0a+4P3Zd1rKbhiLEr4Dak
         wCwBX6IJWDeb49ZS2bZ3F+xT4b7PoPmayZxVW7vmfUt8RZNq7H4sNENYWJYCq8DhZ4K8
         aDUq6lcKXP3rzVWJrKn2bV9+GTKaGYK/9EuPrPsErZzryvhYYDk9gH3CDDnXfnn7ikcg
         KZRLTwmGCIaCQPjiek6ssAZpx0TFHRs88nljbW1s1L5hpnQmrr+nYBcUERNvUWUDmCe9
         zgWw==
X-Gm-Message-State: AMke39miJOrr6fxpBSlYKMxnMe+VY7hUFaJGI6aTmxA8+QSmB1K/LIn1YwLmyg/v3B+zcw==
X-Received: by 10.98.62.219 with SMTP id y88mr12101375pfj.62.1487883521349;
        Thu, 23 Feb 2017 12:58:41 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id f78sm11354908pfe.116.2017.02.23.12.58.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 12:58:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     bs.x.ttp@recursor.net, git@vger.kernel.org
Subject: Re: [PATCH 4/4] ident: do not ignore empty config name/email
References: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
        <20170223081708.ge34zjkmpsolocqx@sigill.intra.peff.net>
Date:   Thu, 23 Feb 2017 12:58:39 -0800
In-Reply-To: <20170223081708.ge34zjkmpsolocqx@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 23 Feb 2017 03:17:08 -0500")
Message-ID: <xmqqfuj47hfk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This one is perhaps questionable. Maybe somebody is relying on setting a
> per-repo user.name to override a ~/.gitconfig value and enforce
> auto-detection?

Thanks for splitting this step out.  1/4 and 2/4 are obvious
improvements, and 3/4 is a very sensible fix.  Compared to those
three, this one does smell questionable, because I do not quite see
any other reasonable fallback other than the auto-detection if the
user gives an empty ident on purpose.  

Erroring out to say "don't do that" is probably not too bad, but
perhaps we are being run by a script that is doing a best-effort
conversion from $ANOTHER_SCM using a list of known authors that is
incomplete, ending up feeding empty ident and allowing us to fall
back to attribute them to the user who runs the script.  I do not
see a point in breaking that user and having her or him update the
script to stuff in a truly bogus "Unknown <unknown>" name.

>
>  ident.c                       |  4 ++--
>  t/t7518-ident-corner-cases.sh | 11 +++++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/ident.c b/ident.c
> index ead09ff7f..c0364fe3a 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -153,7 +153,7 @@ static void copy_email(const struct passwd *pw, struct strbuf *email,
>  
>  const char *ident_default_name(void)
>  {
> -	if (!git_default_name.len) {
> +	if (!(ident_config_given & IDENT_NAME_GIVEN) && !git_default_name.len) {
>  		copy_gecos(xgetpwuid_self(&default_name_is_bogus), &git_default_name);
>  		strbuf_trim(&git_default_name);
>  	}
> @@ -162,7 +162,7 @@ const char *ident_default_name(void)
>  
>  const char *ident_default_email(void)
>  {
> -	if (!git_default_email.len) {
> +	if (!(ident_config_given & IDENT_MAIL_GIVEN) && !git_default_email.len) {
>  		const char *email = getenv("EMAIL");
>  
>  		if (email && email[0]) {
> diff --git a/t/t7518-ident-corner-cases.sh b/t/t7518-ident-corner-cases.sh
> index 3d2560c3c..ef570ac62 100755
> --- a/t/t7518-ident-corner-cases.sh
> +++ b/t/t7518-ident-corner-cases.sh
> @@ -22,4 +22,15 @@ test_expect_success 'commit rejects all-crud name' '
>  		git commit --allow-empty -m foo
>  '
>  
> +# We must test the actual error message here, as an unwanted
> +# auto-detection could fail for other reasons.
> +test_expect_success 'empty configured name does not auto-detect' '
> +	(
> +		sane_unset GIT_AUTHOR_NAME &&
> +		test_must_fail \
> +			git -c user.name= commit --allow-empty -m foo 2>err &&
> +		test_i18ngrep "empty ident name" err
> +	)
> +'
> +
>  test_done
