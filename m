From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH] docs: clarify git diff modes of operation
Date: Thu, 4 Nov 2010 21:57:16 -0400
Message-ID: <AANLkTimqA=2+fG10mP=zmXHksHvr6iVZQHRE85ab-aMV@mail.gmail.com>
References: <87fwvl2d4d.fsf@gmail.com> <87hbfxgg86.fsf_-_@gmail.com>
 <20101104174917.GA30628@sigill.intra.peff.net> <20101104180242.GA16431@burratino>
 <20101104181357.GA31016@sigill.intra.peff.net> <20101104183851.GA16865@burratino>
 <20101104185545.GB31016@sigill.intra.peff.net> <87d3qkhm3d.fsf@gmail.com>
 <20101104204304.GA4641@sigill.intra.peff.net> <20101104211729.GA5551@sigill.intra.peff.net>
 <20101104215056.GA18475@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 05 02:57:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEBYl-0002dQ-KO
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 02:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474Ab0KEB5i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 21:57:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56813 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873Ab0KEB5h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 21:57:37 -0400
Received: by iwn41 with SMTP id 41so247273iwn.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 18:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ZU8z3OEAJPCaImKrfOac2pV8n0kZg4Q23GG/8iUDQzo=;
        b=wFdCmeqUn40DurJ46ipEOXnVK2JRbb6uGDMg3y4K8S6rcDYPoBB9lC4rFPMfJK5Q+f
         /whEAkUrHmh4A2WCiTHPvjrlo0hd9FNuWtmo5F5BN8ZIfy6hCPjcliLGlIowWlL4re1M
         ciMND3NAABiTRc66VsH73+ZOOqCIfrFnSkb+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ei+UBXw1Y+0a+KIwO8SR57O8f1J2Aqxny6dAmy4lDAHsVklhNoFYtI+Gt3A6QGUZfs
         Eq/ncBQjcEt5h9sImIB8bIpl4FP9oBQY7GPf5VQ4KxcHk8h1x9HVja6dPQXtapc/Abxh
         VjgUIpUPVtnowCbzL1hkVcAnwrL3uWS3FqKgo=
Received: by 10.42.22.207 with SMTP id p15mr913579icb.474.1288922256700; Thu,
 04 Nov 2010 18:57:36 -0700 (PDT)
Received: by 10.42.174.9 with HTTP; Thu, 4 Nov 2010 18:57:16 -0700 (PDT)
In-Reply-To: <20101104215056.GA18475@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160796>

On Thu, Nov 4, 2010 at 5:50 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> . =C2=A0So I guess technically the separate operation modes are
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff [--cached]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff [--cached] <tree>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff <tree> <tree>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff --no-index <path> <path>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff <blob> <blob>
>
> where --cached means "use the version of the work tree stored
> in the index in place of the real thing".

I prefer this above the other proposals.  This breakdown makes the
most sense to me, and I see no reason to use <commit> when we really
mean <tree>.  One minor thing: should the "<blob> <blob>" form be
moved above "<path> <path>" so that all the git object forms are
together?

On a related note, I find it a bit confusing that <path> is used to
mean two very different things.  For "<path> <path>", it means a file
that must exist on disk.  For "[<path>...]", it means a pattern on
which to filter the output of the command.  Since we already have a
name for the latter, perhaps we should use the term "[<pathspec>...]".
