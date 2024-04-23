Received: from fallback18.i.mail.ru (fallback18.i.mail.ru [79.137.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE93B45BF3
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859825; cv=none; b=sJrsOu/A4pHV5/MhakOjG9HdliG5NaoiNhrzDEJ0l242WLHnhuVkc9leOM4cvWdwRdwr7z5gXqDciq6PoqXnWW84uZtttW/I9dc3dduNArBmsCCmUTWJJgNQANxoKxX8a7x6gL31FgpcrAVCXHN4P8QI/J2LrTIybhjimorTyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859825; c=relaxed/simple;
	bh=Bw7QGQ4fdl/KwRtrPIdOeO8pRo6MTDcM+TKJ7dUGgyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L81UM/cBWbxxMgRKcrN/AyQO38pE6/zegwPfcWlgDyVNZI916MzRcfb1Q7WJJwhV0pF1va4ISKxVXMc83Jz50ART0d1hiX74dDrHxxL9x+NCbSJLV1oyp7t6QzmCLfx3KADrobUEyl+dGbVZg76kFuunkSq3za9avu52jG/9fCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=i2mWWVig; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=YZat08D0; arc=none smtp.client-ip=79.137.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="i2mWWVig";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="YZat08D0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=QW4GRgKcOKislzv3NlxdZ77/gtBeYU0IrzgYR8ziid8=;
	t=1713859819;x=1713949819; 
	b=i2mWWVigjI0RPMSfnLunjpHnXjAhKecAKJfYVTPl7oZhtfFIONWNki5c1/W5E0R0n5Vr8y7JShqPrY/7A9fwubLwBAl4lwB8l8IrAQ8QnVbSUtLVdNOr2HN9DVikYjL/yoQh1Y+hsgm12Wl1NVE2nQ/Tsp1Hpjn2R4Qvdb4/P2A=;
Received: from [10.12.4.16] (port=57178 helo=smtp47.i.mail.ru)
	by fallback18.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1rzAXx-0029uN-BP
	for git@vger.kernel.org; Tue, 23 Apr 2024 10:26:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=QW4GRgKcOKislzv3NlxdZ77/gtBeYU0IrzgYR8ziid8=; t=1713857193; x=1713947193; 
	b=YZat08D0uSkxOzDogkgZw/40rYWAIyBM7ZfPQ84WHisuUbOSqQqvm+qIk5NsNAwGy98I5MtAREO
	2FX7SvauW0PmGpDWd/JJstBbl6qlESzjK98D2GcP+B9dyMdE50S6Wd9fEYww/TM4GcGJK1ThYwjPY
	W7ECBu0HJTAk7iH5LvY=;
Received: by smtp47.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1rzAXn-00000008GfS-0n6T; Tue, 23 Apr 2024 10:26:23 +0300
Date: Tue, 23 Apr 2024 10:26:22 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: wuzhouhui14 <wuzhouhui14@foxmail.com>
Cc: git <git@vger.kernel.org>
Subject: Re: Why conflict when merge a branch that the directory is unmodified
Message-ID: <20240423072622.hctxuaomw3cmivhu@carbon>
Mail-Followup-To: wuzhouhui14 <wuzhouhui14@foxmail.com>,
	git <git@vger.kernel.org>
References: <tencent_6FF9636AA4D83460C0CE7C9F1EEC3463CF05@qq.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6FF9636AA4D83460C0CE7C9F1EEC3463CF05@qq.com>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9CB0CA91FF61D77F067DB05CF009A096111034BA51C818A24182A05F5380850405A2BAB1070F98832C7A4B249DE6549FD5C9A973789BF87AE319530E474E3D7358483CDA5FC7E7E3C
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7DECE8D0A5E25C0FCEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637A521848D7B067A388638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D813CC2CDAB05DF696D92E3FE19BADE6776E00D091B7F80EF6CC7F00164DA146DAFE8445B8C89999728AA50765F790063735D2385A5E2B3AC3389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8ED96AA85C75E140D117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF663A3A66E4CB0153BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6C034E9EF55F0086276E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C22495FF0BFC5AEE34BE6E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6221D5A8161B58CB575ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A57A7DBC06B9A070385002B1117B3ED696D432420DEC84577E484B8D70797403F6823CB91A9FED034534781492E4B8EEADA3FB0D9844EF8EC5BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D347130F804358653A6006EAC49190BB92BBAFC562DC5DB9D772D46AD1E0FB3FEC161F6260CEF931BEA1D7E09C32AA3244C843A21F41B79094C3BA3F8B02A6D222B149CEDEE47B3B6B7EA455F16B58544A2E30DDF7C44BCB90D3871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojrqsAqpIT+T7oMeAkjc1dZw==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD1380D6D89786FEBF2F20045A77C8BEB847DE34124E69DE099E3BDB911BAD588B3F42F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B475A7E96CA7452FC883DD00B47595C7BFD442F0DCAF96DD3D049FFFDB7839CE9E89C7DB93084D3E9CE4B3774FDB0FC7F77A89B940F5695EBAB640635B65996B94
X-7FA49CB5: 0D63561A33F958A567143B46570EEB5A6733AA1023EDC022A0DC23D15E5622838941B15DA834481FA18204E546F3947C4B3849D6E5CCBAFD117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE778FCF50C7EAF9C588941B15DA834481F9449624AB7ADAF3735872C767BF85DA227C277FBC8AE2E8B895CADBD5EF1EE27EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojrqsAqpIT+T7EjbbpMYsJ5w==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Sat, Apr 20, 2024 at 11:00:45AM +0800, wuzhouhui14 wrote:

> Suppose I have two branches with following commit histories:
> 
> B----C---D(directory abc/ modified)               Branch1
>     /
> L--M---O(directory abc/ not modified)            Branch2
> 
> In previous graph, the Branch1 merge Branch2 in commit C. After commit C,
> the Branch1 modified some contents in director abc/. Branch2 doesn't
> modify directory abc/ since commit M, which has been merged into Branch1.
> 
> Then, when I do:
> 
>   git checkout Branch1
>   git merge Branch2
> 
> the director abc/ contains conflicts, why? Because the director abc/ doesn't
> changed since commit M in Branch2, so directory abc/ should not have
> conflicts.

There should not be any conflict (and FWIW I've just verified there is not
using a simple test repository).

I can suggest three reasons (while probably there could be more):

 - The contents of abc has been changed in M; in other words, abc as recorded
   in M is different from its state in C.

 - The files in abc as recorded in D and O have difference in line endings -
   such as on one branch they have LFs and on the other - CRLFs.

 - The graph in a real repository you're dealing with is more complicated
   than presented in your picture, and there exist commits between
   M and O - and may be between C and D as well - which have changed the
   state of abc, but you just failed to spot these modifications during
   your analysis.

Here's a graph from my sample repository where I tried to model your
situation:

-------------------------------- 8< --------------------------------
$ git log --graph
*   commit 7fc08ef95934a404021b46f46df3250340b5122f
|\  Merge: 2a72a51 2c8ef4f
| | Author: user <user@acme.com>
| | Date:   Tue Apr 23 10:14:31 2024 +0300
| | 
| |     Merge branch 'branch1' into branch2
| | 
| * commit 2c8ef4f49bf2a9900c009a04943422a66b2987c6 - on branch1
| | Author: user <user@acme.com>
| | Date:   Tue Apr 23 10:14:16 2024 +0300
| | 
| |     modify bar.txt
| |   
| *   commit 001a394ef8d31785362241ef63ca422dad496b39 - M in your case
| |\  Merge: b072e1e e8af26d
| | | Author: user <user@acme.com>
| | | Date:   Tue Apr 23 10:13:11 2024 +0300
| | | 
| | |     Merge branch 'branch2' into branch1
| | | 
| * | commit b072e1e86f7db47286bc08a435c71486c0ca4f77 - on branch 1
| | | Author: user <user@acme.com>
| | | Date:   Tue Apr 23 10:12:58 2024 +0300
| | | 
| | |     add bar.txt
| | | 
* | | commit 2a72a51b2aea87f6ed13013865eb181551eba31f - on branch2, like C
| |/  Author: user <user@acme.com>
|/|   Date:   Tue Apr 23 10:13:47 2024 +0300
| |   
| |       modify abc/foo.txt again
| | 
* | commit e8af26def1078e0293c46a22db3ad788fd6f38be - on branch2
| | Author: user <user@acme.com>
| | Date:   Tue Apr 23 10:12:08 2024 +0300
| | 
| |     modify abc/foo.txt
| | 
* | commit c7c0b344e943c9d548447886a50fa618e0c7f107 - branch2 is born
|/  Author: user <user@acme.com>
|   Date:   Tue Apr 23 10:11:42 2024 +0300
|   
|       add abc/foo.txt
| 
* commit 192905a78af1645603f54751ae7139d1aca22a80
  Author: user <user@acme.com>
  Date:   Tue Apr 23 10:10:56 2024 +0300
  
      root commit
-------------------------------- 8< --------------------------------

