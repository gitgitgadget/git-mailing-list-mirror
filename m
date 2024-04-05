Received: from fallback23.i.mail.ru (fallback23.i.mail.ru [79.137.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6EA15FA6C
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308323; cv=none; b=a7s7MMmImCklvKzuttM4jM/Ot0uZizhT8Z4vwr1h6Tr35u/+bRGypigmfaRMO3z/Z/KAx/LbtbIJHlExpIFcAQHWqJABq9OGfvswPJcdcTxKs49tWoMbag/DkjIPwKhLR/D/OXSpt6vmEA5j3HfRnfpe+BnovSDws2EncZV2WQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308323; c=relaxed/simple;
	bh=+ETbTVlGJSkbBRc/0I/Bk/vvbWOXx/vac2OXn7MbpuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnKg+SigFUe1tY3BkUxbiSM2css2MT9F9CQsXTKgia0/ryHtCxTbdEcGgOQ9iwXb0g8Lv1UqyHfJXcl9JsKele/Zj/N+yyaag7yrk8oA9dfo91khFeUT8hkzOnNprmGy53zpv3PhIi5ntxmD3A9f3aYaeDsY66qQ+Tsctm4yt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=OQFaam7O; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=KY5AchQ0; arc=none smtp.client-ip=79.137.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="OQFaam7O";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="KY5AchQ0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=PGYNxr6Y6QvCbYZPw4h0F1AbVfQBYrnA2iCGvLa1RqU=;
	t=1712308317;x=1712398317; 
	b=OQFaam7OpcLm8eA9Vq31k0squQtJVJVw8D5kudJ7UVBn4mcKecnNwx3wwyNcP76HHJPSnPmT7iI5IMWiFSdRQYil+qWeiAwFrWwyQAGL996J//YgTP+U5BrbSEbWilHz72KbhlLnxcCiqF57wfLEIiutzU8f7msZof90k2xxSsY=;
Received: from [10.12.4.9] (port=38188 helo=smtp30.i.mail.ru)
	by fallback23.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1rsfbw-008enb-QD
	for git@vger.kernel.org; Fri, 05 Apr 2024 12:11:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=PGYNxr6Y6QvCbYZPw4h0F1AbVfQBYrnA2iCGvLa1RqU=; t=1712308308; x=1712398308; 
	b=KY5AchQ0syNGrvXgYDKSygxMJpGkEBW5o6/bzES9RKKhanDeeKf4GeN2d9Lg1TJt6X579dVYPeS
	pTrDwzMoCtqB5I+J6hyeRCyR/0F5fQqgh5FyBZY3UvZmNXvu4IYoal+CXDuJE2J/RFrvkE+OfkRAQ
	QvR6qBAY3HxUDxJhHbc=;
Received: by smtp30.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1rsfbn-0000000ENxR-18el; Fri, 05 Apr 2024 12:11:39 +0300
Date: Fri, 5 Apr 2024 12:11:38 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: Simon Phai <simonphaikm@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git Server
Message-ID: <20240405091138.youg4wfk3r3lw2k2@carbon>
Mail-Followup-To: Simon Phai <simonphaikm@gmail.com>, git@vger.kernel.org
References: <CACArJ22jCTArv=U-XW61P8x6sa0rrXYupQvh_txdSk6vAG7p6Q@mail.gmail.com>
 <20240404100854.5vfozqo7iiyyshoc@carbon>
 <CACArJ23dNONx-Fk5VwZZ+A64aEYW0nhn+X6q50W5hKLN=VbEng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACArJ23dNONx-Fk5VwZZ+A64aEYW0nhn+X6q50W5hKLN=VbEng@mail.gmail.com>
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD96441E77B1D9F2D070849BA505E361FE147ADCEABB46C4FB9182A05F538085040CF8090E4277A3BAB03ED270C30F246C5F8A16D1E70FA8A2E38CEC11E03BA1B39E6C35C6253E650BB
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE73C714006C69EB7BAEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063770995E888C5C26978638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D87D3EFAE8666888D427623E7E1BB2E64FA60A52C9B77DA943CC7F00164DA146DAFE8445B8C89999728AA50765F79006370277CA7F994D7EF5389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8B861051D4BA689FCF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C4E7D9683544204AF302FCEF25BFAB3454AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C371330ADC0232E4BBBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF62968DCAA3E4B45B1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C376F138C68E4EE6C935872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A53946F7374439C2655002B1117B3ED696DB3C9842CB01B135D57BAD45EC4C5DE1823CB91A9FED034534781492E4B8EEADC0A73878EBD0941BBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34A503FBFE8BE8FC493C9A5877DF8E35697DD9FAFC7CDFF8EC73761DA5F7D0FF8AF76E2C46FF05B4021D7E09C32AA3244C3EB55683459DB213B58A6D757C7509E2F95882B60F5B8815EA455F16B58544A2E30DDF7C44BCB90D3871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj/bEL2UjDcTjNRazgYxvxOQ==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138AB95969094D2EBBD0045A77C8BEB847DB89D8D822445F01C01F02B2CF4A691EC2F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B467E2E30B39A63A163668BDD6ECD6F0FE5797AE62FB9DA2A7049FFFDB7839CE9E4CCB16265D9FF7C7CFFCD526E1652FD29EEF216A20AE06A5B719D978EFAD2235
X-7FA49CB5: 0D63561A33F958A594A6177D94109057D78CAF21C7A007C5E40E66478006621E8941B15DA834481FA18204E546F3947C6D3A1509E1113711F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063791665FFE12FCE6AD389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C37952320C71F5F86735872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj/bEL2UjDcTizmpMLeq1+DQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

(Reformatted to have inline style [1].)

On Thu, Apr 04, 2024 at 06:26:31PM +0800, Simon Phai wrote:

> > > I want to host my own git server, may I understand the server OS can
> > > it be windows?
> >
> > Yes.
> >
> > But note that there exist quite many ways to "host a Git server", so you
> > should maybe explore what's already there and specify your requirements
> > more precisely.
> >
> > In the simplest form (if we forget about just running git-daemon in a
> > console window - providing unprotected R/O access to a given repository),
> > you either set up Git to be accessible via an SSH server or via a web
> > server (IIS works).
> >
> actually I'm quite new to this but I would like to setup my own git
> server so that my fellows can develop our own repository, I find
> online there isn't much guide on using windows server to do it.

Unfortunately, this added not too much information to the original question.
I mean, now we know that you want to host a Git server on a Windows system,
there is a single repository to make access to and that there is going to be
more than a single person to have access to that repository.

OK, let us try to maybe move a bit further.

The first thing to know, is that Git does not provide any "high-level" -
Github-like or GitLab-like, is you want - solution out of the box.
It basically provides three ways to access Git repositories remotely:

 - A thing called "git-daemon" which provides an unprotected and
   unauthenticated access to a Git repository. Because of these properties,
   by default the access it read-only, and even though you can convince it
   to be read-write, it's a bad idea unless you really understand what you're
   doing, and, based on what you described about your prospective setup,
   this is certainly not what you want to do.

 - Two low-level programs (whose names do not matter) which are supposed to be
   used in conjunction with an SSH client and server. This means you need to
   have an SSH server running on the host with a Git repository (or multiple
   repositories), and the clients are to use SSH clients to access those
   repositories. For clients, this happens almost transparently - they do not
   need to manually run SSH clients, it's done by "git push/fetch/pull"
   commands automatically when the URL of a remote repo has the "ssh://"
   scheme, - but the server-side setup has to be rather explicit.

 - More low-level commands intended to serve access to Git repos with the help
   of an HTTP server. This works in a manner quite similar to that of SSH,
   just HTTP (these days, HTTPS is more common) transport is used instead.
   Again, clients handle this automatically if the URL of a remote repository
   to work with has the "http://" or "https://" schemes.

Note that neither of the described solutions provide any user management and
access control facilities, and this is arguably the most complex part of
setting server-side Git up: making an SSH or HTTP server start Git is not too
complex, but putting up user management and access control is harder, and is
different for SSH and HTTP.

To research, you could start with [2] and [3]. These do not present the whole
solutions but at least it's something you can probably start with.

Also note that having an SSH+Git and/or HTTP+Git combo only allows you to
maintain a so-called "rendez-vouz" repository (or a set of them) basically
used by a team to share their developments. Such a solution won't provide you
with a web-browsable access to repositories, code review, issue tracker and so
on and so forth. There will also be quite limited, if any, access to
fine-grained access control - basically to who can push where. If you need
anything of the above, you might have better luck trying a "turn-key" solution
such as [4] or [5].

 1. https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
 2. https://github.com/PowerShell/Win32-OpenSSH/wiki/Setting-up-a-Git-server-on-Windows-using-Git-for-Windows-and-Win32_OpenSSH
 3. https://smalltech.com.au/blog/how-to-run-a-git-server-on-windows-with-iis
 4. https://about.gitea.com/products/gitea/
 5. https://gogs.io

