From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] t/t5520: test --[no-]autostash with pull.rebase=true
Date: Tue, 29 Mar 2016 17:16:06 -0400
Message-ID: <CAPig+cQ93+dCqJMRcQYSRHLDuYtwkeK_aSrfv2=2=g7ZhO85TQ@mail.gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-6-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 23:16:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al0zl-0007vj-IB
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 23:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbcC2VQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 17:16:08 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36022 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbcC2VQH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 17:16:07 -0400
Received: by mail-vk0-f66.google.com with SMTP id z68so3969447vkg.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 14:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=jkOxLvl1MMUUb0rqp7kNlX1RDlN+q1Wkq7e6Lo6vaQY=;
        b=xbVr7p5nm8Zmer41uRX6maiSgN3CMAQhtJt1XjM8rHu9HYz06FlWQl85KiBET3/N2H
         1w+L+yv9FMXXB+nEeq846dAokIdC8QB2i4xhGdfc3roxi8Cjx/g/Yta56OalbaOnMa5F
         8ziPNpfoQOls/JvaayCnnrs3hP634pdCr8DKiOAb2Tr1U2lRBAe7xFV/yQH4DHqTaTEK
         UiDxqJOWndg413h+GttDQbSWHcQwxB4xVoLpccI+VP+BgpK6HjwP4fVpofoRxTcYhlce
         qpWL2qnj4hijTdH8G3ezQFmvKtCufXAM5rR6Zuz0hM40ZzQNygVQatdKlTtIJeDRTGZw
         clKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jkOxLvl1MMUUb0rqp7kNlX1RDlN+q1Wkq7e6Lo6vaQY=;
        b=OZFCNb8sVtfraFm4OREHWWUm7LZkr3OoivIz7hZDRTbjvaL9yujth6GjYLFyw69IU3
         9GlAW/DE3W6A09X2JqYDAgVDtWNgUIDkZVKRr1g7ioMY3q8hlwu9pwP8u59qDI/Rk2g7
         wgwtsdFzEz7A7hYcmT9bQCs9kUvQ4VgnbSootA7DiniEjhDo8XnJZI/RrGPM+L81E9i3
         mEg/YYc8qYzkaY/vvU7mEnnCTtrKNN4iTs6LmXX5ZVcOTlg53HOTBTiIc2/dsB4UKWfq
         P84K/dmrxuFILjyCEmGutoPZRXMFfJTIBcQEh4jS77R2elpHFHGs7OWhYYmX0TQV1xBp
         CFYg==
X-Gm-Message-State: AD7BkJIeONTgKeKXzcMpRcvzMvlC7RLIKLf4+2jnd7GSaOS1lm7UykuKRP7Y/+2sAq3mhGtKfJbw6/i2ZZmPDg==
X-Received: by 10.159.36.172 with SMTP id 41mr2785095uar.123.1459286166646;
 Tue, 29 Mar 2016 14:16:06 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 14:16:06 -0700 (PDT)
In-Reply-To: <1459258200-32444-6-git-send-email-mehul.jain2029@gmail.com>
X-Google-Sender-Auth: BDP9qe_hch8KgOkSJzJwkD-tn-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290196>

On Tue, Mar 29, 2016 at 9:30 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> "--[no-]autostash" option for git-pull is only valid in rebase mode.
> That is, either --rebase is used or pull.rebase=true. Existing tests
> already check the cases when --rebase is used but fails to check for
> pull.rebase=true case.
>
> Add two new tests to check that --[no-]autostash option works with
> pull.rebase=true.
>
> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> @@ -316,6 +316,26 @@ test_expect_success 'pull.rebase' '
> +test_expect_success 'pull --autostash & pull.rebase=true' '
> +       test_config pull.rebase true &&
> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       git pull --autostash . copy &&
> +       test_cmp_rev HEAD^ copy &&
> +       test "$(cat new_file)" = dirty &&
> +       test "$(cat file)" = "modified again"
> +'

With the exception of the missing --rebase argument, this is exactly
the same code as in test_rebase_autostash(), right? Rather than
repeating this code yet again, it might be nice to augment that
function to accept a (possibly) optional argument controlling whether
--rebase is used.

> +
> +test_expect_success 'pull --no-autostash & pull.rebase=true' '
> +       test_config pull.rebase true &&
> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       test_must_fail git pull --no-autostash . copy 2>err &&
> +       test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
> +'

Ditto with regard to test_rebase_no_autostash() (or
test_rebase_autostash_fail() as I suggested in my patch 4/5 review).
