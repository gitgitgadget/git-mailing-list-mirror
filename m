Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83D5C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 09:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiGEJbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 05:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiGEJbH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 05:31:07 -0400
X-Greylist: delayed 342 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Jul 2022 02:31:00 PDT
Received: from smtp48.i.mail.ru (smtp48.i.mail.ru [94.100.177.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC932DE2
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 02:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=1F1OR4HNaIW4DX9s3KtMcH/ML8KrlO3sok8BHYUDQMM=;
        t=1657013460;x=1657103460; 
        b=dK8q1ds4yD+tBNyJo3v9QhA/XBtEM7/IEAijXznldJCXhnKVw6nUG2x+3ir36IoR1jzhlnTPSE5oYp5A3/PaMHSrl5eBXXeAlif1UCDesM8GdyVu586RdIG41veJ2UihVeFfjqljMC7noIxz3dZDBEcZrCxQBkT3YHHyaKEkaP4=;
Received: by smtp48.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1o8etW-0001R6-1L; Tue, 05 Jul 2022 12:30:58 +0300
Date:   Tue, 5 Jul 2022 12:30:57 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Cc:     git@vger.kernel.org
Subject: Re: How to display "HEAD~*" in "git log"
Message-ID: <20220705093057.5ewqobdjrqr3ul2k@carbon>
References: <17411d88-b27a-2d20-623d-85c49dc7754e@mails.ucas.ac.cn>
 <20220705092514.hsm7cou5bqvajvgq@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705092514.hsm7cou5bqvajvgq@carbon>
Authentication-Results: smtp48.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597DECCDA9CADD3BE68C0D767A545FF7CB3CCD62213F67905E7AA425E88FA5ADA48FA35FC48A915725F0F61512523362A74947EEACAE9851930B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE792C68BF9CD4C0E9EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637CE17C7754E00FC028638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D872A8CCB6A914E161968715D3BE4620C9117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCE4E369F5EA069656A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD18BDFBBEFFF4125B51D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEC24E1E72F37C03A07C6FCE95544A9834D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE3A816C540FC8EEC30040F9FF01DFDA4A8C4224003CC836476EA7A3FFF5B025636E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F79006373BC478629CBEC79DEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-8FC586DF: 6EFBBC1D9D64D975
X-C1DE0DAB: 9604B64F49C60606AD91A466A1DEF99B296C473AB1E14218C6CDE5D1141D2B1CCA9EAC8BA48E092D37983336143503A06946D3DE036B4867AD91A466A1DEF99B296C473AB1E14218B936CB490224F2464EEA7BD89490CAC0EDDA962BC3F61961
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3416EA6E382A5BB1763FE19FF636913F43CCDC9C5AAE98FDC599AB39FF165831406739F8F1A4EBA1501D7E09C32AA3244C47F44E2BD61FEB1C784F24235DA3D45424AF4FAF06DA24FD729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojDSjrPsecpvpFCf7WpKzPSQ==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD13863D5C4A6BB8FA5C740ACEBB0E19515BB3893FEE2500F630413BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 05, 2022 at 12:25:14PM +0300, Konstantin Khomoutov wrote:

[...]
> This is admittedly not convenient so it makes sense to turn into an alias:
> 
>  [alias]
>    relog = "!relog() { git log --oneline \"$@\" | { n=0; while read line; do printf 'HEAD~%d\t%s\n' $n \"$line\"; n=$((n+1)); done; }; }; relog"
[...]

An alternative to an alias it creating a specially named script file which
must be executable and located in a directorly listed in the environment
variable PATH.
For instance, if you have ~/bin listed in your PATH, you can create a file
named "git-relog" containing the encantation from my first mail in this
thread, then call

  $ git relog

and that script will be found and executed.

