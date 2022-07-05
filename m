Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1D0C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 09:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiGEJZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 05:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGEJZa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 05:25:30 -0400
Received: from fallback18.mail.ru (fallback18.mail.ru [185.5.136.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CD61120
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 02:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=w/XZNQ5/pSVsXLaCAL4GeHJmnzabB3HQnokWhWqjp60=;
        t=1657013127;x=1657103127; 
        b=0qvWVWDOgAOo8ALm57vyMMPKKpOO1itMnFtT7Zl0IObPXWleN33Ggt6PEDD/tXIr6sSG+A3L/eFRh5iOY+oH/qcy4bjt/ukxdEJGD2Wq0C2F0JAOwXMYcWdarFZW/VkoD5oDJGbcTCypEeQw1BcNPwzgH6new7S03+SW+xYU4nw=;
Received: from [10.161.64.1] (port=51658 helo=smtp30.i.mail.ru)
        by fallback18.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1o8eo8-0006XU-Sq
        for git@vger.kernel.org; Tue, 05 Jul 2022 12:25:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=w/XZNQ5/pSVsXLaCAL4GeHJmnzabB3HQnokWhWqjp60=;
        t=1657013124;x=1657103124; 
        b=Owd9ha+oab4sFBx5cBLd7JOm+ZxqmKcdVq44VHEP7oH4/t4nWmw6NtW5GBCKrZZJoJzcbFYv+AnY3jJkJo8C2n3HnapPESlOMMyIIg83k2loNJRAR/dOrqH3KF6lzp4DPUycmysYtsW7uwwxhi5++yP+/xQyqGmU5TIC8mU6sJc=;
Received: by smtp30.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1o8enz-00020n-3K; Tue, 05 Jul 2022 12:25:15 +0300
Date:   Tue, 5 Jul 2022 12:25:14 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Cc:     git@vger.kernel.org
Subject: Re: How to display "HEAD~*" in "git log"
Message-ID: <20220705092514.hsm7cou5bqvajvgq@carbon>
References: <17411d88-b27a-2d20-623d-85c49dc7754e@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17411d88-b27a-2d20-623d-85c49dc7754e@mails.ucas.ac.cn>
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597D66D9C984A0F8A3F6AB0D5DEDD89A6EB3CD62213F67905E7A1807B55CFC991CB64DB5C868449DE64FBC6D7B97738D017A406EA159844E9C80
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78AC0750F3304E924EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063752AC809489EC5B9C8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8820FE7930F14FA8E129604F77263DAE0117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCEA77C8EAE1CE44B0A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD18C26CFBAC0749D213D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EED76C6ED7039589DE302FCEF25BFAB3454AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C3D54606DEFE0495C9BA3038C0950A5D36B5C8C57E37DE458B0BC6067A898B09E46D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE75A9E79F66F1C28F3731C566533BA786AA5CC5B56E945C8DA
X-8FC586DF: 6EFBBC1D9D64D975
X-C1DE0DAB: 9604B64F49C60606AD91A466A1DEF99B296C473AB1E14218C6CDE5D1141D2B1C0BE3C2E2B56788FDC2571B06678B04ADCEF370A31A4AEB19AD91A466A1DEF99B296C473AB1E14218B936CB490224F2464EEA7BD89490CAC0EDDA962BC3F61961
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D344888A9AABCDD32256A04078A2E4077E7917148AF452B1CC5BFFDCFC54BF3DAABED2C78A9DA3A90851D7E09C32AA3244C5A51338F67CED8308276596392FCEAC355E75C8D0ED9F6EE729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojDSjrPsecpvoojcbXS6ukwg==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138C9D59CDFFC3C6DB2C38C212338B5E034362FCE067243046613BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B414CF52640EBC14D3D43EB000C94A727F1DAE2C902C07A4BC049FFFDB7839CE9EC4180C89117960A129EDCE273E1491437D0B652B2A96C9F934EEC36A3C35FC0C
X-7FA49CB5: 0D63561A33F958A5F34A86402D856BD72F6FEBE04EA531DC6EA7EF97813D48A78941B15DA834481FA18204E546F3947C6FF1B927F95F3316F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637006720155ACF5028389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F790063776C4598447C51BFFD81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7CD0F529D6CE73765543847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 9604B64F49C60606AD91A466A1DEF99B296C473AB1E14218C6CDE5D1141D2B1C11EFCA1AADD03035B2360119D018E5763273B7892A419564AD91A466A1DEF99B296C473AB1E14218B936CB490224F2464EEA7BD89490CAC0EDDA962BC3F61961
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojDSjrPsecpvp30r734efI3g==
X-Mailru-MI: 8000000000000800
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 05, 2022 at 03:11:49PM +0800, wuzhouhui wrote:

> I frequently use "git rebase" to move commit to a specific location, to
> know which commit ID as param of "git rebase", I have to list all commits
> by "git log --oneline", then copy specific commit ID, and executing "git
> rebase" as
> 
>   git rebase -i <copied commit ID>~
> 
> because SHA sum is hard to memorize, so I have to use copy and past,
> which is too boring. So, I wonder if there is a way to let "git log"
> display commits like following:
> 
>   HEAD   <one line commit message>
>   HEAD~1 <one line commit message>
> HEAD~2 <one line commit message>
> HEAD~3 <one line commit message>
>   ...
> 
> With these "HEAD~*", I can easily directly type them and no need to
> move my fingers out of keyboard.

You can script this. Provided you have a POSIX-compatible shell (such as
Bash), the encantation would read something like

 $ git log --oneline | { n=0; while read line; do printf '%d\t%s\n' $n "$line"; done; }

This is admittedly not convenient so it makes sense to turn into an alias:

 [alias]
   relog = "!relog() { git log --oneline \"$@\" | { n=0; while read line; do printf 'HEAD~%d\t%s\n' $n \"$line\"; n=$((n+1)); done; }; }; relog"

Then the call

 $ git relog

would output something like

HEAD~0	deadbeef Commit message
HEAD~1	fadedfac Another commit message
HEAD~2  12345678 Yet another commit message

...and so on.

It's easy to make that script not output "~0" for the very first entry and
output just "~" instead of "~1" for the second, but I what's presented is
enough for an example.
