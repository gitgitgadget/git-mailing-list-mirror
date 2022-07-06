Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC92DC433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 18:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiGFSV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 14:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiGFSVz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 14:21:55 -0400
Received: from smtp49.i.mail.ru (smtp49.i.mail.ru [94.100.177.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D00A24BC3
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=eO9PuvNGnfOCaMFcmmwJ8MaiZp2diBYNfpDXhgmpORM=;
        t=1657131713;x=1657221713; 
        b=Z48ffk2qt94kCNO9WTSDSuEii7kTLb7oDPLPu8Y8OmSLBPisZIa8sXzfZNB7BrjMHbt63opUTj6bLeoGHjgQFWOAHHl/Th5lk5nFZh2tLurW+TotNO4xSIs6QCFhGQJvkoKfRpTcJGntaOAOsLVNAtJPrIQM3FdUr+Wy957ToQQ=;
Received: by smtp49.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1o99en-0003kq-Q4; Wed, 06 Jul 2022 21:21:50 +0300
Date:   Wed, 6 Jul 2022 21:21:49 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Jeff King <peff@peff.net>
Cc:     Konstantin Khomoutov <kostix@bswap.ru>,
        wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git@vger.kernel.org
Subject: Re: How to display "HEAD~*" in "git log"
Message-ID: <20220706182149.gg75w6uonm4hs5af@carbon>
References: <17411d88-b27a-2d20-623d-85c49dc7754e@mails.ucas.ac.cn>
 <20220705092514.hsm7cou5bqvajvgq@carbon>
 <YsWebbaOJbaOZ6i7@coredump.intra.peff.net>
 <20220706162856.mkgfdr2lnjdbxgn4@carbon>
 <YsW9BI61tWGh9OJo@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsW9BI61tWGh9OJo@coredump.intra.peff.net>
Authentication-Results: smtp49.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9F90F105C9C96D1D3E73267EA8890F916ECC3AD6A98D329A6E067219DA3F780F616F92DC7E98051BB4760375299071DB00CD7E3E458798C8CDDDE7B70B5F5C79F
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72FFC9A718DD021A9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637889C00975665ABF68638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D83841B461E98E52BD835FE590455E94BC117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC60CDF180582EB8FBA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD18C26CFBAC0749D213D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE7B96B19DC409332107FB45A5F6E725C8D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE37812A6222701F2156E0066C2D8992A16C4224003CC836476EA7A3FFF5B025636E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637BBEA499411984DA1EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-8FC586DF: 6EFBBC1D9D64D975
X-C1DE0DAB: 9604B64F49C60606AD91A466A1DEF99B296C473AB1E142185AC9E3593CE4B31AB1881A6453793CE9274300E5CE05BD4401A9E91200F654B06469D8A8717206BB2025898894730043EECBA73F7F19507E2A0719C31494F51C9C2B6934AE262D3EE7EAB7254005DCED8DA55E71E02F9FC08E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3488E5CD2E691F55669D9E895F3ECFCB3BAFF56F3D96563B264F11A0DF464E1D072A23B43636DFF54C1D7E09C32AA3244C99B4CD59489DB95CCE5280DF335771C07101BF96129E4011927AC6DF5659F194
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojb+SzFQ2YIi8fRRzgbdsk1w==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138E457217C5F9FD08C0001B32DA331F75FF869A2E64502ED4C13BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 06, 2022 at 12:49:08PM -0400, Jeff King wrote:

[...]
> > I pondered about `git name-rev` but failed to figure out how to make it accept
> > just "HEAD" as the point of reference. Passing it "--refs=HEAD"
> > (or "--refs HEAD", FWIW) does not appear to do what I'd expect it to: a couple
> > of top commits are not annotated at all, and then they start to get annotated
> > relative to "origin/HEAD". Note that I've tested this on a detached HEAD which
> > contains an unmerged line of history.
> 
> Right. The problem is that it gets the set of possible ref tips with
> for_each_ref(), which will not include HEAD. And then worse, since the
> argument to "--refs" is a pattern, it matches junk like origin/HEAD.

Do I assume correctly that `git for-each-ref HEAD` does nothing, successfully,
for the very same reason?
If so, I wonder if this should be somehow reflected in the docs.
I mean, I have always maintained an impression that things like HEAD,
ORIGIN_HEAD, FETCH_HEAD etc are also "refs" - because they, well, reference
commits or branches.

The gitglossary manual page of my Git 2.30.2 states that

| ref
|   A name that begins with refs/ (e.g. refs/heads/master)
| <...>
|   There are a few special-purpose refs that do not begin with refs/.
|   The most notable example is HEAD.

which suggests that HEAD is a ref.

