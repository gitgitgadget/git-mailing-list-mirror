Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E483820D14
	for <e@80x24.org>; Fri,  2 Jun 2017 00:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751142AbdFBAWz (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 20:22:55 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33893 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbdFBAWy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 20:22:54 -0400
Received: by mail-qt0-f193.google.com with SMTP id l39so7747598qtb.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 17:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+LZzA5iX3aQWb1kgXtfjg7AjxLJWNzAiWC1ugjV1jfk=;
        b=qAcpOPlPu+xJ3Lb8HXEF7ZSIZDXGwQFiv/XGSATlcvX4V9ZjKASLyuDcdw+zn3VMS2
         PzrKVZduSzjkvEBS1+z/ULsb5wmSlJsJZbKSPPhipkKFPa4+iheC+qi2yZ/86hkpd2Ts
         38/sWzobAcNIMM5xxtx5DCWEDl2bHVIzmckSo5aacB3gRlcD1h19snfmx2MHG8Dwwbvh
         ZG/+SzYSVLMkP/PhYYXzIRfFUOjm4y4G1GUvKXI/cEKbVXSH031YcqSc5m/xxcJ9DuJm
         +dj1HPaKyQb3u3L8md8fw/AqGG512FQMVIxgKn2EZ2O242kNsObCHrPxqvrGsxaRtnXH
         izkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+LZzA5iX3aQWb1kgXtfjg7AjxLJWNzAiWC1ugjV1jfk=;
        b=IzjStLwAtxLKhtlvjo3qDwmmh7pqBG7srTBXc/i8lsxDc9e4fEA5U5PmP4YwQv8TwG
         SJsxLNLf8AxSLEW96B8NjoPXPvFZcuuV/K7GAvt+Cn07XPmEwTQyLZITKb6o/4NFZcW+
         mC/88IOoUe3ZysVdwyYWQhy1bzuFLQjBbbFB7VI1kTBYRaCws4VZ72sE0y+UrvdkVlDn
         4HZ/mHSyoUQrLm999CKZnzd7jXSLSsDt1Mz3WaRYA8HOS2L6lyK4smgEVGDyNJZ0Ivo8
         bnpjvP/1G0gIN8WMUShxOdsRd7wgbUICaKio1KGYEqO9XH73jQJ4ZDYsF9DEFtW4H3c2
         lblQ==
X-Gm-Message-State: AODbwcCJzJ92uI4oPcQ+Pi/leF7sJ+7km55c5L0g22JJDG8FLGWfb/AK
        AF4vMFxk1D7hyg==
X-Received: by 10.200.52.165 with SMTP id w34mr5417672qtb.77.1496362973260;
        Thu, 01 Jun 2017 17:22:53 -0700 (PDT)
Received: from zaya.teonanacatl.net (pool-71-113-173-254.hrbgpa.fios.verizon.net. [71.113.173.254])
        by smtp.gmail.com with ESMTPSA id l14sm13999155qtf.40.2017.06.01.17.22.51
        (version=TLS1_1 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 17:22:52 -0700 (PDT)
Date:   Thu, 1 Jun 2017 20:22:49 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jacob.keller@gmail.com
Subject: Re: [PATCH] send-email: check for repo before invoking hook
Message-ID: <20170602002249.GI25542@zaya.teonanacatl.net>
References: <CA+P7+xr39qk9qHE0=uU3HZE2wOhU9X7rmENoDfP=bp09j9N9Mg@mail.gmail.com>
 <20170601235055.22621-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20170601235055.22621-1-jonathantanmy@google.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Jonathan Tan wrote:
> Thanks for the notification. Here's a patch to fix that. 
> --- 
> git-send-email.perl   | 32 +++++++++++++++++--------------- 
> t/t9001-send-email.sh |  8 ++++++++ 
> 2 files changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl 
> index f0417f64e..94c54dc5a 100755 
> --- a/git-send-email.perl 
> +++ b/git-send-email.perl 
> @@ -1755,21 +1755,23 @@ sub unique_email_list { 
> sub validate_patch { 
> 	my $fn = shift;
>
> -	my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'), 
> -				    'sendemail-validate'); 
> -	my $hook_error; 
> -	if (-x $validate_hook) { 
> -		my $target = abs_path($fn); 
> -		# The hook needs a correct cwd and GIT_DIR. 
> -		my $cwd_save = cwd(); 
> -		chdir($repo->wc_path() or $repo->repo_path()) 
> -			or die("chdir: $!"); 
> -		local $ENV{"GIT_DIR"} = $repo->repo_path(); 
> -		$hook_error = "rejected by sendemail-validate hook" 
> -			if system($validate_hook, $target); 
> -		chdir($cwd_save) or die("chdir: $!"); 
> -	} 
> -	return $hook_error if $hook_error; 
> +	if ($repo) { 
> +		my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'), 
> +					    'sendemail-validate'); 
> +		my $hook_error; 
> +		if (-x $validate_hook) { 
> +			my $target = abs_path($fn); 
> +			# The hook needs a correct cwd and GIT_DIR. 
> +			my $cwd_save = cwd(); 
> +			chdir($repo->wc_path() or $repo->repo_path()) 
> +				or die("chdir: $!"); 
> +			local $ENV{"GIT_DIR"} = $repo->repo_path(); 
> +			$hook_error = "rejected by sendemail-validate hook" 
> +				if system($validate_hook, $target); 
> +			chdir($cwd_save) or die("chdir: $!"); 
> +		} 
> +		return $hook_error if $hook_error; 
> +	}

Would it be worth doing the $repo test when defining $validate_hook 
to avoid a layer of indentation?  Something like this (with whatever 
proper wrapping/indentation is used for perl, if I have that wildly 
incorrect, of course)?

-- >8 --
diff --git i/git-send-email.perl w/git-send-email.perl
index f0417f64e7..e78a0a728a 100755
--- i/git-send-email.perl
+++ w/git-send-email.perl
@@ -1755,8 +1755,9 @@ sub unique_email_list {
 sub validate_patch {
 	my $fn = shift;
 
-	my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'),
-				    'sendemail-validate');
+	my $validate_hook = $repo ?
+		catfile(catdir($repo->repo_path(), 'hooks'),
+			'sendemail-validate') : '';
 	my $hook_error;
 	if (-x $validate_hook) {
 		my $target = abs_path($fn);

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I have to decide between two equally frightening options.  If I wanted
to do that, I'd vote.
    -- Duckman

