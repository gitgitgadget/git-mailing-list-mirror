Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA261F404
	for <e@80x24.org>; Wed, 28 Feb 2018 04:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbeB1EfZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 23:35:25 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33955 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeB1EfY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 23:35:24 -0500
Received: by mail-wr0-f196.google.com with SMTP id m5so974075wrg.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 20:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QUW5cm5DPpgz7t05o4c4DMcDpzWhdmZoRr4/xwEcB6s=;
        b=IeBfvAhSEhvJVyR87GPsoPpt3vY4xqVP0z6N6/2afE4dsMQRyzW1XkKjsuzgAOl4P6
         BSeChkwzwJjKyMYgwr/GzB46J20v/qfhP161MDlhndeV2J8VJ8OAVbNURFBRzXBfrFBD
         pGdPGAna0FqbOtOEq1bfFcJQKtVUcOqxBJCuCKYXdTNdyb61/wd1kl/mmFe/Q1KRlRI3
         HaGJHUraLPGCHBV13rGmsDBTADDj7wuI16O31mILb4r8YRJ40uyIlF30xCgdBrSPTC6u
         656oqaABAnHR+joAKp76eFnI8ox+6rpMSQ6nnstXIereVJI6fByDeP3j3gg0/QnNesVO
         B+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QUW5cm5DPpgz7t05o4c4DMcDpzWhdmZoRr4/xwEcB6s=;
        b=cTx2CiPGbZ+pylYtcWhYNaGDYUAl9NGrSoPUJb84SWBNa4tg5hjFyMiCYOmvep74NB
         BvaLwGlMuuDBU9Z9ZxdG61ofTZpH5zIAk1JBcVazPFxlaWyrdT3NchP4VU4DKMJHbdHb
         2Pso9Vv9iH7hrUZYS2bTrZtuFlK/gmHc6VlLbD0xkgl6UpJ6SLDjPkPwWbg2dARHvLOO
         uOfsebsOKCP382ZKcItf1jC/k4J21YW/k8lJcn2KEXhtxXNvui3O5s7k3pAper7+dGt5
         YacnyVIfIcn1qi7iNLt/WLnomaonktcHcUiV1FPobsJV4QEWRA6yhfzPtktRw3T6ah8u
         1Phw==
X-Gm-Message-State: APf1xPBPDkYWkSCgsT7qEnsAqmZ+VZzl8s6hmHoAkalt35hMNTBNxJ1l
        j38UZuSpJrNDyOv/BRxcf2o=
X-Google-Smtp-Source: AH8x22463cM1hViNxhY8+sHXhc1lI5gnNPpmfzi2+NwyobsNzuLuTmwvQlIVkH1V5BKQB20tADRplg==
X-Received: by 10.223.150.102 with SMTP id c35mr14881967wra.225.1519792523263;
        Tue, 27 Feb 2018 20:35:23 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id 2sm1737547wmk.29.2018.02.27.20.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 20:35:22 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <nycvar.QRO.7.76.6.1802272330290.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <3b562b51-2f1a-48f6-d6b4-8e0fbddd3a40@gmail.com>
Message-ID: <b4367bca-79a0-879b-9503-ed4e667d8a64@gmail.com>
Date:   Wed, 28 Feb 2018 05:35:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3b562b51-2f1a-48f6-d6b4-8e0fbddd3a40@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/02/2018 03:12, Igor Djordjevic wrote:
> 
> Would additional step as suggested in [1] (using R1 and R2 to "catch" 
> interactive rebase additions/amendments/drops, on top of U1' and 
> U2'), make more sense (or provide an additional clue, at least)?
> 
> [1] https://public-inbox.org/git/8829c395-fb84-2db0-9288-f7b28fa0d0d1@gmail.com/

Heh, no sleeping tonight :P

Anyway, from (yet another) ad hoc test, additional step mentioned in 
[1] above seems to handle this case, too (merge with `-s ours` 
dropping B* patches, plus B1 cherry-picked between X1..X2):

On 28/02/2018 00:27, Johannes Schindelin wrote:
> 
> - One of the promises was that the new way would also handle merge
>   strategies other than recursive. What would happen, for example, if M
>   was generated using `-s ours` (read: dropping the B* patches' changes)
>   and if B1 had been cherry-picked into the history between X1..X2?
> 
>   Reverting R would obviously revert those B1 changes, even if B1' would
>   obviously not even be part of the rebased history!
> 
> Yes, I agree that this `-s ours` example is quite concocted, but the point
> of this example is not how plausible it is, but how easy it is to come up
> with a scenario where this design to "rebase merge commits" results in
> very, very unwanted behavior.

And not just that - it worked with additional interactive rebase 
adding, amending and removing commits, on top of all this still 
preserving original `-s ours` merge commit evil-merge amendment, too, 
all as expected (or so it seems) :P

Again, for the brave ones, here`s another messy test script (not 
tightly related to the last discussed diagrams, but based on my 
original "demonstration" script[2])... Hopefully I get to make a 
proper (and sane) sample soon... if not missing something here in the 
first place ;)

Regards, Buga

[2] https://public-inbox.org/git/bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com/

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
sed -i '16iB21' test.txt
git commit -am "B21"
sed -i '18iB22' test.txt
git commit -am "B22"

git checkout -b merge b1
git merge -s ours --no-commit b2
sed -i '12iX' test.txt # amend merge commit
git commit -am "M"
git tag original-merge

git checkout master
git cherry-pick b2
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
