From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6] commit: add a commit.verbose config variable
Date: Mon, 14 Mar 2016 17:21:19 -0400
Message-ID: <CAPig+cRC5kZCtELhTh3em0bv+mfeR58AKd3Y76VM+0J+C+zzcw@mail.gmail.com>
References: <0102015376e53b40-d25f7fdc-4ae1-4aae-b779-052fcf252071-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 22:21:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afZvZ-00089s-9X
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 22:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770AbcCNVVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 17:21:22 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:32863 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817AbcCNVVU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 17:21:20 -0400
Received: by mail-vk0-f68.google.com with SMTP id c3so15836973vkb.0
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=zw2kCzwdnbBwfjDJV7k6K/pYvQ5IenRv5oq+Wn7BF64=;
        b=ZkQ+aOx4uNOAJZO8ExGjnIM8xP2yfmrzTC2t7aky80UjDizIC2vIbAvR64HNi7Llxf
         tpuB23QfpwdTAfXxt+eMXf55PK0O2MbN74qAssL5SoLsteBKLDPsDuQJXljXuQQNBUhD
         P7hvXk2SnyppopFsZUal0kY3AxEfRUVEU+57icbrTGa38td0/38AtjpBMo8yS/1vROEk
         liYMoQvbt/Q/oMoyr7wDATuxhpkP3IXpE/JHIzjh18XpzCA2uuyWgK4BFkleGDz31ziQ
         LPw90hBnSPVRcOyXOP8piiMdOmg/KOdSpWfOvRXQdhrWL6WXTT58nxKmjcr8QI0R1g/P
         cjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=zw2kCzwdnbBwfjDJV7k6K/pYvQ5IenRv5oq+Wn7BF64=;
        b=cDyLQ1qI+/4u4MP8cDGmphrZiYRe6VpNeHMDaPjSiWOztXnyEZB6uFk92Nk3iCGqAe
         QY7LNjAoshowNvn+d9AGvMb9jKRDWkv22Vz12HuKLVTIKiEGCUya7y8uxhYXjDER8miY
         0x5vbZFT/ag123EEFyFYnwzzXtM66txI9avsFap5SWX9U5TXUnA2OaVmNEKO3/gmgJSf
         VMnkSrjqtjdGL78G61HJ2NUzMitLU26kY93dPI59i110HtqXLQDvfN/vC6o8s1QuZvKJ
         WjT55f01U/xvF4d//mLn5V1gCCXnDAUAF0NWo23gw71yP7yrbOELfSDqd9kD1WskA64W
         Bn/A==
X-Gm-Message-State: AD7BkJK2AC4QhqKeOLD3EA0SPx2poYbMKS2peuq5d+9mB2o621Pbj12t834w+j49hGGquy8JS/oJ7LZhXGoOBQ==
X-Received: by 10.31.141.2 with SMTP id p2mr27749625vkd.37.1457990479310; Mon,
 14 Mar 2016 14:21:19 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Mon, 14 Mar 2016 14:21:19 -0700 (PDT)
In-Reply-To: <0102015376e53b40-d25f7fdc-4ae1-4aae-b779-052fcf252071-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: tUDlllDZ2_nwXV4MFWheAGejDmo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288814>

On Mon, Mar 14, 2016 at 4:50 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Add commit.verbose configuration variable as a convenience for those
> who always prefer --verbose.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 2ddf28c..35960b4 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -96,4 +96,33 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
> +test_expect_success 'commit.verbose true and --verbose omitted' '
> +       git -c commit.verbose=true commit --amend
> +'
> +
> +test_expect_success 'commit.verbose true and --no-verbose' '
> +       test_must_fail git -c commit.verbose=true commit --amend --no-verbose
> +'
> +
> +test_expect_success 'commit.verbose false and --verbose' '
> +       git -c commit.verbose=false commit --amend --verbose
> +'
> +
> +test_expect_success 'commit.verbose false and --verbose omitted' '
> +       test_must_fail git -c commit.verbose=false commit --amend
> +'
> +
> +test_expect_success 'commit.verbose true and --verbose' '
> +       git -c commit.verbose=true commit --amend --verbose
> +'
> +
> +test_expect_success 'commit.verbose false and --no-verbose' '
> +       test_must_fail git -c commit.verbose=false commit --amend --no-verbose
> +'
> +
> +test_expect_success 'status ignores commit.verbose=true' '
> +       git status >actual &&

This is missing the important "-c commit.verbose=false". Without it,
you're not really testing anything interesting.

(It was missing in the "something like this" example test I typed
directly in the email of my last review[1], which I suppose is a good
lesson that "something like this" is not meant as "final" or "trust
this".)

[1]: http://article.gmane.org/gmane.comp.version-control.git/288774

> +       ! grep "^diff --git" actual
> +'
> +
>  test_done
