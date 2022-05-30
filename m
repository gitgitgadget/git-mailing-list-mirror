Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D49C433EF
	for <git@archiver.kernel.org>; Mon, 30 May 2022 11:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiE3Lxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 07:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbiE3Lxy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 07:53:54 -0400
Received: from fallback12.mail.ru (fallback12.mail.ru [94.100.179.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9906FD37
        for <git@vger.kernel.org>; Mon, 30 May 2022 04:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=+5GfkYFSczcjUm66hWQb7zDa4Lk3B8kbgnGlhB4hma4=;
        t=1653911630;x=1654517030; 
        b=IpSTjGNTdnIRK05ZUjffuzvKPUcGaNUUyU75oy6/6So1UK+Vb4uPh/FDUb4N9KdhDo3dXPR4arJpn4z8vWkmbeCZVpvmCPy0W7ayHh46GARgxViKLL99Z9xoerm+9QsK2nIqUjR16E+nhlZwSEG7iW5JsUJ8kwDs0hcnc+eaUYc=;
Received: from [10.161.117.32] (port=47382 helo=smtp3.mail.ru)
        by fallback12.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1nvdxz-0001DX-OE
        for git@vger.kernel.org; Mon, 30 May 2022 14:53:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=+5GfkYFSczcjUm66hWQb7zDa4Lk3B8kbgnGlhB4hma4=;
        t=1653911627;x=1654517027; 
        b=N9cyVDBZtcdl0MoqjSoq9eILfD8DIGEBEgr3Pi9yx+LcDwcHYKcKqSpjLnlGu1LdRh8b5sKUpHFn8CRvYVoM2KO3xvb7aJejJbhZENPwqG3g2pTjvGFG1l1dFrDN0NfcC4aNKifejMn4H/TEm2pXxT6wdNDMiE0C++c12i4Fotc=;
Received: by smtp3.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1nvdxt-00023f-BJ; Mon, 30 May 2022 14:53:42 +0300
Date:   Mon, 30 May 2022 14:53:39 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Aman <amanmatreja@gmail.com>, Git List <git@vger.kernel.org>,
        "git-vger@eldondev.com" <git-vger@eldondev.com>
Subject: Re: About GIT Internals
Message-ID: <20220530115339.3torgv5c2zw75okg@carbon>
References: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
 <Yo68+kjAeP6tnduW@invalid>
 <8adba93c-7671-30d8-5a4c-4ad6e1084a22@iee.email>
 <CACMKQb3exv13sYN5uEP_AG-JYu1rmVj4HDxjdw8_Y-+maJPwGg@mail.gmail.com>
 <0201db28-d788-4458-e31d-c6cdedf5c9cf@iee.email>
 <AS8PR02MB730274D473C2BC3846D9FA3F9CDD9@AS8PR02MB7302.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB730274D473C2BC3846D9FA3F9CDD9@AS8PR02MB7302.eurprd02.prod.outlook.com>
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9517FD34F787F379111792F685D6E76A2DBE3B03BC14BFDE9182A05F5380850404C228DA9ACA6FE2785D0EDCA1280E896C1FDC92A64CD8B6672D2BF6E49F5FC89E786E4D58FA3C801
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE701173C01F417A2A6EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063764BF1E09E94CC6278638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8DE60951AF0E9417472AE45B8A36725A2117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCEA77C8EAE1CE44B0A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FF04B652EEC242312D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EED76C6ED7039589DE287C8E22D4AE2A51D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE367F1C1C3ABB44F3A6136E347CC761E07C4224003CC836476EA7A3FFF5B025636E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637EC3198ECE464ADAEEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-8FC586DF: 6EFBBC1D9D64D975
X-C1DE0DAB: 0D63561A33F958A569E95F90AB015CE3C4919F72155AA80359B5B3CD6EFF09EED59269BC5F550898D99A6476B3ADF6B4886A5961035A09600383DAD389E261318FB05168BE4CE3AF
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3480A9008907CB2FD0AD0D5A47F13A3234D77EBC0B37632ADC88DA5AF445A9E57869D0EC2AF4B9209E1D7E09C32AA3244CA1190D177C570F03168806628CEC391CB4DF56057A86259F83B48618A63566E0
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojVm63V7PcY78rceO1S4Kkxg==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD13840C1194EE3CA601EC937484E1F4C6EA4F7AA1921B336379A13BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4595CF023D9147FF659AB2EEE453624A625DC0F621BF1240C68F3CF0E9FE49B69EDEE63A750CE406FE3BC212291164215E567E148E4158BEED7C658D029FD507E
X-7FA49CB5: 0D63561A33F958A5EB0513E3C7CA815C77443D054B33CF864B4F3ADB3671D1058941B15DA834481FA18204E546F3947C19BC49529D5D2342F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637172F725B8F3BEB6B389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F790063776C4598447C51BFFD81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7C3946EFC6A664F553C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5EB0513E3C7CA815C77443D054B33CF86AFEAF1B3ED80730CD59269BC5F550898D99A6476B3ADF6B4886A5961035A09600383DAD389E261318FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojVm63V7PcY792wVJJz80/bw==
X-Mailru-MI: 8000000000000800
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 30, 2022 at 09:49:57AM +0000, Kerry, Richard wrote:

[...]
> > > 1. I haven't had the experience of working with other (perhaps even
> > > older) version control systems, like subversion. So when refering to
> > > the "control" aspect,
> > 
> > The "control" aspect was from whoever was the 'manager' that limited
> > access to the version system (i.e. acting like a museum curator), and deciding
> > if your masterpiece was worthy of inclusion as a significant example of your
> > craft, whether that was an engineering drawing or some software code.
> 
> I'm not sure I get that idea.  I worked using server-based Version Control
> systems from the mid 80s until about 5 years ago when the team moved from
> Subversion to Git.  There was never a "curator" who controlled what went
> into VC.  You did your work, developed files, and committed when you thought
> it necessary.  When a build was to be done there would then be some
> consideration of what from VC would go into the build. That is all still
> there nowadays using a distributed system (ie Git).  Those doing Open source
> work might operate a bit differently, as there is of necessity distribution
> of control of what gets into a release. But those of us who are developing
> proprietary software are still going through the same sort of release
> process.  And that's even if there isn't actually a separate person actively
> manipulating the contents of a release, it's just up to you to do what's
> necessary (actually there are others involved in dividing what will be in,
> but in our case they don't actively manipulate a repository).

I think, the "inversion of control" brought in by DVCS-es about a bit
differet set of things.

I would say it is connected to F/OSS and the way most projects have been
hosted before the DVCS-es over: usually each project had a single repository
(say, on Sourceforge or elsewhere), and it was "truly central" in the sense
that if anyone were to decide to work on that project, they would need to
contact whoever were in charge of that project and ask them to set up
permissions allowing commits - may be not to "the trunk", but anyway the
commit access was required because in centralized VCS commits are made on the
server side.
(Of course, there were projects where you could mail your patchset to a
maintainer, but maintaining such patchset was not convenient: you would either
need to host your own fully private VCS or use a tool like Quilt [1].
Also note that certain high-profile projects such as Linux and Git use mailing
lists for submission and review of patch series; this workflow coexists with
the concept of DVCS just fine.)

This approach has been effectively reversed by what was a killer-feature of
Github (I honestly am not sure whether Github was the first to implement it
but it was, and arguably is, the most popular): a network of "forks".
If a project is hosted using a DVCS, anyone is free to clone it and push their
work _elsewhere._ This point is crucial: you do not need to ask the project
maintainers to publish your modifications. Github pushed this concept quite
far: creating a fork and pushing your work there is actually a device to create
a pull request - a request to incorporate your changes into the original
project. While this approach has obvious upsides, it also has possible
downsides; one of a more visible is that when an original project becomes
dormant for some reason, its users might have hard time understanding which
one of competing forks to switch to, and there are cases when multiple
competing forks implement different features and bugfixes, in parallel.
One of the guys behind Subversion expressed his concerns about this back then
wgen Git was in its relative infancy [2].

 1. https://en.wikipedia.org/wiki/Quilt_(software)
 2. http://blog.red-bean.com/sussman/?p=20

