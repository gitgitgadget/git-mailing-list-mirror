Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D939CD01
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786302804; cv=none; b=YxuaUG5hxih3iAdzdwZR/VsPGcGkgWMOsc8L7VKTYxlpgsC7zxfWfiEGOAM/xs935QVGUU+9VcByykMCZr/pLCYKXRH1Wpg1Uy5lhZsgYuJ/76X0SMefqWJOyARde0aO/wKnRFOpYTaZIj3nCHglqy6OGvGR1OVMtzYgeas3Q6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786302804; c=relaxed/simple;
	bh=pz9LZA7SG5nxw/MtOB0OWnj9tdMfLdCZsX7Fxsz7UyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qu5cahlsrzbNWF6LPx7jPKJDP8T5Rh7vA8Xqjwhp0+NrOEoeN2yz0E5hBCK2weEJpFpRsEWlpbcvzLtqNIWqMDzdg10I6uMyGVjN1wkZz9ePKW6N2lQdDRZVpgb7+d9/GRicFE0FPKNCaPpEcSzU2Eq9biD+R9MX+Tm5yJw3G0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FrbxisIn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IwolVw+P; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FrbxisIn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IwolVw+P"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D99A8EC008A;
	Sun,  9 Aug 2026 15:13:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 09 Aug 2026 15:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786302797; x=1786389197; bh=lfhEjANBx6
	jgMa5EofaaokKWnGj8vSF7NfT0vfT6MUc=; b=FrbxisIn01qZ/fKmdibabCb2Hn
	uI4oMAKgX3K65EsgtuvtHonBxD+eetwtE+MupJR6SoaF6JM3qy0UMrSezjt5OWAY
	lBZbe/MIurRJehVpjFti1yFz9lvRhVTnIAARFGkOb3uSE9orAlgfUZlHTEfUpNVw
	2YEJsQOgblBEiBMRC00gIqjrbluD/qXa6LgYfBdfmzBba/9DWPS2bvStDDCEbCqk
	x3jsbBaUWgiCBbM2xXNzy05/rtiMxopamNERA1UF61ItQ/D5yJknLe6tENwz3cQd
	tnDzgSxBtO/8dFaQveoq/RvmIzx0dIsF5bJxIqcQRTbK3kI6EN8cPUW83MDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786302797; x=1786389197; bh=lfhEjANBx6jgMa5EofaaokKWnGj8vSF7NfT
	0vfT6MUc=; b=IwolVw+P2FIrtdj9VCNWCRHPB0DH1MzHGTgZYsGxseBOuWPoZnw
	PXUuMDT7RpebJaOVAXAPhtlViML9n76hYZ5+VK75EoSQkWSRmnVfgywWlxCmLfaI
	7EfckMFUJ2vPYUajcfePJKN8vRDCutbhs2wfxggNvq3aVa3Jg6J5fWmZ18fLGT3X
	xnHMv07cQky2nrszQ7Cl6KdiQ/BU13C1PaBL4xRNSsOwx6gP3QnhFIf6eCHGBIf2
	lTOztfE/Ede3EEzu4sRUGDtx7bJDynW3EfbzkFLL1vVKRVvTQMgHn2EcHoLEcgBQ
	oyxQ98sj2n2IARhr02b5HDUUBg6py1awsIw==
X-ME-Sender: <xms:TdF4agqUi7XQDtin5ZbI43TmZc8lfk8FXstYdaXZM2WmVGI9C5Sj7Q>
    <xme:TdF4atrE1Tso6tjdS-X-7aMJOqOpcSsms84Jtv8_lGHGVxJ8I5VBcPl441qvVhHud
    AIDd9pXciPlK08y9FfBac2SVuIsYhuktSvPArr5Deu_cZCyApvNSw>
