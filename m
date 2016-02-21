From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/5] merge-recursive: test rename threshold option
Date: Sun, 21 Feb 2016 12:52:07 -0500
Message-ID: <CAPig+cTpngfi6EF+MbD-fQ1nM_9TTeVZJ_fBviD5=4Q9uN-8aA@mail.gmail.com>
References: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
	<1456067358-19781-4-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 18:52:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXYB3-00072H-T6
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbcBURwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 12:52:09 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36359 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbcBURwI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2016 12:52:08 -0500
Received: by mail-vk0-f51.google.com with SMTP id c3so112132697vkb.3
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 09:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=lKjQ4w7JkY/QtYDbKmpYOeLSj8ECOUaAya5cMF5yYNU=;
        b=YWLwYxgqk6RWxf8lkJKZDKgnvO6s9H9dHMgOv+slJG49jJtH4w1DPWjY2g5Axlemts
         BMT+QaXkjMxKqjBfUNcXDuFUHxMQMHayCc8li/NjpkNe82wlkahrkowTt3jidczzO2kx
         IJSwM1jEhXM9wF0xq8paCcUpDEsXpZmqpBKcwjA5eXvjvUsXw1ZoNmuyOwkb0lxq/3k1
         cB16wKWdoM3offZuWuq38kQuI9URMttBwJe0hPfE1HaHL/4SkgplEeDtJGEVpH+3lPJ3
         w+x0iIdCpwuPJHG3LdUQ98c6UyHMgPtOZRsMNhHUr1anLcwF9rIEg1eN1RJd230MloC0
         cpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lKjQ4w7JkY/QtYDbKmpYOeLSj8ECOUaAya5cMF5yYNU=;
        b=dr0eQnsXL1kpBmzD5UPwWTEtECybaVzIY1rPL+BH09Mz/cb2VtQrZpOf1qyfFiQ2vL
         3ivVXH0mp7wEXSXnJXSwQux3RdmRH9TW9C4jvAWJmQrBtydgitP0gzgaDPXbyHrQbA6b
         ub71jOJP2bY2KBn00L9R7SCEDKU2IDWc5r76wiz7P/kX2cprrbe/lDm1eOOXPBynPI1g
         wgbFQAbF0Nnd+o26oERUVN2Hzqx0U6VPhi1CTqmAkv0r3PcDgn94ocnSB5vHL4tAm7+r
         IvLCtLD88sbFGLC/JKMcUUISljcBzcDzB5dlNvBQeJs2FFmnq/5LYRz0yO+L75myj2Gz
         OK5A==
X-Gm-Message-State: AG10YOQMWkJq5KJoJqaSEyGoAUF1z/K03lDw/BU3LIIZOn25xRPjqVDS2vuVvtrT6fF3KQKH9Xldv8mb6BZkUg==
X-Received: by 10.31.146.2 with SMTP id u2mr17174383vkd.19.1456077127170; Sun,
 21 Feb 2016 09:52:07 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 09:52:07 -0800 (PST)
In-Reply-To: <1456067358-19781-4-git-send-email-felipegassis@gmail.com>
X-Google-Sender-Auth: EaS-ltnwzuiNq9-3lmpOhovXhFA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286810>

On Sun, Feb 21, 2016 at 10:09 AM, Felipe Gon=C3=A7alves Assis
<felipeg.assis@gmail.com> wrote:
> merge-recursive: test rename threshold option

Maybe rephrase this as:

    t3034: add rename threshold tests

> Commit 10ae7526bebb505ddddba01f76ec97d5f7b5e0e5 introduced this featu=
re,

In commit messages, it is helpful to provide more context about a
commit by quoting its "subject", like this:

    10ae752 (merge-recursive: option to specify rename
    threshold, 2010-09-27) introduced this feature...

> but did not include any tests. This commit fixes this.

"This commit fixes this." is redundant with the subject and could be dr=
opped.

The above are superficial observation; see below for a bit more meaty s=
tuff...

> Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
> ---
> diff --git a/t/t3034-merge-recursive-rename-threshold.sh b/t/t3034-me=
rge-recursive-rename-threshold.sh
> @@ -0,0 +1,146 @@
> +#!/bin/sh
> +
> +test_description=3D'merge-recursive rename threshold option
> +
> +Test rename detection by examining rename/delete conflicts.
> +
> +Similarity index:
> +R100 a-old a-new
> +R075 b-old b-new
> +R050 c-old c-new
> +R025 d-old d-new
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +       get_expected_stages () {

There is no particularly good reason to define these shell functions
within the 'setup' test, and doing so makes the test itself more
difficult to read. More typical would be to define the functions
outside any test.

> +               git checkout rename -- $1-new &&
> +               git ls-files --stage $1-new > expected-stages-undetec=
ted-$1

Broken &&-chain.

Style: Omit space after redirection operators (here and elsewhere in
the script). <inputfile >outputfile

> +               sed "s/ 0       / 2     /
> +               " < expected-stages-undetected-$1 > expected-stages-d=
etected-$1

This is difficult to read due to the way this is formatted with the
newline inside the quoted string. How about formatting it in a more
typical fashion, like this?

    sed "s/ 0       / 2     /" <expected-stages-undetected-$1 \
        >expected-stages-detected-$1

Also, broken &&-chain.

> +               git read-tree -u --reset HEAD
> +       } &&
> +
> +       rename_detected () {
> +               git ls-files --stage $1-old $1-new > stages-actual-$1=
 &&
> +               test_cmp expected-stages-detected-$1 stages-actual-$1
> +       } &&
> +
> +       rename_undetected () {
> +               git ls-files --stage $1-old $1-new > stages-actual-$1=
 &&
> +               test_cmp expected-stages-undetected-$1 stages-actual-=
$1
> +       } &&
> +
> +       check_common () {
> +               git ls-files --stage > stages-actual &&
> +               test $(wc -l < stages-actual) -eq 4

Perhaps use test_line_count() instead.

> +       } &&
> +
> +       check_find_renames_25 () {
> +               check_common &&
> +               rename_detected a &&
> +               rename_detected b &&
> +               rename_detected c &&
> +               rename_detected d
> +       } &&
> +
> +       check_find_renames_50 () {
> +               check_common

Broken &&-chain.

> +               rename_detected a &&
> +               rename_detected b &&
> +               rename_detected c &&
> +               rename_undetected d
> +       } &&
> +
> +       check_find_renames_75 () {
> +               check_common

Ditto.

> +               rename_detected a &&
> +               rename_detected b &&
> +               rename_undetected c &&
> +               rename_undetected d
> +       } &&
> +
> +       check_find_renames_100 () {
> +               check_common

Ditto.

> +               rename_detected a &&
> +               rename_undetected b &&
> +               rename_undetected c &&
> +               rename_undetected d
> +       } &&
> +
> +       check_no_renames () {
> +               check_common

Ditto.

> +               rename_undetected a &&
> +               rename_undetected b &&
> +               rename_undetected c &&
> +               rename_undetected d
> +       } &&
> +
> +       cat <<-\EOF > a-old &&
> +       aa1
> +       aa2
> +       aa3
> +       aa4
> +       EOF
> +       sed s/aa/bb/ < a-old > b-old &&
> +       sed s/aa/cc/ < a-old > c-old &&
> +       sed s/aa/dd/ < a-old > d-old &&
> +       git add [a-d]-old &&
> +       test_tick &&

Nothing in these tests depend upon these test_tick() invocations, so
having them here distracts the reader by making him wonder if
something unusual is going on to require them.

> +       git commit -m base &&
> +       git rm [a-d]-old &&
> +       test_tick &&
> +       git commit -m delete &&
> +       git checkout -b rename HEAD^ &&
> +       cp a-old a-new &&
> +       sed 1,1s/./x/ < b-old > b-new &&
> +       sed 1,2s/./x/ < c-old > c-new &&
> +       sed 1,3s/./x/ < d-old > d-new &&
> +       git add [a-d]-new &&
> +       git rm [a-d]-old &&
> +       test_tick &&
> +       git commit -m rename &&
> +       get_expected_stages a &&
> +       get_expected_stages b &&
> +       get_expected_stages c &&
> +       get_expected_stages d
> +'
> +
> +test_expect_success 'the default similarity index is 50%' '

s/the//

Also, do you mean s/index/threshold/ ?

> +       git read-tree --reset -u HEAD &&
> +       test_must_fail git merge-recursive HEAD^ -- HEAD master &&
> +       check_find_renames_50
> +'
> +
> +test_expect_success 'low rename threshold' '
> +       git read-tree --reset -u HEAD &&
> +       test_must_fail git merge-recursive --rename-threshold=3D25 HE=
AD^ -- HEAD master &&
> +       check_find_renames_25
> [...]
> +       check_find_renames_75
> [...]
> +       check_find_renames_100
> +'
> +
> +test_expect_success 'rename threshold is truncated' '
> +       git read-tree --reset -u HEAD &&
> +       test_must_fail git merge-recursive --rename-threshold=3D200% =
HEAD^ -- HEAD master &&
> +       check_find_renames_100
> +'

Is this truncation documented behavior or is it just a detail of the
current implementation. (Genuine question; I haven't checked the
documentation or source.) If just an implementation detail, then it
might not be desirable to formalize it via a test.

> +test_expect_success 'last wins in --rename-threshold=3D<m> --rename-=
threshold=3D<n>' '
> +       git read-tree --reset -u HEAD &&
> +       test_must_fail git merge-recursive --rename-threshold=3D25 --=
rename-threshold=3D75 HEAD^ -- HEAD master &&
> +       check_find_renames_75
> +'

Would it make sense to add tests checking that invalid
--rename-threshold=3D arguments, such as negative and non-numbers,
correctly error out?

> +test_done
