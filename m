Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65809C43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 16:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiGFQ3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiGFQ3B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 12:29:01 -0400
Received: from smtp32.i.mail.ru (smtp32.i.mail.ru [94.100.177.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32147220FE
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=BJMHxfUqhCl8IwvalDlLJaNZeiYqJixEe08aJr7c7I0=;
        t=1657124940;x=1657214940; 
        b=vni8FLexjmBNc0EqZIMhcfBXZbPPrIy+SfVAnnM4ttgOhflrF8gvwV4aHhAeKcq70bQbskQqewudTVt2hcKUCPFPIliX5DUT5KDYeeW0eYbjxGwRAyRtuHkHy/sX6AVSO9AAj0r0A6ODStS1jmdTXgkhEa7tRlpn1QYQcdW9txE=;
Received: by smtp32.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1o97tY-0003pR-Q5; Wed, 06 Jul 2022 19:28:57 +0300
Date:   Wed, 6 Jul 2022 19:28:56 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Jeff King <peff@peff.net>
Cc:     Konstantin Khomoutov <kostix@bswap.ru>,
        wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git@vger.kernel.org
Subject: Re: How to display "HEAD~*" in "git log"
Message-ID: <20220706162856.mkgfdr2lnjdbxgn4@carbon>
References: <17411d88-b27a-2d20-623d-85c49dc7754e@mails.ucas.ac.cn>
 <20220705092514.hsm7cou5bqvajvgq@carbon>
 <YsWebbaOJbaOZ6i7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsWebbaOJbaOZ6i7@coredump.intra.peff.net>
Authentication-Results: smtp32.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9F90F105C9C96D1D3B8E5AF3647667F4A96EBADD5F809B5ABE067219DA3F780F608E11B25A4629E0D3EC583853DDF845F4F593EEF4E082AE651CE0648C9E8651D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE73A0E02362971E860EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006374A24022C550661178638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D84899F62860A9FF713D383559BD7FE84D117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCEA77C8EAE1CE44B0A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD182CC0D3CB04F14752D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE0AC5B80A05675ACDFCE65BE3358055BDD8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE3D166953D3EA3826B040F9FF01DFDA4A8C4224003CC836476EA7A3FFF5B025636E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F79006373BC478629CBEC79DEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-8FC586DF: 6EFBBC1D9D64D975
X-C1DE0DAB: 9604B64F49C60606AD91A466A1DEF99B296C473AB1E142185AC9E3593CE4B31AB1881A6453793CE9274300E5CE05BD4401A9E91200F654B0EA9B9E1F19CA508520258988947300431B4316C535B54BEAC9DC01CBD0450ACE9C2B6934AE262D3EE7EAB7254005DCED8DA55E71E02F9FC08E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D349DAEDEF7DE8FDCFA90CF2BDD19DDDA59D7DD62999D187DB2071A72B8EEFC382CE9B370199CFBB7D91D7E09C32AA3244CA8659A9E86C3EF2EDB550AA18818FDAE05AB220A9D022EBC927AC6DF5659F194
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojb+SzFQ2YIi9d2x0i8/iDAg==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD13818F6A6C0AFFAB2F0A11303A5DF71089FEF7B3447CC7C752213BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 06, 2022 at 10:38:37AM -0400, Jeff King wrote:

[...]

> > You can script this. Provided you have a POSIX-compatible shell (such as
> > Bash), the encantation would read something like
> > 
> >  $ git log --oneline | { n=0; while read line; do printf '%d\t%s\n' $n "$line"; done; }
> 
> That will just number the commits linearly as they are printed. If your
> history has any branches or merges, eventually it will get out of sync.

Thanks, I did not think of this.

> You can use "name-rev" to annotate commits with names that respect the
> history. It only matches full oids, so try:
> 
>   git log --oneline --no-abbrev | git name-rev --stdin

I pondered about `git name-rev` but failed to figure out how to make it accept
just "HEAD" as the point of reference. Passing it "--refs=HEAD"
(or "--refs HEAD", FWIW) does not appear to do what I'd expect it to: a couple
of top commits are not annotated at all, and then they start to get annotated
relative to "origin/HEAD". Note that I've tested this on a detached HEAD which
contains an unmerged line of history.

[...]

