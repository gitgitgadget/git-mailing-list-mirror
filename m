Received: from smtp.rcn.com (mail.rcn.syn-alias.com [129.213.13.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF8A2A
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.213.13.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722806790; cv=none; b=NfEb65tLRXkBGNEXaRCvjeonRkC0LG834xpK0HmSlefqLbd6PXGJKKP1wivBiIvMwXsDyAnqw3N79jnVjTOFqpZknsnic8Vf8D3RsipJW9dcmtQQWXas1SfzdVKgVHM6kQajl+PFFqDaXXZ+LDnv3Ng55fK0+KKkWDMG+WqrMoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722806790; c=relaxed/simple;
	bh=61xEPrLXapjuVxNNgoW2TipxNEhPuuA4dVyI8zjMTR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n9Fcd0kUeaVfmf+yrzJL+Ns3G98/TJRo3tuBh/kNCHloVl6m6D/aYiE0GdRvlmMnTDkr45C7Tkk7YyRAMst0XXkCuNDzsxS+fKoNucs/iTBIdYN96EDcTt3mop0HDCyDI26zjhKtx+6eNETMeaQ5SqPm+RdYKxZ3yVLSRO7pvsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scarborough.kim; spf=pass smtp.mailfrom=scarborough.kim; arc=none smtp.client-ip=129.213.13.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scarborough.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scarborough.kim
X-Authed-Username: Y2hvd2Jva0ByY24uY29t
Authentication-Results:  smtp02.rcn.email-ash1.sync.lan smtp.user=<hidden>; auth=pass (PLAIN)
Received: from [24.148.58.81] ([24.148.58.81:36374] helo=[172.22.22.107])
	by smtp.rcn.com (envelope-from <kim@scarborough.kim>)
	(ecelerity 4.4.1.20033 r(msys-ecelerity:tags/4.4.1.0^0)) with ESMTPSA (cipher=AES128-GCM-SHA256) 
	id 70/09-00700-CF1FFA66; Sun, 04 Aug 2024 17:26:20 -0400
Message-ID: <1d6e0fef-9b9a-4239-aced-d20cd5c3434c@scarborough.kim>
Date: Sun, 4 Aug 2024 16:26:19 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git and gettext
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <bf5a7771-f616-47d9-a014-f9d3e0afaa08@scarborough.kim>
 <Zq5UFYnWL1jdgDaH@tapette.crustytoothpaste.net>
 <7d507ea2-08e1-4597-bff8-8a2b40a01747@scarborough.kim>
 <Zq5qNwmTpL1H5LH0@tapette.crustytoothpaste.net>
Content-Language: en-US
From: Kim Scarborough <kim@scarborough.kim>
In-Reply-To: <Zq5qNwmTpL1H5LH0@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Vade-Verdict: clean
X-Vade-Analysis-1: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdduiedvucetufdoteggodetrfdotffvucfrrhho
X-Vade-Analysis-2: fhhilhgvmecuufgjpfetvefqtfdptfevpfdpgffpggdqtfevpfdpqfgfvfenuceurghilhhouhhtmecu
X-Vade-Analysis-3: fedtudenucenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefmihhm
X-Vade-Analysis-4: ucfutggrrhgsohhrohhughhhuceokhhimhesshgtrghrsghorhhouhhghhdrkhhimheqnecuggftrfgr
X-Vade-Analysis-5: thhtvghrnhepiedukefftdeuvdegjeduteehhfetffdvleehudehgeejteegudefhfejveevledtnecu
X-Vade-Analysis-6: kfhppedvgedrudegkedrheekrdekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhn
X-Vade-Analysis-7: vghtpedvgedrudegkedrheekrdekuddphhgvlhhopegludejvddrvddvrddvvddruddtjegnpdhmrghi
X-Vade-Analysis-8: lhhfrhhomhepkhhimhesshgtrghrsghorhhouhhghhdrkhhimhdprhgtphhtthhopehsrghnuggrlhhs
X-Vade-Analysis-9: segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
X-Vade-Analysis-10: rhhnvghlrdhorhhgpdhmthgrhhhoshhtpehsmhhtphdtvddrrhgtnhdrvghmrghilhdqrghshhdurdhs
X-Vade-Analysis-11: hihntgdrlhgrnhdpnhgspghrtghpthhtohepvddpihhspghnrgepthhruhgvpdgruhhthhgpuhhsvghr
X-Vade-Analysis-12: pegthhhofigsohhk
X-Vade-Client: RCN

On 8/3/24 12:34 PM, brian m. carlson wrote:
> 
> Hmm, I can't remove msgfmt from my system, but if I put a `msgfmt`
> script in `$TMP/path` that contains just a shebang and `exit 1` and do
> this, the build succeeds:
> 
> ---
> PATH="$TMP/path:$PATH" make -j12 NO_GETTEXT=1 NO_MSGFMT=1
> ---
> 
> Note that `config.mak` is not read by git-gui, so you do really have
> to set `NO_MSGFMT=1` on the command line.
> 
> Can you show exactly the commands you're running and exactly the output
> you're getting?  Also, what OS and version are you running this on?

Not working for me. I ran "make NO_GETTEXT=1 NO_MSGFMT=1" and it dies 
thusly:

     BUILTIN git-version
     BUILTIN git-whatchanged
     SUBDIR git-gui
GITGUI_VERSION = 0.21.0.128.g2864e
     * new locations or Tcl/Tk interpreter
     MSGFMT    po/bg.msg     MSGFMT    po/de.msg     MSGFMT    po/el.msg 
     MSGFMT    po/fr.msg make[1]: *** [Makefile:239: po/bg.msg] Error 127
make[1]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:239: po/de.msg] Error 127
make[1]: *** [Makefile:239: po/el.msg] Error 127
     MSGFMT    po/hu.msg make[1]: *** [Makefile:239: po/fr.msg] Error 127
     MSGFMT    po/it.msg make[1]: *** [Makefile:239: po/hu.msg] Error 127
     MSGFMT    po/ja.msg make[1]: *** [Makefile:239: po/it.msg] Error 127
     MSGFMT    po/nb.msg make[1]: *** [Makefile:239: po/ja.msg] Error 127
make[1]: *** [Makefile:239: po/nb.msg] Error 127
make: *** [Makefile:2365: all] Error 2

This is a recently-built Linux from Scratch box.
