Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B691F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeB1Bni (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:43:38 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39084 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbeB1Bnh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:43:37 -0500
Received: by mail-wr0-f196.google.com with SMTP id w77so716507wrc.6
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=czZ4C9etBQR2nR9Q06WF+S5BjMw4BcGW+G0DO6+FYTs=;
        b=rj7/21rKHmZPisw0135QCjPyC73Oytt0zleUuEGrIYd9BmE6KNHLFdXHCvOaE4gdea
         w/sR3JChBjdLXCYWYcr/qqMXz8H9uZpjapkRZQdqvbglXeehGttJKcDIgWNs5srSQcbN
         mRwy6EXpvLDH0s2HokK4UpZ0V/ILn6Og+/v4dkq6zQ5XbfZY3MKNOXEUD8MXmKZJoEuO
         P6bMBPyRNtmZQfARUVN9i3vkbQa6Hc/Gj2fKCHLCFGf7GoMzK98NABcH5E0cWdJiRVAf
         6YnQPUJc0rMk/xkxLNQmxlYFDPDyPLRIX00yDo/1hSu/un81hlXgeed00+cszlOMxGrB
         WbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=czZ4C9etBQR2nR9Q06WF+S5BjMw4BcGW+G0DO6+FYTs=;
        b=uEvvN6faF6FoKWDx2MR/m5VBgSxA3Anue7fLxzRO2R4vYrxm1g6z4ZnrO7yiSU+jO9
         vXXDbROwgDfybT1v6FX4hh73vGdVghB92zWM6qn4OPTS0MapKGg9dJD5++Y3Dq+ute3G
         qgN2I6rEz1XLKbXfvh6V+4ymYrsn2g7f7dw6o53fZmzX90optbG10KowbhBZ+1B3wNmp
         v+px5V0OnawWrt86rFwwpE5u5+vx8HbBH7CDDSy6vpmQK1hpUQ/IVY2iqRyF7TShu7Y1
         hKlMvRNGLn93NHsntsodhtXUykPojBZ3tVQwzo034YfsvTfzuoLne5eojNM9absDygHb
         CGzQ==
X-Gm-Message-State: APf1xPAg8LDc4TZmsX+5/51+IZUV3HMxZWMyspGTZy7AEjHc+3RCoKAE
        7EL6PIZkbl7I+MsULKKLnnq9Ypnq9i8=
X-Google-Smtp-Source: AG47ELtIv+JfKQ9j7FxEOKDQehb8E2/VZ0QQ2vKCphprj3sJuZurzAZtLIakvtseCqp6JaihkF4QVA==
X-Received: by 10.223.200.140 with SMTP id k12mr14304577wrh.191.1519782216521;
        Tue, 27 Feb 2018 17:43:36 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id b30sm1253009wra.34.2018.02.27.17.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 17:43:35 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
 <CA+P7+xrzxYSE0OyL8uyF+ErwfWFEgcqnHmaciwWkK-76sQ6ktw@mail.gmail.com>
 <8829c395-fb84-2db0-9288-f7b28fa0d0d1@gmail.com>
Message-ID: <6737f819-4629-8aef-c3fb-79d96ccd2306@gmail.com>
Date:   Wed, 28 Feb 2018 02:43:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8829c395-fb84-2db0-9288-f7b28fa0d0d1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/02/2018 02:33, Igor Djordjevic wrote:
> 
> This seems to be working inside my (too trivial?) test case, for 
> interactive adding, dropping, and amending of rebased commits, 
> resulting "rebased" merge containing all the added/modified/dropped 
> changes, plus the original merge amendment, all as expected :P

In case anyone has a wish to examine my (now pretty messy) test 
script, here it is - sorry for not having time to clean it up! :(

What I get when I diff original and "rebased" merge is this:

    diff --git a/test.txt b/test.txt
    index a82470b..d458032 100644
    --- a/test.txt
    +++ b/test.txt
    @@ -1,10 +1,14 @@
    +A21
    +A22
    +A23
    +A24
    +A25
     A1
     A2
    -B11
    +B1111
     A3
     A4
     A5
    -B12
     A6
     A7
     A8
    @@ -14,6 +18,7 @@ A10
     A11
     A12
     A13
    +BX
     A14
     B2
     A15


... where A21 to A25 are additions due to new base, B11 was 
interactively amended to B1111, B12 was interactively dropped, and BX 
interactively added :)

We don`t see line X here, being an "evil merge" amendment being 
correctly preserved from original merge commit (thus not a 
difference). If we do `git show` of the "rebased" merge, we get this, 
as expected:

    diff --cc test.txt
    index b173cef,fad39a8..d458032
    --- a/test.txt
    +++ b/test.txt
    @@@ -13,6 -13,6 +13,7 @@@ A
      A7
      A8
      A9
    ++X
      A10
      A11
      A12


Regards, Buga

-- 8< --
#!/bin/sh

# rm -rf ./.git
# rm -f ./test.txt

git init

touch ./test.txt
git add -- test.txt

for i in {1..20}
do
	echo A$i >>test.txt
	git commit -am "A$i"
done

git checkout -b b1
sed -i '3iB11' test.txt
git commit -am "B11"
sed -i '7iB12' test.txt
git commit -am "B12"

git checkout -b b2 HEAD^
sed -i '16iB2' test.txt
git commit -am "B2"

git checkout -b merge b1
git merge --no-commit b2
sed -i '12iX' test.txt # amend merge commit
git commit -am "M"
git tag original-merge

git checkout master
for i in {1..5}
do
	j=`expr "$i" + 20`
	sed -i "${i}iA${j}" test.txt
	git commit -am "A$j"
done

# simple/naive demonstration of proposed merge rebasing logic
# using described "Trivial Merge" (TM, or "Angel Merge"),
# preserving merge commit manual amendments, but still respecting
# interactively rebased added/modified/dropped commits :)

# read -p "Press enter to continue"
git checkout b1
git cherry-pick -m1 original-merge && git tag U1
git reset --hard HEAD^^ # drop U1 and last b1 commit
sed -i '/B11/c\B1111' test.txt
git commit -a --amend --no-edit
git rebase master
git cherry-pick U1 && git tag U1-prime

# read -p "Press enter to continue"
git checkout b2
git cherry-pick -m2 original-merge && git tag U2
git reset --hard HEAD^ # drop U2
git rebase master
sed -i '20iBX' test.txt
git commit -am "BX" # add new commit
git cherry-pick U2 && git tag U2-prime

git diff U1 U1-prime | git apply --3way && git commit -m "U2-second" && git tag U2-second
git checkout b1
git diff U2 U2-prime | git apply --3way && git commit -m "U1-second" && git tag U1-second

# read -p "Press enter to continue"
git branch -f merge b1
git checkout merge
git merge b2 --no-commit
git commit -a --reuse-message original-merge
git tag angel-merge

# read -p "Press enter to continue"
git reset --hard b1^
git read-tree --reset angel-merge
git update-ref refs/heads/merge "$(git show -s --format=%B original-merge | git commit-tree "$(git write-tree)" -p "$(git rev-parse b1^^)" -p "$(git rev-parse b2^^)")"
git tag -f angel-merge
git checkout angel-merge .
git branch -f b1 b1^^
git branch -f b2 b2^^

# show resulting graph
echo
git log --all --decorate --oneline --graph

# comparison between original merge and rebased merge,
# showing merge commit amendment "X" being preserved during rebase
# (not shown in diff)
echo
echo 'diff original-merge angel-merge:'
git diff original-merge angel-merge
