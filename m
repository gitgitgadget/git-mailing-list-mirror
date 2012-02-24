From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git and SSL certificates
Date: Fri, 24 Feb 2012 11:27:21 -0800
Message-ID: <CAJo=hJuyHv_L_zajW-MWEj6fDGggrVDkRWT32mD5TBzD_GzReQ@mail.gmail.com>
References: <000501ccf328$1efe1070$5cfa3150$@nedharvey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Edward Ned Harvey <git@nedharvey.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 20:27:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S10o6-0004YG-Vs
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 20:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757476Ab2BXT1u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 14:27:50 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48584 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757454Ab2BXT1l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2012 14:27:41 -0500
Received: by daed14 with SMTP id d14so2825056dae.19
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 11:27:41 -0800 (PST)
Received-SPF: pass (google.com: domain of spearce@spearce.org designates 10.68.218.161 as permitted sender) client-ip=10.68.218.161;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of spearce@spearce.org designates 10.68.218.161 as permitted sender) smtp.mail=spearce@spearce.org; dkim=pass header.i=spearce@spearce.org
Received: from mr.google.com ([10.68.218.161])
        by 10.68.218.161 with SMTP id ph1mr11206454pbc.107.1330111661110 (num_hops = 1);
        Fri, 24 Feb 2012 11:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JvUJ3r1+SNXKGZ7J4VFAhWi6d8un4K/dlYj51ezA6po=;
        b=aXRMiaKEjKJF0Hvz4WXAmTQlP7wHAurflkqYBdAUolS3Mo3wkK09eVH3ScYihrv05g
         87Amqq/ecrOAPgWyX8pMU1bs2WctuMNU90cstJ0ebCBOVjGa7P3pnqP9MrqMip+Q9ByT
         BJzprGGPL6u9FySBSHkvN7ylkPIMmmyZrW2kI=
Received: by 10.68.218.161 with SMTP id ph1mr9293549pbc.107.1330111661065;
 Fri, 24 Feb 2012 11:27:41 -0800 (PST)
Received: by 10.68.64.34 with HTTP; Fri, 24 Feb 2012 11:27:21 -0800 (PST)
In-Reply-To: <000501ccf328$1efe1070$5cfa3150$@nedharvey.com>
X-Gm-Message-State: ALoCoQnITzgn8GdHMiopPD8ZhznYXX0z/5byAHe3MqfUy47wGYTv7eJ7ZZwdqjLLvFau9k6coBny
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191447>

On Fri, Feb 24, 2012 at 11:11, Edward Ned Harvey <git@nedharvey.com> wr=
ote:
> I have a git server hosted on https (github enterprise virtual applia=
nce),
> using a valid signed cert from startcom, which passes all the SSL che=
cks for
> any browser I use on any OS (IE, Firefox, Safari, Chrome, on Ubuntu, =
Mac
> OSX, MS Win7) but when I connect to it using git, git complains about=
 the
> cert, but it's platform dependent, and it doesn't seem to make any se=
nse...
> Does git have its own set of SSL trusted root CA's compiled in at bui=
ld time
> or something?=A0 It seems weird that it's apparently not using the tr=
usted
> root CA's from the OS...

Nope. Git uses the system's libcurl, which is probably using the
system's libssl or libgnutls, which is using the system's
certificates.
