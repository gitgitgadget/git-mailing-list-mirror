Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075DCC43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 07:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbiGVHxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 03:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiGVHxH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 03:53:07 -0400
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Jul 2022 00:53:06 PDT
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5189A69C
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1658476385;
        bh=g1P4wDtWrmSTywxleAHqPT3DcHnwKdKyICYDCbIDdBY=;
        h=X-UI-Sender-Class:Date:From:Subject:To;
        b=Q8broVqpiFWCOaHgsN0VsKPJEuFjVGjBWmH7Z9NBVFhEqqbNrhzeNCTcd9xxaYvud
         h77Uz4iznXQlKlWP0UwARzQEUuKf2ax04FQnNSyj9Dp5NMpzLdXVYSygO7JLzZAmU3
         z0FxMZEwtCF2E01Fa9vijB0EBGyiyhyevjTNuQ/U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.0.52] ([95.223.75.100]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mfc4g-1nZ7yk0Wjo-00g7jq for
 <git@vger.kernel.org>; Fri, 22 Jul 2022 09:48:02 +0200
Message-ID: <99c80fc2-0f94-a607-ca71-c45961c07e2b@web.de>
Date:   Fri, 22 Jul 2022 09:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From:   Claudio Ebel <claudio.ebel@web.de>
Subject: =?UTF-8?Q?Changed_diff3_view_from_2=2e36_=e2=86=92_2=2e67_for_vimdi?=
 =?UTF-8?Q?ff?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AT1V7ULQFIBMzP7+MLtuAxdTTwxhbc7n36CuspNzbEwbCYbPJdW
 9nPEPPh3tHrICpTTYekx/saNtKQTQn9Okk6vuU5xGQ54biCSjGdlEauTDdZQwzOk4SmPZ1g
 p3p1UVuoF6lX6Pm7w+CfErEp3248cvuU8KGPu3IZD8gRqx0Z9/0kmU5hSq6AoppDjDP7/Sg
 p5mLk6UUoqoSfN6kgeB9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dEcDAtniovk=:I9VkZS/mYxi+ZFtdShkcQ3
 //4jj3vKJLROlOOjBnTBxFFCk/pfN7lMRE8GoDDWGHIPhgZz30q8sciNul0ULD23KoYn4Ob62
 09offSvK/bv6y5CqWLaH5SpDnm+ju5jir7i67e9v4sM/vGvGa+G6MAeGy1O/CFt8bKQpBsp5D
 2588Ei/Ec5P+RoCwelYEf5fwdAx12XZ0b9Nlfyw2gIEqR50u6zfC4Kpo/4lgbc99lZykaXd3B
 gn9je6HL5/uuWUYA4b6OYxCR5/Akolw7dpcLOwXvv9XplLxkS6W15uvErBW4alArujstDIp7n
 Mk6DscPPwgRUgVb1UP2xf0iOh4NpXLh9o1OZ2BO9zM84iX3MF/HvjMUohqKtMRkrIBAI+M5sI
 VjxXK+ZtxCnUw/bXal5ti3Kf8WtRqPeoYYO6bNY4PrdmRsd4JQiryZIUktztSJodU0amNl+l5
 GwCaUA9h6SFMzwKHN3bjWUhdZZxg+U4PsE5ro0dKv1QNEp1XIl1OD3K3RCHE7vr7oRe/138Z8
 kOjOlKqa1SwPjo5oD/32ywNnJsZBahygN1FCyqI3YKLRMo13rOs4WZ2Yg5/XoWDcsSHYspTay
 eN7aJrrmmgSbXs/ZwAdnlBwGZ86rjkqu00QXWgmf517yQmm1d0k/25fouI7TVRzDjy1INq0cP
 e/iZzc2ZNT72dJHyHPjqmmevJmntIk+DsvDT2XYviwDook6sqKgjtg73nmf/NGK1QIrqr0cZa
 7NgH1T6g9chGG4yqlkjcSozfme4es+E2KlcV/9yMgdW984QMnjt17Q5btGs5ZMH+vAGH+h7tx
 rNXOIZKayjX+QpqAkmJUa8Iikuspc3kldwOlFWeAiJ0h4YDOOFgK8WtVIokPPkKKWdwALfi52
 AKPA9hOiTB6hQZyp/qOkxsdF/DUlAe7yQ0MZTlObshqK4jVBw6uGYnc0cvUNFv4IgJ5MXZ3+r
 hCwtkkX3nAn9XoMawneJjPae0N3DjSyDZx5/KRyxoNIHejU39Cpq/uvR1OmU04JbqnGjsWzwF
 g4PWEzZHYYlzFhbBSNEypUmt5GRdb9xn0vRr/n9Yrr8wjl3bX/bq1sDBYyNG46QCP+O69aUpE
 HCRzlswowR+rm+8WhNUe5PS5BBINSq0wYDYM/Q3XMjrSu0bQtP3Y7viGQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

when solving a merge conflict using Git and Vim as mergetool, I get a tota=
lly different view than I expected and am used to. In the past, I followed=
 this blog post (https://www.rosipov.com/blog/use-vimdiff-as-git-mergetool=
/), where the result is a view with four windows: LOCAL | BASE | REMOTE an=
d then the file below. Now I get four windows as well, but LOCAL at the to=
p and then LOCAL | LOCAL | file.

First I was not able to figure out if the problem lies within Git or Vim. =
I removed my global .gitconfig as well as the .vimrc but neither helped. W=
hat finally helped was to disguise the HOME directory for Git via this com=
mand:

$ git merge octodog
$ HOME=3D  git mergetool

My git version:

$ git --version
git version 2.37.1

Then I tried older Git versions, 2.37.0 showed the same behavior but Git 2=
.36.1 showed the old view.

Minimal working example (for bash):

$ cd $(mktemp -d)
$ git init
$ # =E2=80=93=E2=80=93=E2=80=93 config mergetool
$ git config merge.tool vimdiff
$ git config merge.conflictstyle diff3
$ git config mergetool.prompt false
$ # =E2=80=93=E2=80=93=E2=80=93 create merge conflict
$ echo -e 'cat\ndog\noctopus\noctocat' > animals.txt
$ git add animals.txt
$ git commit -am 'Initial commit'
$ git checkout -b octodog
$ sed -i 's/octopus/octodog/' animals.txt
$ git commit -am "Replace octopus with an octodog"
$ git checkout master
$ sed -i 's/octopus/octoman/' animals.txt
$ git commit -am "Replace octopus with an octoman"
$ # =E2=80=93=E2=80=93=E2=80=93 trigger behavior
$ git merge octodog
$ git mergetool

How can I get the old view back? Is this a bug or a feature of Git? Should=
 I write the Vim guys?

This behavior is independent of directory as well as host, it occurs on a =
different machine as well.

Thanks in advance,
Claudio
