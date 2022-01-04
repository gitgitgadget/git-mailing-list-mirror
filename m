Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7707CC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 16:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbiADQeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 11:34:08 -0500
Received: from fallback23.m.smailru.net ([94.100.187.222]:54336 "EHLO
        fallback23.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229984AbiADQeH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 11:34:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=/rISdijcWqXxgqJHuUE2IN07iw+nUaX4yJYd9yW4B8E=;
        t=1641314047;x=1641919447; 
        b=o4qSqLCT/CIjtK80Qd486hrMcobNcmiVCdsqpXnXxtk9/qEoyoJA3fduzcAKIB0BsP7Er3IwhsDsD872GQ0h2zoWf9sbOdaVOn9cy5K/XM3SEZGaLbHsl2/1yWKISeDhWO8YXn7RCbVc4pR5GcyZ0Hi6Xv2FYcrL4o6F1AsS4/s=;
Received: from [10.161.64.55] (port=39154 helo=smtp47.i.mail.ru)
        by fallback23.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1n4mlB-0004x8-Bd
        for git@vger.kernel.org; Tue, 04 Jan 2022 19:34:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=/rISdijcWqXxgqJHuUE2IN07iw+nUaX4yJYd9yW4B8E=;
        t=1641314045;x=1641919445; 
        b=wzIgPQAldir5vAbSz+1+++vbfecSUYXdoZ1XIULuucemC0LlPt6p9y1kNDXQUj7xPSNSiXb9rHPb7Nxc7zAN8IX8W8xYow0y3PQOBSV40imNGnWIszTUDwnCecB06lgPQn+2DvxTxIeYaQGSbzAGOAoJ/U69oL9Snb7vD9zFgfk=;
Received: by smtp47.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1n4ml8-0002zc-Vf; Tue, 04 Jan 2022 19:34:03 +0300
Date:   Tue, 4 Jan 2022 19:34:02 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Ana Jovanovska <ajovanovska@sumologic.com>
Cc:     Konstantin Khomoutov <kostix@bswap.ru>, git@vger.kernel.org,
        Enrico Benzoni <ebenzoni@sumologic.com>,
        Michele Zambelli <mzambelli@sumologic.com>
Subject: Re: Git SCM API remote
Message-ID: <20220104163402.cbkwoj3agc2k4i4r@carbon>
References: <CA++hZeHEVN6JZMdtXMjG2bDqerJjrFjhjYOry_rnWDgjTbQ8aA@mail.gmail.com>
 <20211215155221.tzg55fxerpowj623@carbon>
 <CA++hZeFiFAuCD=C-2xJJt3yd5guyJrssjtpAmAqYXkMQuRtfpw@mail.gmail.com>
 <CA++hZeELoG1yMdu4pGpRx+2bBF63yNgOwV-UoB5=CH3pAg9jNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA++hZeELoG1yMdu4pGpRx+2bBF63yNgOwV-UoB5=CH3pAg9jNA@mail.gmail.com>
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD94D5EF110843E6A6756D129FFADCD37D44B66CFF8B7714B73182A05F53808504055741265EE422506A25EC70A130E45849FD6BE6614BC278D61D6021DDA9578E3
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE79961E86438F5BDAEEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637CF19945FAF91394A8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8C080BBB54CCC24B051D74215151B49F6117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCF1175FABE1C0F9B6A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD18C26CFBAC0749D213D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE91ADC097FE2C3A083D5BA627BF9F2FCFD8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE34AB4081B6A6C2E07AD7EC71F1DB88427C4224003CC836476EA7A3FFF5B025636E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F79006377F02F59195295693EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5A6588E732842F6B1107693995F5E6F77F70843D95D77C983D59269BC5F550898D99A6476B3ADF6B47008B74DF8BB9EF7333BD3B22AA88B938A852937E12ACA75968C9853642EB7C3410CA545F18667F91A7EA1CDA0B5A7A0
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34103A2CD2CFC42C67B90008060FF723FEF40DE7F09D57D60ECA77A902B17DE9F3C25AB681ACBE4F731D7E09C32AA3244C3A70433F49F89330986F13098BACBC9C1DD47778AE04E04D83B48618A63566E0
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj3qwktYIpPn8ct+qiXITZRg==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138B881CA4CE95E4F276436554A84F269147D716BD2B5F77E3813BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B458EAA7E4B0EE0F09E17E9F3906B11922EE4D70694A97BD7A68F3CF0E9FE49B69F82D0B5C301D73E7A391AE0E2E6BBEC35E04F02E6A55206940EC23733209E4E7
X-7FA49CB5: 0D63561A33F958A58CCDD3A2A78926495699266CA59D0C256EB942B6980AACAC8941B15DA834481FA18204E546F3947C10A7BA5215B3CCECF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637007B9EE9EB8896AF389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F790063776C4598447C51BFFD81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7CE1AEB6AF2DA18B6243847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A58CCDD3A2A78926495699266CA59D0C25A4BA96FBDC772C07D59269BC5F550898D99A6476B3ADF6B4886A5961035A09600383DAD389E261318FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj3qwktYIpPn92kf1ULWefOg==
X-Mailru-MI: 800
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Ana!

(Reformatted; please do not top-post when participating in technical
discussions, use what it called "inline" or "interleaved" style [1].)

On Mon, Jan 03, 2022 at 03:51:10PM +0100, Ana Jovanovska wrote:

[...]
>> Git itself does not ship anything you could call a library, but it is
>> comprised from a large number of individual commands (which are what you would
>> call "command-line commands") which are broadly divided into two categories -
>> for end users and for use by other commands; these groups are called
>> "porcelain" and "plumbing". Call out to plumbing-layer commands is the typical
>> way to automate Git.
[...]
> The libgit2, more specifically pygit2 helped me in creating
> repositories, branches and getting a list of branches locally.
> But with the integration (in Python), would like to connect to git
> remote server and to be able to do some of the git commands
> (https://www.pygit2.org/index.html) as mentioned.
> I looked into Remotes - RemoteCallbacks - credentials(url,
> username_from_url, allowed_types)
> (https://www.pygit2.org/remotes.html#pygit2.RemoteCallbacks.credentials).
> 
> Can we have support on this matter - how can we do it? Also if you are
> available for a call, so to better understand, it will be great. Thank
> you in advance.

I think you may still have certain misunderstanding about what Git is and what
the communication venue we're using for our exchange is about; I'll try to
clear things up.


The first thing worth considering is that both Git and PyGit2 (and libgit2 the
latter uses) - all are independent pieces of what is called "free software" [2].
The fact they are independent means they may have conceptual relation - such
as libgit2 knowing the format of Git repositories and hence being able to
manipulate them or PyGit2 physically calling out into libgit2 to perform its
tasks - but they all are different projects run by different sets of people
having different goals, code repositories, workflows, schedules etc. The only
thing they have in common it that they allow to do something with Git
repositories.

Our discussion is talking place on the mailing list dedicated to the
development of Git itself: bugs in Git are reported here, patch sets
implementing new features or fixing bugs are posted here and are reviewed
here. That is all: both PyGit2 and libgit2 all have their own communication
venues and cannot be sensibly discussed here - if only because the developers
working on those projects may simply not be reading this list because they do
not have to. What follows, is that our discussion is off-topic for this list
and, what is supposedly more important, has low chances of being helpful to
you.


What I recommend is to use watever communication venue the PyGit2 developers
recommend using. From cursory glance over the project's site, I failed to find
a definitive place to ask questions but their project on Github has
"discussions" enabled [3] so you could try to open one.
Another sort-of obvious thing to try is to use the "pygit2" tag on
StackOverflow [4], but please first make sure you have searched for your
problem there using that tag.


As to your particular problem - „to be able to connect to git remote server
and to be able to do some of the git commands” - it begs for clarification:
are you merely after "mundane" Git tasks involving remote repositories - such
as cloning, fetching, pushing, - or are you really after „advanced” stuff such
as executing arbitrary Git commands on a remote server?
If it's about the former, a quick search on the PyGit2 site turns up
"recepies" which should get you started (e.g. [5] covers cloning).
If it's about running arbitrary commands, this is completely another topic
which is may be way harder to grok so I'd not go this route until we know you
really need it.


 1. https://en.wikipedia.org/wiki/Posting_style
 2. https://en.wikipedia.org/wiki/Free_software
 3. https://github.com/libgit2/pygit2/discussions
 4. https://stackoverflow.com/questions/tagged/pygit2
 5. https://www.pygit2.org/recipes/git-clone-ssh.html

