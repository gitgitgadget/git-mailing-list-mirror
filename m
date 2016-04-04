From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v12 4/5] t7507-commit-verbose: improve test coverage by
 testing number of diffs
Date: Sun, 3 Apr 2016 20:02:56 -0400
Message-ID: <CAPig+cRBwOjxA2cB=ZR__o7LsHxk9Rbzfv7ngRxv8h6=koQSRw@mail.gmail.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
	<01020153d952be6c-04f90bd2-291e-4eca-99fd-e897d8601132-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 02:03:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amrz3-0004Sk-PF
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 02:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbcDDAC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 20:02:58 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:35363 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbcDDAC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 20:02:57 -0400
Received: by mail-ig0-f193.google.com with SMTP id ya17so11476209igc.2
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 17:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Ki9MaHfLZqkTOJzQfnDRseQnIZeNWqv11XMBwOfoM34=;
        b=wyB8NryGxt9HOXdiFcpWvO976UYH62CmuLv/05jqPEeuPfghJT+SPqU9g2rf/XJNqK
         Sx9h3zPjpmReJNLkqwgAbWi5P6Q4L4Di3wY1cbwbCjDzYlYwXnQnmrMNxgHrfTSBpsQV
         6jZ/+PU33kUgLMGe0sX6yHzrGeDFEmDMDRIngV00M5VfVsKOZvo1pHnD1AVCOcbb2klT
         tGaUg+pXzpIaDU32gsgGuz4qzCUPFGRnmam5Z6uu66TkZ4RCCkvcdbqtom5YolGFldBA
         InQWJl0LKpum3PGEhR6/SPbH0TsuHFDDNTOEp7PbPpipy++ATZgDkVetAC/u6y9nVEm4
         3kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Ki9MaHfLZqkTOJzQfnDRseQnIZeNWqv11XMBwOfoM34=;
        b=eg+yFdZY9F5CAQw+qanmweVBX6lFZ6EjeMD/Jt6kzldQ+ueDH+eWH4bRhsOq7FcgXV
         coPDZvpDHlfSkDdy/aV4Xmox3if3U2PAAa5H93CNl+YZIHf0GyyuUbPS0baFxYh/Ps9r
         /aVmBtHBd9TyiPOAugrsHBjolfvIARxhaa9J20v0bSb60SWfx+m+WUVfolkumptSf0nq
         3t4+rfnsUJMKUUUWUhvs4/nVmlYw+0Nqbm2ItVwMR5Srxor8AYZVk8FDTYCfg+NcrOxM
         kyzCvJg7oscahJ9TL5IbPluuJ7wqKct3dMyy0REbvpkS2ynvrVHDKs4JcS8P8RDUIbJR
         rg+Q==
X-Gm-Message-State: AD7BkJL7y6zo2FaxoSs1WCd/f+Q5WwR43OsT6rrn7lpB73aB8zTwAYnPP4m0zg7TAu/c76Sb90wHNM7m42r2KA==
X-Received: by 10.50.40.101 with SMTP id w5mr8517329igk.17.1459728176647; Sun,
 03 Apr 2016 17:02:56 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 17:02:56 -0700 (PDT)
In-Reply-To: <01020153d952be6c-04f90bd2-291e-4eca-99fd-e897d8601132-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: xTA29Hxe6TGivy1_7cNmBKhxDb0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290663>

On Sat, Apr 2, 2016 at 7:33 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Make the fake "editor" store output of grep in a file so that we can
> see how many diffs were contained in the message and use them in
> individual tests where ever it is required. Also use write_script()
> to create the fake "editor".
>
> A subsequent commit will introduce scenarios where it is important to be
> able to exactly determine how many diffs were present.

These two sentences are backward. The "subsequent commit" bit is
justification for why you are making the "editor" store the output,
thus it belongs with the first paragraph. The bit about write_script()
is just a minor aside which can go in its own paragraph.

I think it's also important to explain that you're changing the
behavior of write_script() so that it always succeeds, regardless of
whether grep found diff headers or not, and to give the reason for
making this change ("so that you don't have to use 'test_must_fail'
for cases when no diff headers are expected and can instead easily use
'test_line_count = 0'").

The patch itself looks fine and is easy enough to read.

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 2ddf28c..0f28a86 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -3,11 +3,10 @@
>  test_description='verbose commit template'
>  . ./test-lib.sh
>
> -cat >check-for-diff <<EOF
> -#!$SHELL_PATH
> -exec grep '^diff --git' "\$1"
> +write_script "check-for-diff" <<\EOF &&
> +grep '^diff --git' "$1" >out
> +exit 0
>  EOF
> -chmod +x check-for-diff
>  test_set_editor "$PWD/check-for-diff"
>
>  cat >message <<'EOF'
> @@ -23,7 +22,8 @@ test_expect_success 'setup' '
>  '
>
>  test_expect_success 'initial commit shows verbose diff' '
> -       git commit --amend -v
> +       git commit --amend -v &&
> +       test_line_count = 1 out
>  '
>
>  test_expect_success 'second commit' '
> @@ -39,13 +39,15 @@ check_message() {
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
