Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD6F129A97
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199699; cv=none; b=fMGwfgm/5Ug8jks9kF71Nsauhvk1q+W4tfHd/cBvgO0vbhS0+UjH6dPCWtvsaOpohFOoAYnsO/5ywpsUxpstwXK1j6VEo4hkCpqkyq0hJMN/yJEt/cBOkcUF7insIOWXV0oYeNmqfIC2VA35jeM8A+lBIKB7abq8y2uGRFYe3PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199699; c=relaxed/simple;
	bh=7w8+Kri7u0+/xilVqkuEJYQesxtuDU95+P0nZNu3cjg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPeZftsIC+x0SWyv6sKczSYGZGqYvy9r/3Ye4VG1ZxXw/rDSrfjtgPWhS7DJE/0r79lBFg92Bf44FT2bFoVVmuV8Q+1y5RfVfHATR8+rTeKEr9eSTPTJlNJUUQKCVn1haiWOKXzY5PED3MtSR7NZbSC4PnVjlnPOcXjBRXR2GxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=XM7y14Nz; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=xTd6tXU8; arc=none smtp.client-ip=79.137.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="XM7y14Nz";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="xTd6tXU8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=9UXzBKfYa0r4/16X5V996i5xIud3Iw7UN394tgrxjoY=;
	t=1706199694;x=1706289694; 
	b=XM7y14NzmN4Hm95K3sG6q65QmESKSdyYk/Otj1e7JIVijnFqCpeQvwp9gXxhx0YkpDbQAESxNJ8/YjReAGde+B9yrq1+e8QsjJeqoa8gty7Iy8FMxNe/3nnPkHxCc/owASgNhN53e5aRnQVUCoSwJ4eZWvnj1Z2tfUoUwwqKVSc=;
Received: from [10.12.4.37] (port=43794 helo=smtp61.i.mail.ru)
	by fallback1.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1rT2Tl-00AJGh-Vm
	for git@vger.kernel.org; Thu, 25 Jan 2024 19:21:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=9UXzBKfYa0r4/16X5V996i5xIud3Iw7UN394tgrxjoY=; t=1706199685; x=1706289685; 
	b=xTd6tXU8R3e4SECXsXgxxSJcGpgZ2vCgWuJUXovJbpFTz7AIcL7or0wwO0dw75dWc/DfgqakPVe
	9fik73WExf9SBi6hq6MpLk30bAs2tFk/bGLnooNjTFZlVYe27kmah6nyb875JQPB0bAZctpWi1tPP
	rk80UKr7bN0IrL19imA=;
Received: by smtp61.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1rT2Td-00A0Wp-2O
	for git@vger.kernel.org; Thu, 25 Jan 2024 19:21:18 +0300
Date: Thu, 25 Jan 2024 19:21:17 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: git@vger.kernel.org
Subject: Re: Virus detected
Message-ID: <20240125162117.ajysmqwrqc4emybn@carbon>
Mail-Followup-To: git@vger.kernel.org
References: <a96e6744-c0bb-4f6e-9066-646ca15a353d@GMX.De>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a96e6744-c0bb-4f6e-9066-646ca15a353d@GMX.De>
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9260BB214B72A2377C675F4246A67C6F5AA380AA4D6243ED0182A05F5380850404C228DA9ACA6FE271DAF10D12A4E9C658E14D4BD82808AFD207A37792EB9F1551EE8441B401B548A
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A3295C83650092F9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006379BF04B24BEB7B2D58638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8BAE523405E7C6EEFAB82799917ED40FA117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC00AB816903775DDCA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352026055571C92BF10FE5D25F19253116ADD2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB1593CA6EC85F86DC3123C4324A5CF10D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3FE4D9CDE3FF759CF6E0066C2D8992A16C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C062BEEFFB5F8EA3E2E808ACE2090B5E1725E5C173C3A84C317B107DEF921CE79089D37D7C0E48F6C8AA50765F79006373BC478629CBEC79DEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A556E3117CD1F6F2C1B7E8E45A74912DAEEC975A2F77FDD626F87CCE6106E1FC07E67D4AC08A07B9B0D23BF7408B3F9022CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34524B2D44961BF9C668C49BCEF089420CE626F5D10E1151C0EF5C13F3B71E3FDFF9B11BF9BD8B39EF1D7E09C32AA3244CF4C2604BD23D22BD190F2C41E201902064EE5813BBCA3A9DBC4AF6B5DE6957CB5DA084F8E80FEBD3B644FBF139BB3089A015563ECF9503F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojjPo90oGNxwJ/sv+BrqRo3g==
X-Mailru-Sender: 139A7956A63CACCF7216901AE3D43F14092F8F3C01EFE7995E16E72460DA147924C8257F11D4E8342F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B48822B69B0C414C66EDC162D7C4575373C2E3B28971F8A0E068F3CF0E9FE49B699C9ECA75E078EC22747CA43DF492EEF9B2615B9283501C1EA5BBC969385B4329
X-7FA49CB5: 0D63561A33F958A59EDF17321DDE478B65BD132CE62BB01590DD7BE50DD0A6B78941B15DA834481FA18204E546F3947C1DAA61796BF5227BF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063770DAEE4257ABEBB3389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3FB9365559B687AC835872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojjPo90oGNxwICGTMxNfyccQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Hi!

On Thu, Jan 25, 2024 at 04:23:25PM +0100, Hr. Rüge wrote:

> trying to use windows version 2.43.0 from https://git-scm.com/downloads
> my antivirus software detects it as a virus.
I assume you're talking about Windows.

This problem is not new and has been reported and discussed numerous times
on the 'net. It has even been reported to the Git-for-Windows bug tracker -
see [1, 2, 3, 4].

The problem with A\V software is that it does not operate solely by scanning
the executable image files for having byte sequences identifying particular
infections - this approach worked in 90s but not for too long. These days,
pieces of A/V software try to _guess_ whether a particular executable is a
malware, and to do that, they "score" what they inspect; for instance, lack of
signing of some binaries lowers the score, not being presented in some
"whitelist" lowers the score and so on.

What you can do is to navigate directly to the GfW's project downloads [5]
(you might have noticed that the link to download the Windows binaries over
there at git-scm.com actually already leads there, just to some more
user-friendly web page), pick the version and make (32-bit vs 64-bit) you
need, download it and then verify its checksum [6] matches that one listed at
the download page. If the checksum is OK, you can be sure no software running
on your machine has tampered with the downloaded installer, and then the
question of whether or not the installer contains any malware is the trust in
the Git-for-Windows maintainers and the integrity of the GfW's Github project.

> In parallel something wanted to change my hosts-entries.
> 
> Ist that normal?

I would say it's not normal but as usually, coinsidence of this activity with
an attempt to install GfW might not indicate any connection between the two -
other than temporal. Of course, this only stands if you have no malware
running on your host which patches the downloaded files on-the-fly.

Still, if you're not sure about this one, please ask on the dedicated GfW
mailing list [7].

 1. https://github.com/git-for-windows/git/issues?q=is%3Aissue+in%3Atitle+virus
 2. https://github.com/git-for-windows/git/issues?q=is%3Aissue+in%3Atitle+malware
 3. https://groups.google.com/g/git-for-windows/search?q=malware
 4. https://groups.google.com/g/git-for-windows/search?q=virus
 5. https://github.com/git-for-windows/git/releases/
 6. https://www.google.com/search?q=windows+calculate+hash+of+file
 7. https://groups.google.com/g/git-for-windows/

