Received: from send262.i.mail.ru (send262.i.mail.ru [95.163.59.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E627586C
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124779; cv=none; b=D7VWNR9L5x3R/LumYfCzMnesEwTwgJZr582aqryRBIa9egm/TT+CQxIIa8h50t6DSzdSkbmjana3VxlhO1YXwoWTtug/NwJGmpUpf2hfhPkMiJLnWfL2crH6UhaeTFV9wKKsNsdYtx3JGHkGhIzFKL7xjNJvtL38nqyR5/cAbwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124779; c=relaxed/simple;
	bh=lLdn7HFy3ZGduDDXoAcPjkShxNUYwoOP5MAa5n5TWRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWBQm16IGCM+mgmTgq0y82xg9O+VYfshAemBqO/HgQn6bYPMOZdqRhLU0Wm0CD4Kwu/FTU1mZllm5B83p7f/sgYjYTeyxuLlTflUNt0SN2hWySjQS9z3Wgy/KC2FKr7Zs0wzFMkHYiflMNm9K/0ck19pWSb3pMeYw7B/Ybx5rl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=xr6i1gjY; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=ganfDz7U; arc=none smtp.client-ip=95.163.59.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="xr6i1gjY";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="ganfDz7U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=lLdn7HFy3ZGduDDXoAcPjkShxNUYwoOP5MAa5n5TWRo=; t=1761124774; x=1761214774; 
	b=xr6i1gjY9VF2Br+G+QfkKgtYsf20NA4xK08NSmUYxQk/h4KcKd6Qli3+48H0dF0gbc7A/uvq+MS
	38sdMmwEQxIjRBk5s4KEEaum/OHaDJo1MZX+zxrnGR/DbfvGr5gXCG5EPnlwEI3ZuTbVuWjI/Sq0u
	yBq6F0W7MrQ2/pIWP1I=;
Received: from [10.113.93.166] (port=40170 helo=send36.i.mail.ru)
	by exim-fallback-786786785f-s7x6v with utf8esmtp (envelope-from <kostix@bswap.ru>)
	id 1vBUlb-00000000RlS-1Wll
	for git@vger.kernel.org; Wed, 22 Oct 2025 12:04:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=lLdn7HFy3ZGduDDXoAcPjkShxNUYwoOP5MAa5n5TWRo=; t=1761123863; x=1761213863; 
	b=ganfDz7UnjAUi8AvrBPzD1aGnbjMS6L8dOya5hETXXIvyXoUp//k7ZZG9lfYZ7qmocBWR9Odik4
	UxDhU/54kNjghL8A3dbDCMMJhaAWwjwXPq1VzMy1kaEmktXq9QN76afmu1leoPTChMJQt1fSge9YR
	hPnFSKM46Y3qegBjGgc=;
Received: by exim-smtp-d7d76ccc5-tdqvt with utf8esmtpa (envelope-from <kostix@bswap.ru>)
	id 1vBUlR-000000007jZ-3F1E; Wed, 22 Oct 2025 12:04:14 +0300
Date: Wed, 22 Oct 2025 12:04:14 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: Dennis Putnam <dap1@bellsouth.net>
Cc: git@vger.kernel.org
Subject: Re: Migrating Repository without Network
Message-ID: <6tygbwc6ifpuo3xylsmsveufqyroazy35u4lyblnvuls3l7n3u@d4ail3s6vtoa>
Mail-Followup-To: Dennis Putnam <dap1@bellsouth.net>, git@vger.kernel.org
References: <94497aac-c61a-4b17-9e4c-8ca9b966829c.ref@bellsouth.net>
 <94497aac-c61a-4b17-9e4c-8ca9b966829c@bellsouth.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94497aac-c61a-4b17-9e4c-8ca9b966829c@bellsouth.net>
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD96DC212D1D15EACC4C76B9335E6489BE853CDE48FA2473A7E182A05F538085040FA1FDC11160241103DE06ABAFEAF670588EB002EF057D7CA567B577EBA3AF136A63584AFBF2A4F42
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77BF46084C0059042EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375663B3451C29F32F7020A5F5D90E7DCF401575DFBEFB948445F82F262D7FE3893DF389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C04CF195F1528592878941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6E5E764EB5D94DBD4CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C22493C6898C3C2F22CEE76E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8BF5CE31487DA1EA653AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC2EE5AD8F952D28FBE2021AF6380DFAD18AA50765F7900637F09814068C508CC822CA9DD8327EE4930A3850AC1BE2E73589424AA0EF8DE9BAC4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A590727EC513C5DCF65002B1117B3ED696225E822BD92FC158E772F934B9BCD185823CB91A9FED034534781492E4B8EEADB71243024C627CEABDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D345DE7771146E56B086054FADD9D147AABD990DA0F553D6C79B7B93EEF66C622CD0882C52820A6676C1D7E09C32AA3244CC3EFEFFD14078BDF77DD89D51EBB77429E297535C15B9CF3EA455F16B58544A2E30DDF7C44BCB90D3871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVRN2q9QiacRuse9VWPbjJN0=
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD1385793C3DA94EBD07FAAE6F637C7150CBCF2B81FA2F601A67BCD8872D538E8F8CB2F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B472A7E348C1D2C180B9498435790190EF736CC6D0B9558DF7049FFFDB7839CE9E4424884F11F28FC783AC959898763960C7B1CF0771148242743222F7E415EF1464A0FC7312549652
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZ6v0zw4tmJu9oXJAaMWDS4Q==
X-Mailru-MI: 20000000000000800
X-Mras: Ok

On Tue, Oct 21, 2025 at 10:21:52AM -0400, Dennis Putnam wrote:

> I have a server with a git repository whose NIC is no longer working. I need
> to migrate that repository to a new server using a flash drive. I can only
> find instructions for migrating when both servers have network access. Can
> someone tell me how to do a migration without using a network? TIA.

Note that Git repositories - both "bare" which are typical for servers [1] -
and "normal" - which usually get created when the folks clone repositories
from centralized locations, are self-containing, so what you should do is to
just physcally copy the directory with the repository to the flash drive,
recursively. Then make sure you have another copy of it, just in case you'll
screw something later.

Then, once you have the repository on the flash drive, what to do heavily
depends on how the access to that repository was provided - simply because
there are many ways to do that - say, via SSH with several real system
accounts, via SSH with a single "virtual" user, via HTTP[S] with the
authentication provided by the mediating web server, and so on; it is also
possible to combine these ways of access. It is also possible that the repo
is under the control of some turn-key solution such as GitLab, Gitea etc.
So, in the end, what to do next depends on what setup *around* that Git repo
you have right now.

In either case, it will be possible to fetch all the data from the repo saved
on the flash drive: it might be not exactly obvious but all Git commands which
fetch data - such as "clone", "fetch" etc - do understand "plain" pathnames
such as /the/path/to/the/repo and URLs with the special scheme "file://" -
such as file:///the/path/to/the/repo, allowing them to work with on-disk repos
available locally such as on a mounted flash drive.

 1. https://git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server

