Received: from send170.i.mail.ru (send170.i.mail.ru [95.163.59.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2533123C
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764840016; cv=none; b=dq6KFzLJIA5iVtWsIhSlVxn0R+MLxJ0YlGgyRU3Ur6pwJIfg3DnsYIlHePiYUcdRCpshE75HyIa+CtGkQv/1wLH0xFTItak5iukzvyMbdVnq+FtD3QMu+tyOO21O7iynxGqgBtFfpAYBtWCOB+VIDz0ADpYcmYlQJv/Y1tE7TI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764840016; c=relaxed/simple;
	bh=3yKEIdw7tbGQMOxA9tFY6Bef3oRLVVvg3YWjlgK9vW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5aKfiR6E3Sb4zFBi3Vc4t/Y568OYzkHsYpt1S/ZMJkA8K0oF4fP/3DGJM99/zxlEu7/SCi/tleXGmqHEDoms3eWIUbrMfYCzqcIOXVeAIFPMi+B1qtCYqOKhy0QMMM5dRutsb7DG4D3ECOS8hY8jn1yeuDFJ9BgcKzsYisZQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=zFkbtMpm; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=nW8rHaNT; arc=none smtp.client-ip=95.163.59.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="zFkbtMpm";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="nW8rHaNT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=eriYFRmNj+vjDiySz6aoRAeafLdrq314rCGu/WSovPI=; t=1764840012; x=1764930012; 
	b=zFkbtMpmuW1wYxt3Um4h6nlpBB0QaJq8udAZomAsAwiSn7omNH9G+uJHTkg098FEUlYOrEfJH0X
	/5NS1yjF6Dc8xjCJjJKhwG/dWU6KYFra8xm5dWlpV5J6H3ptbew5cvmRrEpW3F6rXJ3Zkzxzu+Cp5
	5WSKpsrFy3Do6360Am0=;
Received: from [10.113.82.222] (port=59808 helo=send129.i.mail.ru)
	by exim-fallback-657d7677d-rqctk with utf8esmtp (envelope-from <kostix@bswap.ru>)
	id 1vR5Gm-00000000Ohq-2Ta6; Thu, 04 Dec 2025 12:05:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=eriYFRmNj+vjDiySz6aoRAeafLdrq314rCGu/WSovPI=; t=1764839100; x=1764929100; 
	b=nW8rHaNTYIXXjweGsISXvRruSpqXg4+rEj+Lr5bff9WJk6kHu44G5C5SDo0iZzbzkI1PS+AQooU
	LwWwrqovBh8ZtqCx9hMj4jh0au7ia66CCIh4hnXROyDQvo55DzjGsNPqDEjYEF/wgKVOfbo2zACnQ
	3bx3TxC4jf1vWMkVsrY=;
Received: by exim-smtp-9954f69f5-xns8j with utf8esmtpa (envelope-from <kostix@bswap.ru>)
	id 1vR5Gc-000000003GF-2lID; Thu, 04 Dec 2025 12:04:51 +0300
Date: Thu, 4 Dec 2025 12:04:50 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: Skybuck Flying <skybuck2000@hotmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Copieing git repository to another disk is dangerous !
 Especially in combination with remotes set to local repositories !
Message-ID: <fgjktagigkapjtmx5mxxzkoll5krt6fvdhcsjhed6esalhabp3@famahk7xyaah>
Mail-Followup-To: Skybuck Flying <skybuck2000@hotmail.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <AM0PR02MB44508B247E4B6EF4F387DA5FB3A6A@AM0PR02MB4450.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR02MB44508B247E4B6EF4F387DA5FB3A6A@AM0PR02MB4450.eurprd02.prod.outlook.com>
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD96221A758E7433892E0305A1233CA676DE4E8359717C9D169182A05F5380850403938CE3B61DC0AD53DE06ABAFEAF67051D8C18A8A8B8747F8F5BA826965735A71A8E179240D18B7E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7492D3E4238663367EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566062315F283B81050FC7D6CE4F6C80AB7D1C1F1A6FA54971EB066D3F7DFD470B6389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C06030C3405640F6718941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B601F8F2FECC0250C8CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C22498E292999FEC08A7776E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B06DAC1A5163BBB173AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FCF1175FABE1C0F9B6E2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B8E48D8FAA4D20A9F75ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5E80C8B5011ECD2215002B1117B3ED6965F84928C1AD9A6B43E67C18142C611B7823CB91A9FED034534781492E4B8EEAD09F854029C6BD0DABDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D65940F455F74901C514F374A66FD4B96488EE0CA3C8B053221F2C816802315490EE8A38E588AD02C532B8341EE9D5BE9A0A38425DFEB7ED914D182CE055FDB6B2859E513566405927BD8CD93680B12512CF4C41F94D744909CE128CFD8518AB8EE9626099AE2EEFD4D9643447F05B2C2B22
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVcWupAQoUeGvF9Q6Vtac3Co=
X-Mailru-Sender: 139A7956A63CACCF7216901AE3D43F147B1D4885ED8864F9B951B70A5BD4BD8E099A1784215FE9F70840CAA66A03E50EFD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64A0D4ABDE8C577C2ED
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: EEAE043A70213CC8
X-77F55803: 6242723A09DB00B467DC7D0AEE971AE2DBE5757CB8EEB8413A57E8ECF03599C7049FFFDB7839CE9E5FF199EA0DE1E76784EB2E5591F40FFA7ED56112F99D31DDD5E6121A98F8B8254C9A4158F421D5AC
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZzJWEBEgh5JkCbgcWQLeozw==
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok

On Thu, Dec 04, 2025 at 03:59:19AM +0000, Skybuck Flying wrote:

[...]
> X:
> cd X:\Vite\Repository\Mirror
> git clone --mirror https://github.com/vitelabs/go-vite .
> 
> cd X:\Vite\Branch\Develop\Delphi
> git clone -o Repository "X:\Vite\Repository\Mirror" .
> 
> Now copy the contents of this disk to a new disk... (virtual disks)

> git remote -v will show:
> 
> X:\Vite\Repository\Mirror
> 
> In other words the remote is still pointing to the mirror on disk X !!!!

I do not understand the problem: the command

  git clone -o Repository "X:\Vite\Repository\Mirror"
  
has cloned the repository "X:\Vite\Repository\Mirror", and so it is completely
expected that re so-called "remote" to which you gave the name "Repository"
records the URL of the remote repository it points at exactly as it has been
provided by the user - with the drive letter in this case.

If you do not want this behavior, you might consider using UNC paths or
a reasonably recent (2010s, I think) addition to NTFS called "junction points"
which allows you to mount an external drive "on" an empty filesysem folder -
almost UNIX-way, so to speak ;-) See the "mountvol" console command and [1].

 1. https://serverfault.com/a/8871

