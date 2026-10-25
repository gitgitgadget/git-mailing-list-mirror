Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792912012;
	b=0WdSX1chVTZtyv+aFh0HM4rQbuH3iWpREga8IqhjvWQRwieQSNQKBRl0CE0dV5wzgF8W
	 6LfZl1I38S6EcXd7Iz9sez2XaFducA+nfPjvCYIWoTgJn2nC8+xLR/JrXqHy08hX1E72Q
	 1Kf4q4FsMXDB6HAYm66fRKtS6Yi/3Nhhun6HuSB3Hd0fXX9xoUQ0c5r9Hhis48v2PepfE
	 5Jo16MpAi3hiFq8pgPHdiZA8plPNq3E+MR7AuFQBFnoBBEWgsaX0K+SJHTMOBFwo+FpQA
	 aYK5EnUgEj2gImqti52KHR+CKv+JcWThJMhsOADcy1dzRL7DK68GI5431Xj58FjDXCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792912012;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=s0jEno+FSLlWHdxINFIjhiVUPqEe2NbRnWKLg26bi34=;
	b=aLCFP0F1nPApN+f6OqupSGy3NxwmWhaCrENDVlzadzj3ZqErub3NRh5D98qn7eWxUHul
	 bFML2hP7/SrfsTOvksdvkDdErd0/+SNy0qX7WhulT3F6Q39kkLDSf3c5qcLVNWBNGd8Dx
	 d5iBZ/k77whBpO1cIPC/VPnlNS3f+xOIuMMnykpyb2RWmQvyvO2WEtaKCtd8fsqYTdq9F
	 2PcttvTojf9y9We8C4vI4f/o3FsIXxuPWz6aeFn7/xxUCP8kt17mqrPrqrhP37iCtdAhL
	 9PKjNMCyWnhpICP+3AKJymtFBJdIrmyDyZBgZgchV50kCp509Ckup+YRqMdHLuRuN8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=RIYkIGy+;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628E1606A31B
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 07:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 628E1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=RIYkIGy+
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 69P76gd7008645-69P76gd9008645
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 25 Oct 2026 09:06:42 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xKsJW-006AOo-Hb;
	Sun, 25 Oct 2026 09:06:42 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 25 Oct
 2026 09:06:42 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 56e1acf7;
	Sun, 25 Oct 2026 07:06:41 +0000 (UTC)
Date: Sun, 25 Oct 2026 09:06:41 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: <tboegi@web.de>
CC: <git@vger.kernel.org>, <ps@pks.im>, SZEDER =?utf-8?Q?G=C3=A1bor?=
	<szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/1] t1450: use mv -f when overwriting a read only
 file
Message-ID: <20261025070641.GW33j%taahol@utu.fi>
In-Reply-To: <20261025043322.1766-1-tboegi@web.de>
References: <atmvASAoaCIpc_ca@pks.im> <20261025043322.1766-1-tboegi@web.de>
User-Agent: s-nail v14.9.22
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ex19-05.utu.fi (130.232.247.45) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaWEgbEg0MDRpGDA0eKA8FCQEE
 RgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIXEhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIUUgYGygYAxtGAQVIWEhaWEgbEg0MDRpGDA0eKA8F
 CQEERgsHBUhYSFlbSBwKBw0PASgfDQpGDA1IWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=s0jEno+FSLlWHdxINFIjhiVUPqEe2NbRnWKLg26bi34=;
 b=RIYkIGy+midj9H6Al0f51OwjJSI5uMIR8mQMM12lIeFZrCiE0SWuNrFE/K59Hz0t84C1XhB40R1Q
	EPPG4WHeAdHHn4Q/lULKUasm/RkYWiUk5pAdXbGY6x96Yv2CCDftttq4oYWcnkT4Nqr/r4r0XTdq
	2q/WxAayZ0oVHKlQLf17slbgKjj7VNClTCjVhpBTWjoM8WQ8slIxBXSs+uC7sHRQsWgYP+8raD2B
	A6G8YZbBPATrFdoafVpEfh+Qf+RNlPjD68JdwJEPhSOHoC7hIDjlwASYSsJRG0V0LHI5DcR9zRyD
	QEB2c/75Xv6vqCHSR0/gJ16MWXDE2DpOt3wcVA==

tboegi@web.de wrote:

> From: Torsten Bögershausen <tboegi@web.de>
> 
> test case 38 in t/t1450-fsck.sh replaces a loose blob, "$tmp" below,
> with a trucated version "obj.tmp" using
> 

s/trucated/truncated/

> mv obj.tmp "$obj"
> 
> This fails on some sytems, like older MacOS.

s/sytems/systems

FWIW, it seems that the glitch was fixed in macOS 12.3 (file_cmds-353.100.22).

> `man mv`
> includes this information:
>   The following options are available:
>   -f      Do not prompt for confirmation before overwriting the destination
>            path.  (The -f option overrides any previous -i or -n options.)
> and further down:
>   If the destination path does not have a mode which permits writing, mv
>   prompts the user for confirmation as specified for the -i option.
> 
> Running the test case in debug and verbose mode `./t1450-fsck.sh -d -v`
> shows this lines (which I have shortened to fit into 72 characters)
> 
> override r--r--r--  user/staff for .git/objects/fc/a75a5be3823dc0560da5?
> (y/n [n]) not overwritten
> fca75a5be3823dc0560da57ade678f212aeb33f6
> 
> POSIX mentions that the observed
> "prompt to standard error and read a line from standard input"
> should not be done if "standard input is a terminal".

This replaced "when" with "if" but the meaning didn't change.  The observed
behavior shouldn't happen if the stdin is _not_ a terminal.

> So we may blame the "standard input is a terminal" logic to fail.

Well, macOS versions older than 12.3 just don't have that logic in mv(1).
Can nonexisting logic fail?  (If somebody is interested, the actual change
in 12.3 was

@@ -265,12 +290,12 @@ do_move(const char *from, const char *to)
 		} else if (iflg) {
 			(void)fprintf(stderr, "overwrite %s? %s", to, YESNO);
 			ask = 1;
-		} else if (access(to, W_OK) && !stat(to, &sb)) {
+		} else if (access(to, W_OK) && !stat(to, &sb) && isatty(STDIN_FILENO)) {
 			strmode(sb.st_mode, modep);
 			(void)fprintf(stderr, "override %s%s%s/%s for %s? %s",
 			    modep + 1, modep[9] == ' ' ? "" : " ",

rather simple indeed.)

> 
> Side note: Answering with 'y' to the question of `mv` like this
> (echo y | mv obj.tmp "$obj")
> makes the test case pass.
> 
> To make things not too complicated use the most portable form
> mv -f obj.tmp "$obj"
> 
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
> 
> Thanks to all reviewers.
> Changes since V1:
>   "should not be done when" -> "should not be done if"
>   Fix "mv -v": it must be "mv -f"
> 
> t/t1450-fsck.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 16cc5d5dcb..335dcbf0af 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -548,7 +548,7 @@ test_expect_success 'rev-list --verify-objects with truncated loose blob' '
>  		# Truncate the loose blob such that its header can still be
>  		# parsed, but reading the object data fails mid-stream.
>  		test_copy_bytes 64 <"$obj" >obj.tmp &&
> -		mv obj.tmp "$obj" &&
> +		mv -f obj.tmp "$obj" &&
>  
>  		test_must_fail git rev-list --verify-objects "$blob" 2>err &&
>  		test_grep "hash mismatch" err
> -- 
> 2.50.0.rc0.46.g7014b55638
> 

Thanks.
