From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 7/7] t5520: test --[no-]autostash with pull.rebase=true
Date: Sun, 3 Apr 2016 16:11:07 -0400
Message-ID: <CAPig+cQd93yUhog5h6qBrJEE_g+7-XLpSLQmDqYf7yh7Vr3Z3Q@mail.gmail.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
	<1459619912-5445-8-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 22:11:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amoMc-00041e-Cz
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 22:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbcDCULJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 16:11:09 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:36555 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbcDCULI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 16:11:08 -0400
Received: by mail-ig0-f196.google.com with SMTP id kb1so650193igb.3
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=htdstyg0T4QQWk+MhaDuDeEIoQYcOpHhu8+sI2z4RDA=;
        b=RgLJ3N46RyI4JFXSgayQbSaR3krlw5QXJ//7VRoF84Kglb+bol4dPa4AmfB5CLedYJ
         UWPgfYFi8qd5OFLci9YQJ3m/uPeUUlVD3PLjiMxIWpS13Bp86LrXgRa8qc3EMu+BwQ/y
         9OFJIWjCyh4f03eL2YxYsNuuz506JtVihPw7N0dSsqoy+Ik5Sektudh5XGOBkfsIfF6D
         hx0VoNPenBc0dWd9awOtOVEBot15c8lNMWSMUyYyGZZbPmK+dOEBMosIKDU7GrvvqEOm
         KioGuucV0fsWvHOufXO37O4LQkElk5hRJ6ZhYTIbXro7Tm6Sm3do+nHo0dk9N4479SSr
         d9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=htdstyg0T4QQWk+MhaDuDeEIoQYcOpHhu8+sI2z4RDA=;
        b=HfaH+7mxGxUXUSKmOd7HaWXa7DFsEob542eyjxkTBIfdABQk/uHttVmrApVuld0x3j
         kD6ZCEKdJmFif9fIfP9jJ+a6E9ZdPmqJ2nPBaN5y3gLSrdBGlUCGoVqaFJM8LKFedKpg
         /RNbqraBoPQin+iwx7lAa14DJDNYnAqWu43ETuFnFCSsL1sqgoA8Ei7upUGIHb0bjtUt
         zCHhY6sZJYF+r0nZEEX6lA/gxFZKI7iTgE1AeypumHhJS4ZHHjTBXnavHr8RMMxUnXrQ
         +d9d1sYifvqpxmZaVY/E0zyzAm9+Ah083WEd9owfE0+W/PR2EA63+Y2hMr/P23Yiw5d8
         +Z4A==
X-Gm-Message-State: AD7BkJIbRDbvNDxeruWQcbzDjxLFosh97ZYVBaqitc642af4sQ/k0oylrDONe8nuSSErhZXg5RptY7lomVNHEA==
X-Received: by 10.107.130.138 with SMTP id m10mr6816924ioi.34.1459714267473;
 Sun, 03 Apr 2016 13:11:07 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 13:11:07 -0700 (PDT)
In-Reply-To: <1459619912-5445-8-git-send-email-mehul.jain2029@gmail.com>
X-Google-Sender-Auth: Rta929Z9vZ3Iw3xjpolQroAL9PM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290651>

On Sat, Apr 2, 2016 at 1:58 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> "--[no-]autostash" option for git-pull is only valid in rebase mode(

s/"--[no-]autostash"/The --[no-]autostash/

Also, move the '(' from the end of the line to the beginning of the next line.

> i.e. either --rebase should be used or pull.rebase=true). Existing
> tests already check the cases when --rebase is used but fails to check
> for pull.rebase=true case.
>
> Add two new tests to check that --[no-]autostash option works with
> pull.rebase=true.

Nicely explained.

> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
>  t/t5520-pull.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index e12af96..bed75f5 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -314,6 +314,16 @@ test_expect_success 'pull.rebase' '
>         test new = "$(git show HEAD:file2)"
>  '
>
> +test_expect_success 'pull --autostash & pull.rebase=true' '
> +       test_config pull.rebase true &&
> +       test_pull_autostash --autostash
> +'
> +
> +test_expect_success 'pull --no-autostash & pull.rebase=true' '
> +       test_config pull.rebase true &&
> +       test_pull_autostash_fail --no-autostash
> +'
> +
>  test_expect_success 'branch.to-rebase.rebase' '
>         git reset --hard before-rebase &&
>         test_config branch.to-rebase.rebase true &&
> --
> 2.7.1.340.g69eb491.dirty
