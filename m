From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: Re: [PATCH 2/4] git-prompt.sh: refactor colored prompt code
Date: Mon, 24 Jun 2013 22:21:52 -0300
Message-ID: <CAOz-D1Lfh5tnjMriQNQtNYeMUHb=jLbjzxt0=Nru8gPYwVk79A@mail.gmail.com>
References: <cover.1371780085.git.erdavila@gmail.com> <354a860e12a3463ce5d031c0dc46d095841f717d.1371780085.git.erdavila@gmail.com>
 <CAOz-D1+LoAnoRLgnyRYtq5LQR32RyXp4RR2M5pPTaxaGcXM4yg@mail.gmail.com> <20130623145157.GN20052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=D8ystein_Walle?= <oystwa@gmail.com>,
	git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 25 03:22:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrHxY-0001DW-TN
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 03:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973Ab3FYBWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 21:22:13 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:48242 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab3FYBWM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jun 2013 21:22:12 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so26131532iec.19
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 18:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=G83fgTJudVzFIae1O4cm8EDawLifl2EsZ/emtK79+vM=;
        b=nEfZNgzF4jiP4mnk4le5SjW/YGh4w5lkhWm2EPHipltnipYtUh39FU+Ie9TV//rY1V
         EuBj424GBMFe9VrZobpVVLNWMrkV7Fy65OqpBM7HFTAdq2AtgC+MpvDjd1BJmo+wKSsk
         Dwqa2sc7NvipxbX4gUwFbrKpXNymsjb1THEgxT+xdPOj1jbIKQQyhu/3/D3AGeoU8Gpu
         E2QxIzv1F+yGFmWFPevzpbk3ahkgOzcVjNwCtFXmy2w+6biwQZfthapd4GsDwKvfVPH0
         LMyjLljFfdgbidQWt0l7pA9p3p4f15/1e7HO7XqTw3kTWOGjrcFwtN+hIky0fYxaEO39
         r8Zg==
X-Received: by 10.50.111.104 with SMTP id ih8mr7267632igb.28.1372123332178;
 Mon, 24 Jun 2013 18:22:12 -0700 (PDT)
Received: by 10.42.249.197 with HTTP; Mon, 24 Jun 2013 18:21:52 -0700 (PDT)
In-Reply-To: <20130623145157.GN20052@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228939>

2013/6/23 SZEDER G=E1bor <szeder@ira.uka.de>:
> I'm wary of relying on tput's availability.  It's part of ncurses,
> which is an essential package in many (most? all?) linux distros, but
> I don't know how it is with other supported platforms.  So I think
> we'd have to stick to the hard-coded escape sequences as a fallback
> anyway. (...)
>
> However, I don't know much about the caveats of terminals, so I can't
> judge the benefits of using tput instead of the escape sequences.

I'm exactly in the same situation...

> considering the additional delay that would be caused by fork()ing
> four subshells and fork()+exec()ing four external commands on Windows=
=2E

Well... That would be only once, during script loading.


Given the concerns raised by G=E1bor (edited and quoted above) and that
there is no known issue (afaik) with the current implementation, I'm
tending to revert to the escape sequences.
