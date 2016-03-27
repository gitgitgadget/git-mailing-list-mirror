From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 2/3] t7507-commit-verbose: store output of grep in a file
Date: Sat, 26 Mar 2016 23:07:18 -0400
Message-ID: <CAPig+cRQ5hOLi3539Emq=YexHRXqdesf+Yo2cY+NkiPO_9Vhyg@mail.gmail.com>
References: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
	<01020153b478cf9b-1417ac08-005c-4d72-91f1-0b07f00a24d5-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 05:07:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ak12y-000361-Sb
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 05:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbcC0DHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2016 23:07:21 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36191 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526AbcC0DHU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2016 23:07:20 -0400
Received: by mail-vk0-f67.google.com with SMTP id z68so11508753vkg.3
        for <git@vger.kernel.org>; Sat, 26 Mar 2016 20:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=5YG1vqcdvM61Cr3LqF4k8xP5MibFBDW2GKJ0kUjN6e4=;
        b=DFyaOnztGch2Bp8D6SuDlrPUIalSXySgeNiADTbqg5PRanE6DaY/CHn06Ej7Axq4CI
         HRdyhb0DHaLZappeFZJeg3aFvpZfkszOueQRBAJPOFQE5Eyd5jsQCq3dqsAQjb3P9Ppz
         u0Qx6lGkYiD12p0VHyJGJHCEiIsu2eFuy/JhwICHK8vPA3tqpyLZVk49CFsH5EcN2NCn
         nMdXMe/ZvRKqmGBycSP6zstzhkfMxxTO3DmtCjE0mGHpp5BP8JuN+q7I5catuytvvr5j
         A83x/xIPptxtuy4eEmI+JPn3FCY+sUtvRaT2ZQQ+i/40rryRWE6BN2H3mlOUc/nfBrkv
         8rcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=5YG1vqcdvM61Cr3LqF4k8xP5MibFBDW2GKJ0kUjN6e4=;
        b=jGFWx1nBvE3bfStUNv9XC2BSSjG/MFNHQXalhic0a9cpMSDXLiIHgk8+5JSygh7FnR
         SwGcsKBL6VBp4GxvXkBof5/KCtWZUtvSowuoUJXskVJhR+osNpttJ4IMQWBzvwV/wnOY
         K5CNuaVLqBQWSzmvm31gaV9zpHhcGzjoFwlGuESlRfnVhrp1v001aK1SEs1Rqn0i+f1s
         5kwMrVXP91BsG1WCMC16VWowSuxozEvUhkKwoIHBtdISv1oP7wZeiZVgdBLES7AnHBx4
         IURNKgKUU3TRq2/rzU06neGo+uoCk3lhD7yHj1zf03S7ch057oTrJGv4/Bc3CnW/Cy5c
         41/A==
X-Gm-Message-State: AD7BkJJhfyeCJ/XOy4yJgtBfGzkxZoi4wMn4is7qNtWuveTV3oUduV6bXHkruDGCGAID3QEZcr8kyL3dN1C/rg==
X-Received: by 10.159.37.101 with SMTP id 92mr10918644uaz.66.1459048038889;
 Sat, 26 Mar 2016 20:07:18 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sat, 26 Mar 2016 20:07:18 -0700 (PDT)
In-Reply-To: <01020153b478cf9b-1417ac08-005c-4d72-91f1-0b07f00a24d5-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: 0y7ls_bmowYdA5imd7IJWbymDFs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289992>

On Sat, Mar 26, 2016 at 3:48 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> So that we can see how many diffs were contained in the message and use
> them in individual tests where ever it is required. Also use
> write_script() to create the fake "editor".

It is important to explain *why* you want to be able to count how many
diffs were in the editor message. In particular, you will be adding
new tests in a subsequent patch which will expect a specific number of
diffs (rather than any number of diffs)

Also, you need to explain why you're changing the existing tests to
count the number of diffs. Is it simply "because you can" or is it
because you suspect that a change you're making in a subsequent patch
might accidentally cause too many diffs to show up in the existing
test cases?

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> @@ -3,9 +3,11 @@
> -cat >check-for-diff <<EOF
> -#!$SHELL_PATH
> -exec grep '^diff --git' "\$1"
> +write_script "check-for-diff" <<'EOF' &&

The 'EOF' is more commonly written as \EOF in Git test scripts.

> +! test -s out ||
> +rm out &&

Why not just "rm -f out"? But, more importantly, why do you need to
remove the file at all? The '>' redirection operator (used below) will
overwrite the file, so no need to remove it beforehand.

> +! grep '^diff --git' "$1" ||
> +grep '^diff --git' "$1" >out

Um, what? Why two greps? I would have expected you to simply re-use
the existing grep (minus the backslash) while adding the redirection:

    -exec grep '^diff --git' "\$1"
    +exec grep '^diff --git' "$1" >out

Am I missing something obvious?

>  EOF
>  chmod +x check-for-diff

Mentioned previously[1]: Drop the 'chmod' since write_script() does it for you.

[1]: http://article.gmane.org/gmane.comp.version-control.git/289832

>  test_set_editor "$PWD/check-for-diff"
> @@ -23,7 +25,8 @@ test_expect_success 'setup' '
>  test_expect_success 'initial commit shows verbose diff' '
> -       git commit --amend -v
> +       git commit --amend -v &&
> +       test_line_count = 1 out
>  '
>
>  test_expect_success 'second commit' '
> @@ -39,13 +42,15 @@ check_message() {
>
>  test_expect_success 'verbose diff is stripped out' '
>         git commit --amend -v &&
> -       check_message message
> +       check_message message &&
> +       test_line_count = 1 out
>  '
>
>  test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
>         git config diff.mnemonicprefix true &&
>         git commit --amend -v &&
> -       check_message message
> +       check_message message &&
> +       test_line_count = 1 out
>  '
