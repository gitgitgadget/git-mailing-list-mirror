Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91120CCC4
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330627; cv=none; b=WzjVXu3LXPtwYmoKfaP+QXTBfK28IEuxuBJr+PI4+H6OwQbj144lJ5bYHkHOSxFAezHA3D+4VcWkb2dQm6EJyn7mSDyjXspT+xfWFW/Kbqg5dotxvo2Hv69EP1IE2DQWQc8/E0o46v4L1J7PXPjYeSn2U3AISbTZJjKOG6aR27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330627; c=relaxed/simple;
	bh=mvUoeV3p3by86xshWb3/dGCiRx7YBjZXioe5BJ5sG/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQtLz9tHHssGc2GnzAFs+Md5vnOyGamoqbW1tg3jWc5z3t6RQgah1aZKgi4hCkyTWzHnwfwTSL8Ujk2umoJ5AF3rV8mHd97QAweL7NFB+68B1wQOgEMVCy2CmYBdUk9aTIvlZcMS4iNziYce6h1jrvOZ538Cpc0MZfArIpo+wvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=cm2jrAQx; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=mobO9702; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=a+OeN7Y9; arc=none smtp.client-ip=79.137.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="cm2jrAQx";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="mobO9702";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="a+OeN7Y9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=DCrXwAhGsta5fPfUcwV+FgS22lZ9MR76OepzlFMwURQ=;
	t=1733330622;x=1733420622; 
	b=cm2jrAQxVDnQ2zKyPl/KDobQE66ApalvyPNybxh5vuylngCBehPx9c7WbtYBMgfRHbt4jS711jvdVFHKKoPvRnZn5Gj+l0kjyNQPCx92QdvEtXxFmcYYYSWvF4mZfmPippqYE6DcqXaQ6JoqK5/phz50VjMYILSmK7KhNc+1iIs=;
Received: from [10.113.97.159] (port=35726 helo=send100.i.mail.ru)
	by fallback3.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1tIrki-00FEVS-T9
	for git@vger.kernel.org; Wed, 04 Dec 2024 18:57:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=DCrXwAhGsta5fPfUcwV+FgS22lZ9MR76OepzlFMwURQ=; t=1733327844; x=1733417844; 
	b=mobO9702r7rSqntwQxx48mrCmwLPE6j1r7d3fLpxKWqHWo3u/Vhy2HRvs4yueFAvasuGzOX38e0
	kKEk4PgogATlOsW7u3U1zhsY06W4uNq2QR3WihjW6ocE2L15oEofworpHw7Oh3Kw3jvT5NsvF9sUX
	fVB8qW3+i479zeox0gc=;
Received: from [10.113.77.217] (port=39148 helo=send220.i.mail.ru)
	by exim-fallback-777bd747b9-ktgl8 with esmtp (envelope-from <kostix@bswap.ru>)
	id 1tIrka-00000000SFu-2W7f
	for git@vger.kernel.org; Wed, 04 Dec 2024 18:57:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=DCrXwAhGsta5fPfUcwV+FgS22lZ9MR76OepzlFMwURQ=; t=1733327836; x=1733417836; 
	b=a+OeN7Y9xik01YqfE9Af6utDEZeJLhPlcB0vjBvNc1+Gu3ZgYl4buwBLTdv7lVz/ndYcsJN/AUm
	3DRxB5RoCQMR/VctgfAaChfw187GF6L9mukXgEgLseVup0ohq1TciR7c8IJtzHW8EOa8ioFTTVB6t
	IqxDzXP+ySDDb1xse40=;
Received: by exim-smtp-5dbb8c54cf-ktkhf with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1tIrkP-00000000UZJ-2Yxi; Wed, 04 Dec 2024 18:57:06 +0300
Date: Wed, 4 Dec 2024 18:57:04 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: martin f krafft <madduck@madduck.net>
Cc: git@vger.kernel.org
Subject: Re: git-daemon not consulting ~/.gitconfig
Message-ID: <20241204155704.sxti6mn7zyr3vmyt@carbon>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	git@vger.kernel.org
References: <fj5vgwmc5wtyzcxxnmcgw7whclm6qf7p5sxzh3nbao3feyutj6@daizbooxk22j>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fj5vgwmc5wtyzcxxnmcgw7whclm6qf7p5sxzh3nbao3feyutj6@daizbooxk22j>
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9A8C4BB59E01B6E9F648BA0BCD7732E988D586D4DFC7E4796182A05F5380850404C228DA9ACA6FE2706AE08F5AAE0652F3DE06ABAFEAF670512E4DD3DC02D7B6745D2578103E45E16C4241D229770A8A5
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C6068CE86C2B75F5EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D99F96657F58F1038638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8DE469046ECFB51074894751A8191B36BD2712B1E53A81C41CC7F00164DA146DAFE8445B8C89999728AA50765F7900637CAEE156C82D3D7D9389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC82FFDA4F57982C5F4F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C67F1C1C3ABB44F3A2D242C3BD2E3F4C64AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C30C3F171C468AE86FBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C321259270BBF67A2035872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A50D4C0A42CEC829B15002B1117B3ED696C21CF0848CF93392B2920F75BA9A967F823CB91A9FED034534781492E4B8EEAD47A3109F1ACFD409BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D342C0B628602DFD0BCD831C7F9D3CCB2659913370568F3CCFC669DF480C1B0E500D5B49145C4A243F01D7E09C32AA3244C5D4E75038657E60577DD89D51EBB774219C072837BD66560EA455F16B58544A2E30DDF7C44BCB90D3871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojwp1kXJWyJOa4CIKrlcjIGg==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138FE1391822F18F406E9E07FF329DA7D4792F9BF4964C537F391EAE9FFF4F056EB2F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4CE318559F77298F491764EEA0D295AB716880AF0EE296514049FFFDB7839CE9EF37DFD9029CDAB4BB3D97DEFB37D5A251AF0747B41B1BC5DDD072FC12F27CA952A7E163C7F79FD79
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSpZAf3ZdhvE+Zf1Wbpd8t+6
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4CE318559F77298F491764EEA0D295AB7FB40A21BF0FF00A4049FFFDB7839CE9EF37DFD9029CDAB4BDB43BD249D23CE36CFD07847233B4D8F0EA88AED9C519990
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSqDNa1okXa/85uf5RTkiCWD
X-Mailru-MI: 20000000000000800
X-Mras: Ok

On Wed, Dec 04, 2024 at 11:23:36AM +0100, martin f krafft wrote:

[...]
> in the logs. However, adding the config to `~gitdaemon/.gitconfig` did not
> have the desired effect. Neither did adding it to `~root/.gitconfig` and
> only `/etc/gitconfig` works.
> 
> So I checked `strace` and found that when invoked by `git-daemon`, Git
> doesn't even consult `~/.gitconfig`, and I think this may be a bug.
[...]

Given the following passage from the docs, describing the "--user" option,

| Like many programs that switch user id, the daemon does not reset
| environment variables such as $HOME when it runs git programs, e.g.
| upload-pack and receive-pack. When using this option, you may also want to
| set and export HOME to point at the home directory of <user> before starting
| the daemon, and make sure any Git configuration files in that directory are
| readable by <user>.

the behavior does indeed look like a bug.

