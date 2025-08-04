Received: from send123.i.mail.ru (send123.i.mail.ru [89.221.237.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B61FDD
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320691; cv=none; b=kUJb4Xkb6XLI2cGlMBgPZhZqNIf7I6ZjDDqJ3E9ImKxDofz7HfhArzdUjUnnBz/tEw3/ja7suAxEW51y2cvG9obTWPmV4dvrd8XIe1+1rkvTUtGaVP7XyQyi8SZGMSbqMXqleavSlLVWo9DDqcy3xsY1gwGG+UUOntHL1NU2V8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320691; c=relaxed/simple;
	bh=tfZHa4nKnQRd3+fVIKsSjeYpWJc8txNQYd1lZW+my/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g18ELf6RenVGKhqSkzgHmpIE8rVFX02DPwE78ZfEjAFuSKLuG47Ha73pENp79ojz5/BuNOWoOFCgq3Oxo44lZ0G3/Kx455SbCj9snIaY0LD7eudts2amU4zkvUqZ0mP8yo0HKcckR5IoJaLEbYaNDxB8+Qpq87+s7+1lBeacalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=dorLtHRw; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=GRndOOKe; arc=none smtp.client-ip=89.221.237.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="dorLtHRw";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="GRndOOKe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=vsBYSenYRBlNL8grYE0JN12VLeQ97eKq7aPb/K2jqYs=; t=1754320685; x=1754410685; 
	b=dorLtHRwwWZ3AeNBpw1B32nXc/0ueOwO+LSUeMbYMLMBN0x3o1gmVG+5GK7YrNenhpcs1lmfDzZ
	rLXsxO/4/GBA12lufTtDNeaR2y5S9talywrqk2UwaxH50R+y/lZ6mkpEjRiTuJ90Od/EHZ29VhGmM
	gBHueAhY8yG0BFn8h48=;
Received: from [10.113.128.205] (port=43746 helo=send278.i.mail.ru)
	by exim-fallback-67c4d9c84-vdrjl with utf8esmtp (envelope-from <kostix@bswap.ru>)
	id 1uiwiD-00000000BUP-2dV8
	for git@vger.kernel.org; Mon, 04 Aug 2025 18:02:53 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=vsBYSenYRBlNL8grYE0JN12VLeQ97eKq7aPb/K2jqYs=; t=1754319773; x=1754409773; 
	b=GRndOOKeoFu9QnEobC0ooxhF8ihyjmMPVbKyHwXsqdvik5F1PKgzggWfpb1esFhfU4Jy25gy8Ha
	D2s74qyQ4HQQ7ZVvZFhTkpS73XIl2jq3ftwXaAIT+3uK4beEsjhsuocRyDC4OXhWsLPx2P1ywNOcs
	iIxwaF+2IFhKiou9L24=;
Received: by exim-smtp-55657cf74-mcl6g with utf8esmtpa (envelope-from <kostix@bswap.ru>)
	id 1uiwi4-00000000UT7-0LGV; Mon, 04 Aug 2025 18:02:44 +0300
Date: Mon, 4 Aug 2025 18:02:43 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: FMorschel <git@fmorschel.dev>
Cc: git@vger.kernel.org
Subject: Re: Feature Request: git mv --after (new flag)
Message-ID: <hi7t3qk7difgzip7syscarnf5ui5avnhmjxil4vzurwcfo7a6x@drccf7gibn72>
Mail-Followup-To: FMorschel <git@fmorschel.dev>, git@vger.kernel.org
References: <1fa7a8d8-3ae5-4913-b3b5-21d8f67e567d@fmorschel.dev>
 <0afc01b2-11a2-4f77-a858-7a444e8bb1d4@fmorschel.dev>
 <2f505f75-112a-4b71-bb05-ea0cb7731cd7@fmorschel.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f505f75-112a-4b71-bb05-ea0cb7731cd7@fmorschel.dev>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9478038FB256C3880603BF02318E888A60D0BDA6DDA3FE41300894C459B0CD1B93B57D7AE8F951C29C8659717DE9923888563C990056C37A2701D12D7FF3808D6DBBA668AFD329EE4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AED985C8E545F588EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566BE0243970E9154AB7E19BAC2AAE9B1D5FA9E64BBB8327D5F1F9F00780B7A16F2389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C07E7E81EEA8A9722B8941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6957A4DEDD2346B42CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C224992BB4263BAE1DD6776E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8BE262B53D2D1979073AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E735B25CBF701D1BE873C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A56CC97AED74CEE8895002B1117B3ED696A7C01848112BACA05B6221DB6D7A72AD823CB91A9FED034534781492E4B8EEADD0953842B444AAC3BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34047E322BFAFD69BD54A665AC5E6E413D94334AF6084982C00CDA29250DF3691A5C96921EB5B0ABCB1D7E09C32AA3244C72771301EE4C6D4877DD89D51EBB77423EBBADF4432AB91EEA455F16B58544A2E30DDF7C44BCB90D3871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVUlTLJrxaS1ugrCrRgcPmf8=
X-Mailru-Sender: 139A7956A63CACCF7216901AE3D43F1495DDBF539E29B7FCB951B70A5BD4BD8EC5FEEC5B7693336D44CC085085D1A849FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64A0D4ABDE8C577C2ED
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4C75C13076030B660521124F307D4EDE2CD7F270CDD29C177049FFFDB7839CE9E740A8FF19735BC8521A4B35EB3988779EEBBF58373C350BAFDDBFA876DC484C167CA8096E8EC8A8F
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZvyWCVIpJIoztoex/moF8MQ==
X-Mailru-MI: 20000000000000800
X-Mras: Ok

On Mon, Aug 04, 2025 at 02:05:32PM +0000, FMorschel wrote:

> This is a request to add an –after mode to git mv command to explicitly 
> mark a filesystem rename after it has occurred (analogous to mercurial 
> => hg mv –after).
> 
> This would allow IDE/Language refactor renames/moves and would make sure 
> git still detects the moves correctly for keeping the correct commit 
> history.

Git does not track renames in the commits in creates, so, basically, if you
have a file foo.txt under the Git's control, and do

  $ git mv foo.txt bar.txt
  $ git commit

The recorded commit will reference a tree object which will - compared
to the tree object of the preceding commit - have an entry for bar.txt
and not have an entry for foo.txt.

Hence a command like "git mv --after", if implemented, would be a pure
syntactic sugar for "git rm <old_name> && git add <new_name>".

