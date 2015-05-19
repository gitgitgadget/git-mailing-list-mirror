From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv3 3/3] git-p4: tests: use test-chmtime in place of touch
Date: Tue, 19 May 2015 23:36:32 +0100
Message-ID: <555BBAF0.7070008@diamand.org>
References: <xmqqa8x0a7wq.fsf@gitster.dls.corp.google.com> <1432074198-13806-1-git-send-email-luke@diamand.org> <1432074198-13806-4-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 00:37:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuq8Q-00018u-LI
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbbESWhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:37:10 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36533 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbbESWhI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:37:08 -0400
Received: by wizk4 with SMTP id k4so134813464wiz.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 15:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZosU8itW0rLrwESx+zP21IPXPTP7tRqVR6il33xVxbE=;
        b=M4qhDzYWj42gqkTIUKUvoBZBnAxK+UgxuZcD5PNoSP9ug6Wx/sS3xwbjUdYKEoijrF
         Ob7jpL8n4Xwnqyr/ngL9KNvx7szyA97VhmpBcHleJqz00KxugkCsReso74Harz7oaBRN
         bJh1fLtG5dO+RgXaubiYEw8HAaY5ItOr0wGLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ZosU8itW0rLrwESx+zP21IPXPTP7tRqVR6il33xVxbE=;
        b=aF7uvIVxtmDC3UBCZ8ij6bViUCBW1j9yMyBjWn23ruHBq84chsETgGgl6/sUuXL4oF
         pKWRCw/5D834dBxYCbx1wYhgJ55AYVT+k05rzp5G+DtpYpfIWCieHG1KWvp+lYsxvGo+
         wUbAby4CeLV3Sxif90S2h3uBsEdEy7bAbYMwRyeIOs5H4UvYNx8roxu9HC6BJCJRfnUG
         1XiZDo5wTU9loIZOKwDP4Zd+fZZFz47X0yUmyDl9kgN72x7iaTlbiw8bsHoGNPB1nF8f
         Ep76zjwYBn17EBr0raoPkoDAqgr3cuxwG0FeDHw5qUG8BN4DexkEZfV77dqv/cwxZVq/
         XXSA==
X-Gm-Message-State: ALoCoQn2LsfEyBCya3mmo7d+ds7VTqWEkcM+Pqm3WRUq1tl6WFrLTWgS2QlTIcHejxsrfmqWtxZS
X-Received: by 10.180.103.231 with SMTP id fz7mr35682641wib.35.1432075027259;
        Tue, 19 May 2015 15:37:07 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id g14sm23750652wjs.47.2015.05.19.15.37.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2015 15:37:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1432074198-13806-4-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269430>

On 19/05/15 23:23, Luke Diamand wrote:
> Using "touch" for P4EDITOR means that the tests can be a bit
> racy, since git-p4 checks the timestamp has been updated and
> fails if the timestamp is not updated.

Junio - this one is incorrect where it changes t9805 around the test 
called "no config, unedited, say yes" (it didn't need changing at all).

I can resend all three, or just the last one. Please let me know which 
is easier.

Thanks
Luke


>
> Use test-chmtime instead, which is designed for this.
>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>   t/t9803-git-p4-shell-metachars.sh  | 4 ++--
>   t/t9805-git-p4-skip-submit-edit.sh | 2 +-
>   t/t9813-git-p4-preserve-users.sh   | 7 ++++---
>   3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-metachars.sh
> index fbacff3..d950c7d 100755
> --- a/t/t9803-git-p4-shell-metachars.sh
> +++ b/t/t9803-git-p4-shell-metachars.sh
> @@ -28,7 +28,7 @@ test_expect_success 'shell metachars in filenames' '
>   		echo f2 >"file with spaces" &&
>   		git add "file with spaces" &&
>   		git commit -m "add files" &&
> -		P4EDITOR=touch git p4 submit
> +		P4EDITOR="test-chmtime +5" git p4 submit
>   	) &&
>   	(
>   		cd "$cli" &&
> @@ -47,7 +47,7 @@ test_expect_success 'deleting with shell metachars' '
>   		git rm foo\$bar &&
>   		git rm file\ with\ spaces &&
>   		git commit -m "remove files" &&
> -		P4EDITOR=touch git p4 submit
> +		P4EDITOR="test-chmtime +5" git p4 submit
>   	) &&
>   	(
>   		cd "$cli" &&
> diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
> index 5fbf904..dc8fc0c 100755
> --- a/t/t9805-git-p4-skip-submit-edit.sh
> +++ b/t/t9805-git-p4-skip-submit-edit.sh
> @@ -17,7 +17,6 @@ test_expect_success 'init depot' '
>   	)
>   '
>
> -# this works because P4EDITOR is set to true

The above line shouldn't be removed, but it's worth noting that it gets 
set to true in lib-git-p4.sh.

>   test_expect_success 'no config, unedited, say yes' '
>   	git p4 clone --dest="$git" //depot &&
>   	test_when_finished cleanup_git &&
> @@ -25,6 +24,7 @@ test_expect_success 'no config, unedited, say yes' '
>   		cd "$git" &&
>   		echo line >>file1 &&
>   		git commit -a -m "change 2" &&
> +		P4EDITOR="test-chmtime +5" &&

The above line should not be added.

>   		echo y | git p4 submit &&
>   		p4 changes //depot/... >wc &&
>   		test_line_count = 2 wc
> diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
> index 166b840..fe65788 100755
> --- a/t/t9813-git-p4-preserve-users.sh
> +++ b/t/t9813-git-p4-preserve-users.sh
> @@ -53,7 +53,8 @@ test_expect_success 'preserve users' '
>   		git commit --author "Alice <alice@example.com>" -m "a change by alice" file1 &&
>   		git commit --author "Bob <bob@example.com>" -m "a change by bob" file2 &&
>   		git config git-p4.skipSubmitEditCheck true &&
> -		P4EDITOR=touch P4USER=alice P4PASSWD=secret git p4 commit --preserve-user &&
> +		P4EDITOR="test-chmtime +5" P4USER=alice P4PASSWD=secret &&
> +		git p4 commit --preserve-user &&
>   		p4_check_commit_author file1 alice &&
>   		p4_check_commit_author file2 bob
>   	)
> @@ -69,7 +70,7 @@ test_expect_success 'refuse to preserve users without perms' '
>   		git config git-p4.skipSubmitEditCheck true &&
>   		echo "username-noperms: a change by alice" >>file1 &&
>   		git commit --author "Alice <alice@example.com>" -m "perms: a change by alice" file1 &&
> -		P4EDITOR=touch P4USER=bob P4PASSWD=secret &&
> +		P4EDITOR="test-chmtime +5" P4USER=bob P4PASSWD=secret &&
>   		export P4EDITOR P4USER P4PASSWD &&
>   		test_must_fail git p4 commit --preserve-user &&
>   		! git diff --exit-code HEAD..p4/master
> @@ -87,7 +88,7 @@ test_expect_success 'preserve user where author is unknown to p4' '
>   		git commit --author "Bob <bob@example.com>" -m "preserve: a change by bob" file1 &&
>   		echo "username-unknown: a change by charlie" >>file1 &&
>   		git commit --author "Charlie <charlie@example.com>" -m "preserve: a change by charlie" file1 &&
> -		P4EDITOR=touch P4USER=alice P4PASSWD=secret &&
> +		P4EDITOR="test-chmtime +5" P4USER=alice P4PASSWD=secret &&
>   		export P4EDITOR P4USER P4PASSWD &&
>   		test_must_fail git p4 commit --preserve-user &&
>   		! git diff --exit-code HEAD..p4/master &&
>
