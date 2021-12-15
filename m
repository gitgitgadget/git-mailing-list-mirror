Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926C3C31D68
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 16:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbhLOPwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 10:52:13 -0500
Received: from fallback15.mail.ru ([94.100.179.50]:45262 "EHLO
        fallback15.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbhLOPwM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 10:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=P6pSJ8/dkx8P3bt0grB6YOBGmVSfw+cikRzUCPiTH/E=;
        t=1639583532;x=1640188932; 
        b=EHsbY9zXPQHkUIYsMkrGTXQJ3kdhcUr/y2rZoVsf0ddCf8Dw3ZQzj41DbmNS6QBn3Tq4Ty7ss/82+rB8VQk8PFfMMID/gtbI0/7ceUexvRQPowA4ubr00n2H7Ti2HLvtlBjCzru3zH/8P3lKNjUJF80Nyev9rS2FHZrJD68u100=;
Received: from [10.161.64.57] (port=40100 helo=smtp49.i.mail.ru)
        by fallback15.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1mxWZf-0004HZ-06
        for git@vger.kernel.org; Wed, 15 Dec 2021 18:52:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=P6pSJ8/dkx8P3bt0grB6YOBGmVSfw+cikRzUCPiTH/E=;
        t=1639583531;x=1640188931; 
        b=yg3RWuUHgUzYN6bywogF9J0r+XY/rkkil7hDuvRlOsERCUcdUCsR/QD7yK3Ub7qiM52LhwvvYQ8HMB2SjWJzDcx8YhM/Kzg8qSw1ofuSL/MVzJRdztBRlawZ1ivuvIFBY4xFhLlVWWDxC464ntgLBADY8qxkAd8l6Z8pmdepdTY=;
Received: by smtp49.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1mxWZc-0006Vo-6H; Wed, 15 Dec 2021 18:52:08 +0300
Date:   Wed, 15 Dec 2021 18:52:21 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Ana Jovanovska <ajovanovska@sumologic.com>
Cc:     git@vger.kernel.org, Enrico Benzoni <ebenzoni@sumologic.com>,
        Michele Zambelli <mzambelli@sumologic.com>
Subject: Re: Git SCM API remote
Message-ID: <20211215155221.tzg55fxerpowj623@carbon>
References: <CA++hZeHEVN6JZMdtXMjG2bDqerJjrFjhjYOry_rnWDgjTbQ8aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA++hZeHEVN6JZMdtXMjG2bDqerJjrFjhjYOry_rnWDgjTbQ8aA@mail.gmail.com>
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9FFF274446F725B74A9CFE9BC757439B33E0841E1B5245F81182A05F53808504033FD3740C6B9CF1D80553994F1DA5B1A565B25ADD6B7E06109DBE2617DDFA048
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78BAADB77C21FF6F2EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006376A27C8034CCD05E58638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D80E9E77A644EBE5D6B419A8B4D18D6403117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCAA867293B0326636D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BAA867293B0326636D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EED76C6ED7039589DE302FCEF25BFAB3454AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C375AB9F4AF0B63FD1BA3038C0950A5D36B5C8C57E37DE458B0BC6067A898B09E46D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE798228CBAD4AC77F6731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A57756A9815AA709DE687F7438BD093DF774A3D6604B002617D59269BC5F550898D99A6476B3ADF6B47008B74DF8BB9EF7333BD3B22AA88B938A852937E12ACA75040BF32255FAA22B410CA545F18667F91A7EA1CDA0B5A7A0
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D346B222596F62B8FA96A18B2B0A1A45BAB19EB250396E399E5445909B85A953D1FCDFEFCABF4DCF1301D7E09C32AA3244C4507D7C75E7EE9DE77655D24E524A0723A92A9747B6CC886927AC6DF5659F194
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojqIoINCajonArbue5d8IsxQ==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138EF4A24711CBE2ED8F2CCCEED148367853F494BBBF113FEB813BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4C456381A22064F8E4D2CF43611C06B1314338FA414495417049FFFDB7839CE9E6AE0A34E1E843E513150719D71864C9E25C627B54BC4B84BE09C7282D49FE238
X-7FA49CB5: 0D63561A33F958A5912C355445F337C4037361BB16919B1D78FCF50C7EAF9C588941B15DA834481FA18204E546F3947C4E7D9683544204AFF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637BA2F0AEB80054583389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637DDF5CD7B9F40093CD81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7C565C1E6824D8037B43847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5912C355445F337C4037361BB16919B1D113356CDC084B5BBD59269BC5F550898D99A6476B3ADF6B4886A5961035A09600383DAD389E261318FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojqIoINCajonDFf5z/UTFnaw==
X-Mailru-MI: 800
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 15, 2021 at 01:57:42PM +0100, Ana Jovanovska wrote:

> I am developing the integration with Git SCM and I will need your help
> on this matter.
> This is API remote doc https://www.git-scm.com/docs/api-remote .
No, it is not.

Unfortunately, looks like your knowledge about Git itself is a bit lacking
currently as you appear to not be aware of Git's terminology.
I would say, reading a book on Git ([1] is good), and a couple of manuals on
it, possibly starting with [2].

> Can I have more information on how to use it, do I need some additional
> library?

Git itself does not ship anything you could call a library, but it is
comprised from a large number of individual commands (which are what you would
call "command-line commands") which are broadly divided into two categories -
for end users and for use by other commands; these groups are called
"porcelain" and "plumbing". Call out to plumbing-layer commands is the typical
way to automate Git.

If you need to somehow manipulate Git repositores - you did not say anything
about what that "integration" has to be about, - without having Git installed,
you may resort to 3rd-party libraries such as [3]. ISTR it also has wrapping
libraries in several programming languages.

Also note that there exist libraries for various programming languages which
wrap calls to plumbing-layer Git commands, so they sort of implement something
in between a "pure library" which does not call out to Git and calling Git
directly.

1. https://www.git-scm.com/book/en/v2
2. https://www.git-scm.com/docs/git
3. https://libgit2.org/

