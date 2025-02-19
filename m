Received: from fallback23.i.mail.ru (fallback23.i.mail.ru [79.137.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E3F1F61C
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987680; cv=none; b=SZfbQdYJS89uYRlaiHeTK+2sASJMaEvrAJtitkFXqvvcpze8LMyY0AWtbvCp/2cu6Ucin4di/5l8b0noiQj0vCeWNwB5toJMtmtbXF7+j+BEgxPS6T29s02bWyQxABxn3qrkOWx6gmtZIN1PXyGSAXbJuam1T4Znadm1za4gLV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987680; c=relaxed/simple;
	bh=OtDG8ijHXgUmm1i/WSBwRgesZv8OA7O1SCKPUiMHy80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mps319CLdMbz/9y87geX5ivIlsi2I+hxFwPLp6Br+wuauFTGjK8SVsIvyAvxsVqKOsUjUadyCfwBQ20TRU7xUXLaXlj+qVWAuwM3YoIMpb9iqBtVHk4c1Gr7nFgArmMq/CyXdN8X40IAVJNoNfNJx9tcXuWefnRT7MfytpiG+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=fNnrfJZO; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=GYOVpSeU; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=skJu35GJ; arc=none smtp.client-ip=79.137.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="fNnrfJZO";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="GYOVpSeU";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="skJu35GJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=wiWwjcF9X+hf+6n6OfC4LB2qsJKQ4w9yLCUTWv30Hcs=;
	t=1739987674;x=1740077674; 
	b=fNnrfJZON+pALifZu0loq8MlVWMOnGz+A8HQk7bWkJlT8sLk18hKj4ibJoXjGlKF+Is4MxlriB10VvFkVl7Jvdr0gRZgWUom1g5QjBvGF8fJBNkHaqJUn83ffoG8eroHxyl6W5RbLUVBlwKG06eeZSOQ9smWFHpWEJODYX3fBl8=;
Received: from [10.113.58.193] (port=33184 helo=send193.i.mail.ru)
	by fallback23.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1tknuL-000m4t-PD
	for git@vger.kernel.org; Wed, 19 Feb 2025 20:30:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=wiWwjcF9X+hf+6n6OfC4LB2qsJKQ4w9yLCUTWv30Hcs=; t=1739986249; x=1740076249; 
	b=GYOVpSeUQ1O1sf5kfP1MvLBe0Jfc6e+BqmjSbUd+pejjAoC0rem48FZEKvfiP1sMb6i0NBEYLUP
	oq1pt5o6SfVwolytBHd2R4IxgKhf6hW0B5dV998aXMmxdu7avesnSvp3W+5/amDpM/iH5qwjOZL+H
	FESJPmdR1xqv5mQNBPs=;
Received: from [10.113.82.43] (port=39014 helo=send196.i.mail.ru)
	by exim-fallback-6b9c88987b-9m7q4 with esmtp (envelope-from <kostix@bswap.ru>)
	id 1tknuD-00000000273-2re8
	for git@vger.kernel.org; Wed, 19 Feb 2025 20:30:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=wiWwjcF9X+hf+6n6OfC4LB2qsJKQ4w9yLCUTWv30Hcs=; t=1739986241; x=1740076241; 
	b=skJu35GJwZThs3pq5sVxeNvPUP9cKns0XWOABvjibWSTRqnHb44LPMgyr1HaMJKqChMJZBfPkHL
	DRPG79jP2CIPT2gLe2UNROidRGkvNzvstAuEHPxoLONo6F75lc3oiWcLA8wE9SVJ1Eyh/eVkRKf1o
	HZsnqtDt7jN1uPFlxo4=;
Received: by exim-smtp-5f589487f8-dhv7g with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1tknu5-000000003rR-1erF; Wed, 19 Feb 2025 20:30:33 +0300
Date: Wed, 19 Feb 2025 20:30:32 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: git@vger.kernel.org
Cc: Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>
Subject: Re: [PATCH 1/2] Fixing file name encoding issues.
Message-ID: <20250219173032.x5gzw6hsvsu4flba@carbon>
Mail-Followup-To: git@vger.kernel.org,
	Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>
References: <pull.1886.git.git.1739918546.gitgitgadget@gmail.com>
 <d33fb3d940cf97bdfe3dc544763a51df4874a5c0.1739918546.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d33fb3d940cf97bdfe3dc544763a51df4874a5c0.1739918546.git.gitgitgadget@gmail.com>
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD916C41472748AFA04A64163DEC989407BAC72CC1C2A047AB700894C459B0CD1B9BEE16AC6B634C651A6D5EE0DB6E1EC8DD6FBC80DE0722A459E70642517F923694F193C0F926A29E4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE751BC6685BC61E6BCEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006376602C647E39EFA3A8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D87EED60523C26CA6A8299DA9D7B8B5BE6E83BD3832F24D494CC7F00164DA146DAFE8445B8C89999728AA50765F7900637D0FEED2715E18529389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC897AD43380FEE24CAF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C67F1C1C3ABB44F3A040F9FF01DFDA4A84AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C33AFBBA56C05A32E5BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE73349F3DFB73D9B11731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A583A6044A875631655002B1117B3ED696EE45158E0F5B7C89ED71F038FC046993823CB91A9FED034534781492E4B8EEADA3A806F356AF31D6
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D344F2126FF337FA651199AA8AE0D508537CE3293A90BB4014B486F0C87D0CEA2C929890A97F9D78C6B1D7E09C32AA3244CAFF02DFF6E90630177DD89D51EBB7742058ABBF4256A1513EA455F16B58544A2E30DDF7C44BCB90D3871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVWiyXSWEEqdrywFsY/J4WFc=
X-Mailru-Sender: 139A7956A63CACCF7216901AE3D43F14B4F545CD0443B0D9B951B70A5BD4BD8EAFBCD91833C7F678963B07FDC01C0C9DFD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64A0D4ABDE8C577C2ED
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B460759F99F06F60E30139815E92C93661158CCD7C2B48AB79049FFFDB7839CE9E3D3BB30DB6F99D604F72803E87D339768A3D8E0CF60C21F5005CAE455FB3ED19C84AFF1A19B9DEC4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZNrciak6xUdXxIjPUD/VPvA==
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B460759F99F06F60E30139815E92C93661DF376B7E6D8A0F92049FFFDB7839CE9E3D3BB30DB6F99D604C79A9AD31459DAA3759C2632F45F668A3375EA99AD237C2
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZNrciak6xUdUSyYVSgZWe8Q==
X-Mailru-MI: 20000000000000800
X-Mras: Ok

On Tue, Feb 18, 2025 at 10:42:25PM +0000, Kazuhiro Kato via GitGitGadget wrote:

[...]
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 47a7c1d29c4..88951ed2384 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -12379,6 +12379,7 @@ catch {
>  if {$gitencoding == ""} {
>      set gitencoding "utf-8"
>  }
> +encoding system utf-8
>  set tclencoding [tcl_encoding $gitencoding]
>  if {$tclencoding == {}} {
>      puts stderr "Warning: encoding $gitencoding is not supported by Tcl/Tk"

I'm not sure one should sensibly do this - except to implement some
well-understood and well-documented kludge, simply because the "system
encoding" is supposed to be set by the Tcl runtime.

Let's demonstrate (on a Linux-based system with UTF-8 locale):

  tmp$ touch 'привет мир.txt'
  tmp$ tclsh
  % encoding system
  utf-8
  % glob привет*.txt
  {привет мир.txt}
  % encoding system cp1251
  % encoding system
  cp1251
  % glob привет*.txt
  no files matched glob pattern "привет*.txt"
  %

Here, CP1251 is a Windows "code page" for Cyrillic; it's what
[encoding system] reports on Windows systems.

Note that I create a file whose name is two words in Cyrillic script encoded
in UTF-8, and Tcl is fine finding and dispaying this file (via its "glob"
command). But as soon as I change the Tcl's system encoding to another
8-bit Cyrillic encoding, globbing stops working.

Moreover, if I'd do [glob *.txt] so that my file would be matched anyway,
its named would not be readable since Tcl would re-encode it from CP1251
to Unicode, but the name is encoded in UTF-8, not CP1251.

In other words, your patch (supposedly) works on UTF-8-based systems
which is common to Linux-based OSes and MacOS, but I'm afraid it won't work on
Windows.

