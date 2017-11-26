Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB0E220A40
	for <e@80x24.org>; Sun, 26 Nov 2017 23:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbdKZXBa (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 18:01:30 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37415 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbdKZXB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 18:01:29 -0500
Received: by mail-wm0-f50.google.com with SMTP id v186so31323674wma.2
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 15:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GeXBZaDZVqFgvRM1HP3Ge6IF7wdH1Yae0fmSK1OIOKw=;
        b=PSNzK33SVPTG/zfWewFPX9v8AVP75MmKuQTiLITVAVklesm6Rkk0u2cDg+L26xeYuJ
         mfQFaA3HtgCImC4aqjEfBZKcp1r1bft0f2kv6eXad4vK8Hhc6TMYPhl5S4sFK9VjjUKz
         XATHdOsEDOGpM3l/kBZ3sh/4rQ9+oPIsR/uQlG9+sgM9Am8WaH0KF+x8KbssRzQ+DOuJ
         s5JVGHQAxHct3TZodyVb0qXP+NYu0LvWGE8ghmpEQOEmery4qP6fWhSdVdCnQNWN6QEV
         GMnV9xO9AxG7mkeiiWQUiWhpnQbFvrDxV3dIZoSeeA2GmnkQ7aiCwuv4gordUNlCLzPt
         47xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GeXBZaDZVqFgvRM1HP3Ge6IF7wdH1Yae0fmSK1OIOKw=;
        b=nHURxawzLyR7Li/L2EIemibvf67jhFr+bKiyS4zpFP4twTBXJo+pFvLB3U96CUSYjL
         BC9kMMrRWy7sJsZhg/Ewlko+Wvc3d64qYwmYQrQ4gn76sn/3V65S3MUVoFKYvIvBBOpZ
         ZifOJa6dfpznmudXPuIZQ9mwO16ZPJaeUoaNZEqYvz/gOEe7Ar7tjrnBrcAM8e131XC6
         jRQPFY+tjiOSsgNujohUrUDCw1UE6P3d45SmpOUdekT9IqsJCUrTXAij/h5ofpo7miuq
         tbrkJ4Jky7Lop4jRNkcGPKhxt4nRU6l/Q5+PWafM0Qe0A2xXoSpN/FqKA7OgzYFZFl+n
         H3Aw==
X-Gm-Message-State: AJaThX5MMhwayzM16gYYAEHw9/aZt/dWVQe0DbFAvJcokKbRi7FYubBp
        +WjLtwCcx5rGYpq+AVKDoL2P0iYsVXM=
X-Google-Smtp-Source: AGs4zMbHaIsvdhDatuTsKl+3QCiH7E5oUVav2tKqZfxBMqezlmnoAe/PzfhaF2Bj8ghphBYpODHZpw==
X-Received: by 10.28.214.198 with SMTP id n189mr17211382wmg.59.1511737288431;
        Sun, 26 Nov 2017 15:01:28 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id z108sm48145635wrb.67.2017.11.26.15.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2017 15:01:27 -0800 (PST)
Subject: [SCRIPT/RFC 1/3] setup.sh
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
Message-ID: <397276a1-8f2b-117d-ce51-84ab832ce562@gmail.com>
Date:   Sun, 26 Nov 2017 23:36:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/11/2017 23:35, Igor Djordjevic wrote:
> 
> This is what we end up with once "master" and topic branches are 
> merged in merge commit M1 inside temporary "test" branch for further 
> integration testing:
> 
> (2)        o---o---A (topicA)
>           /         \
>          /           M1 (test, HEAD)
>         /           /||
>     ---o---o---M---/ || (master)
>         \   \       / |
>          \   o---B-/  | (topicB)
>           \           |
>            o---o---C--/ (topicC)

To begin with, you can use provided "setup.sh"[*1*] script, putting 
you straight into position shown on graph (2) above, with addition of 
tag "A" and remote branch "origin/topicA" so you could try using 
these as "--onto-parent" values, too.

As seen in there, change "X" is already made and staged, so you can 
now just run something like:

	git-commit--onto-parent.sh --onto-parent topicA

... to see the logic in action.
 
Instead of "topicA", you may try providing tag "A", remote branch 
"origin/topicA" or even plain commit hash. It`s interesting to add 
"--amend" option into the mix, too, and see what happens. Also, you 
can try using "topicB" and see the commit fail (as it doesn`t merge 
cleanly).

All this while "test.txt" file doesn`t get modified on disk (nor 
would any other file) - being desired behaviour, as we didn`t 
actually change anything inside the working tree, but just amended 
history of how we got here, so recompilation isn`t needlessly 
triggered :)

p.s. Note these two lines near the end:

	sed -i '4iX1' test.txt  # works with simple patch apply
	sed -i '17iX2' test.txt # needs three-way file merge

You can play with it, commenting out one or the other and observing 
how it influences "git commit --onto-parent" in regards of the parent 
provided.

Regards, Buga

[*1*] "setup.sh", can clean previous setup run as well, but commented 
 out here for safety, not to unexpectedly delete something for unwary 
 user.
--- 8< ---
#!/bin/sh

#rm -rf ./.git
#rm -f ./test.txt

git init

touch ./test.txt
git add -- test.txt

for i in {1..10}
do
	echo $i >>test.txt	
	git commit -am "$i"
done

echo M >>test.txt
git commit -am "M"

git checkout -b topicA HEAD~2

for i in 1 2
do
	sed -i "${i}iA${i}" test.txt
	git commit -am "A$i"
done
sed -i '3iA' test.txt
git commit -am "A"
git tag A

# simulate remote branch
mkdir -p ./.git/refs/remotes/origin &&
echo $(git rev-parse HEAD^0) >$_/topicA

git checkout -b topicB master^

sed -i '4iB1' test.txt
git commit -am "B1"
sed -i '5iB' test.txt
git commit -am "B"

git checkout -b topicC master~2

for i in 1 2
do
	j=`expr "$i" + 5`
	sed -i "${j}iC${i}" test.txt
	git commit -am "C$i"
done
sed -i "8iC" test.txt
git commit -am "C"

git checkout -b test master
git merge --no-edit topicA topicB topicC

sed -i '4iX1' test.txt  # works with simple patch apply
sed -i '17iX2' test.txt # needs three-way file merge
git add -- test.txt

echo
git log --all --decorate --oneline --graph
echo
git diff --cached