X-ME-Received: <xmr:TdF4aqO6wnv0yHdUkbExVnVuRbB4BwIO3yrUWKn-ilq-SjkP1_TgpIu3E_I2ojl8mZBo7R2rbet_O3HOhj7I05C0piVCDOsjYA>
X-ME-Proxy-Cause: dmFkZTEcNjwYaWpvFOgqXx8S3sS8yqPd/+WiAJeAVAraJrdo5f0iJvZGQddV1Br6+OR1vV
    Gi8Kzkzu51wUtV5JQKwfOpnZQ0jE5aRlIDQTkB6qDOgAeeKXPDRnvoIB/9ZwIPlQMQBBEo
    XuRzHL59LzVnotyZLlHFqxbuyR5/5UC9vxdmukChyTajJdNIPBuzFJ/sFXC91yUzcUNEMM
    0kL0S3rbuN2d6GQVLKCjG2haS1L1WoAoNfSSs1x9RgWocQIBZVWjFIp9y5DBrz7oTbr24t
    jzhSYik+Wa5aWUmMoc8QjlWJ6a43dnpZDpt1ehMKr/TNRZjJM2JULdQKe+IRflK8QVSvBS
    8ALcaviS4KCz26FKSSrIqPHy/9oF0KaJ9sz8mjeG6SiBPQZkzPX8RSi/pnUc1r41gA4U6H
    UpOJaOgdT3o0Y+f8spBBdqafzmSyV1xCLLSpOr3oH786l3Aak6RlFK5N5pkDXhVjo73zwy
    MKH6IpoHDl+DwToTAVV68gREkqEjZcrRgkJdkkwBn6bLVnsRush8jK5UidcKS765Rg5H1S
    ulBG/hEXJ5G09XznWjqh30PsiTls6tJukIg2MA95JVY8VXgdZsnBQggXCDBB9TxijJ5Aw6
    cu5gj6qSEBqVQagX7st4+Al0yXru6PIOdFSRoYRhwNeVMsY2NRWSBD3DeLtQ
X-ME-Proxy: <xmx:TdF4amz3--YdrJH2hsdpEpDfaSgSHkiqxSGEnzTTKYWlpiJcGFxI6w>
    <xmx:TdF4aruWZCb1GUxEHAHufobTmx-uWG-qW9iPeEXON_XoDbbmcepuKg>
    <xmx:TdF4an59OiVtxWWDMUbcD8AsTMIHiW8bUgY-PBHhvXYd0tfZCSgPLw>
    <xmx:TdF4aiS2ueIboop-IPMLeIp9lhK6B8B4k3qsNJEM6QH_NjZmmzzOoQ>
    <xmx:TdF4aptqmViq98s9yI2sK3-PBFvcMyNAod_fEVsslp3PEj-Jbob5EPcA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 15:13:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] send-email: clarify missing subject error
In-Reply-To: <pull.2375.git.git.1786267394375.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sun, 09 Aug 2026 09:23:14
	+0000")
References: <pull.2375.git.git.1786267394375.gitgitgadget@gmail.com>
Date: Sun, 09 Aug 2026 12:13:16 -0700
Message-ID: <xmqqo6fb85v7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Explain the required Subject: prefix when a message file has no subject.

Yes, get_patch_subject() is called from places where the caller
wants to determine whether the given file has at least one line that
begins with 'Subject:'.  In that case, the subroutine returns the
rest of that line; if it does not find any such line, it issues an
error message and dies.

As a side note, the check is curiously case-sensitive.  It is also
curious that the scanning does not stop at the first blank line that
terminates the email headers.  However, do not change this behavior
without studying the possible ramifications.  People have learned to
use various inputs that are not exactly what is output by 'git
format-patch', so rejecting a 'malformed' file simply because it
differs from typical 'git format-patch' output will break someone's
established workflow.

> Terminate the error with a newline so Perl does not append its internal
> source location.

Very nice spotting.  For an end-user facing script, the source
location is not useful.  The user is not debugging and fixing the
send-email script after all ;-).

> diff --git a/git-send-email.perl b/git-send-email.perl
> index bb8ddd1eef..4d76d53c49 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -863,7 +863,8 @@ sub get_patch_subject {
>  		return "GIT: $1\n";
>  	}
>  	close $fh;
> -	die sprintf(__("No subject line in %s?"), $fn);
> +	die sprintf(__("No subject line in %s. " .
> +		"The first line must start with \"Subject: \"\n"), $fn);
>  }

An input file to the 'git send-email' program is often the output
of 'git format-patch'.  Such a file begins with a UNIX 'From '
line, followed by email headers such as 'From:', 'Date:', and
'Subject:'.  The 'Subject:' line cannot be the first line of
the file in this case, yet it is a valid input.

The only condition that this subroutine flags as an error is when
the file lacks a subject line.  "No 'Subject:' line in '%s'\n" is a
clear message to display and is an improvement over the original.

However, the fact that the first line does not start with
"Subject:" is irrelevant to the basis of the subroutine's
decision to issue an error, I think.

Thanks.
