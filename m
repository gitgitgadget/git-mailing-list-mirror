From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: How to rebase one branch of the merge commit?
Date: Sun, 01 Feb 2015 20:28:28 +0100
Message-ID: <1422818908.29011.6.camel@kaarsemaker.net>
References: <20150201184214.GA89666@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Hans Ginzel <hans@matfyz.cz>
X-From: git-owner@vger.kernel.org Sun Feb 01 20:29:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YI0Cc-0004E2-LH
	for gcvg-git-2@plane.gmane.org; Sun, 01 Feb 2015 20:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbbBAT2c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Feb 2015 14:28:32 -0500
Received: from mail-wg0-f51.google.com ([74.125.82.51]:63555 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbbBAT2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2015 14:28:32 -0500
Received: by mail-wg0-f51.google.com with SMTP id k14so35173205wgh.10
        for <git@vger.kernel.org>; Sun, 01 Feb 2015 11:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=k8Uo5xQ59FoVxhl0JKU7/eCYDYaj+pt4QhF905Deb70=;
        b=SMxdK5BiTxO+BdcF0rCsy2wzia/o0DSW1CgiaMHu4H+Nmx/cmXMZH4tCFux9kF6XfG
         JfRqvBj8bEO+gMazl0SWiCOjnNErR0MoLYRLawOh73aUWrkKYbnhXzdInzpWbwUAB4Du
         w22untKNSnGCpWzZ1ZXBcDR3GJTNWjgLZGWPwXA0lhzEbyIPcM5a5bhL11FmrORuOA+3
         9cz/WGz4pmjLLD6oUkpuDd8cuJSfeGuc44bLKXvGjkY3Tq1HowAeWFgZwsGto0B0VHxA
         HUTysE13HEy0xBPqMYBF2W4NlQL0E4WVBo28BJF2SRaNexyrw63LFuaVPovIekpGn55B
         vN5w==
X-Gm-Message-State: ALoCoQkWrEWGeYUH5zhZ9DVrmQ4Ad+Uei94pTQIZTB7bvGnMDOkmml0+riiHoIzbcTQvtnTJ7QgU
X-Received: by 10.194.85.106 with SMTP id g10mr34892976wjz.39.1422818910628;
        Sun, 01 Feb 2015 11:28:30 -0800 (PST)
Received: from spirit.local (82-171-80-33.ip.telfort.nl. [82.171.80.33])
        by mx.google.com with ESMTPSA id fo15sm16482396wic.19.2015.02.01.11.28.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Feb 2015 11:28:29 -0800 (PST)
In-Reply-To: <20150201184214.GA89666@artax.karlin.mff.cuni.cz>
X-Mailer: Evolution 3.12.7-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263237>

On zo, 2015-02-01 at 19:42 +0100, Hans Ginzel wrote:
> Hello!
>=20
> Suppose following git history:
>=20
> A=E2=80=93M=E2=80=93C
>   /
> B
>=20
> How to achieve this with commits metadata preserving?
>=20
> A=E2=80=93M'=E2=80=93C'
>   /
> B'
>=20
> I did
>=20
> git checkout B
> git add something_not_in_other_commits
> git commit --amend
>=20
> So I have B'. How to continue, please? My git version is 1.7.1 (Cento=
s 6.5).

Assuming you have a branch pointing to C and no uncommitted changes:

1) git checkout branch-that-points-to-c
2) git rev-parse branch-that-point-to-c
3) git reset --hard A
4) git merge B'
5) git cherry-pick sha1-that-was-the-output-of-step-2

--=20
Dennis Kaarsemaker
www.kaarsemaker.net
