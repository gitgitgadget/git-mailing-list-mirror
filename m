From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 19:51:28 -0500
Message-ID: <474F5E90.9040505@gmail.com>
References: <20071127160423.GA22807@laptop>	<Pine.LNX.4.64.0711271617350.27959@racer.site>	<20071128000731.GD9174@efreet.light.src>	<7v8x4jb295.fsf@gitster.siamese.dyndns.org>	<fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>	<7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>	<20071129150849.GA32296@coredump.intra.peff.net>	<fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com>	<20071129211409.GA16625@sigill.intra.peff.net>	<Pine.LNX.4.64.0711292218240.27959@racer.site>	<20071129231444.GA9616@coredump.intra.peff.net>	<alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 01:51:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixu6m-0006n3-Mc
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 01:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934271AbXK3Avg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 19:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934257AbXK3Ave
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 19:51:34 -0500
Received: from rn-out-0910.google.com ([64.233.170.190]:57611 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934241AbXK3Avc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 19:51:32 -0500
Received: by rn-out-0102.google.com with SMTP id i6so1805181rng
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 16:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=rlJ9EPHMyN5PKuGGsnt85+Z7DJGV0BIZql/M813vNio=;
        b=ALQ2mC6juvSNqhAW0wG2BS+IfIVNiT35bcgyLuY1e4GmEAB492iH2UAaZyh8VWU1VAXz9b3ZzkpI3kpCs530dfpyocPmmwbmcb0ojYogQheSvOC9p601ehNrgkEuTmd1FRqu3IU+fFyY2fR21I0lWkYjqvCaRuz8tHd9Uy8ZL+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=M/crpSPbcu5XnlbhWZYIsuuzN0FZjn69+YWdZQHiZkwrXllCZpn1iR6S62f8fCXr6JvExpG/VH4nKhf1mkwnqVkVSUNjQ8SWsumeJwpa3LKFDKRWrjjEbTcDloUGpfMJKPEKn6yBiZaGEwKA4ePUwX/gltW0YbYHQU4LSrh2qTg=
Received: by 10.150.95.20 with SMTP id s20mr99927ybb.1196383891738;
        Thu, 29 Nov 2007 16:51:31 -0800 (PST)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id 8sm7850166wrl.2007.11.29.16.51.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Nov 2007 16:51:31 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7veje8twt2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66583>

Junio C Hamano wrote:
[...]
> Ok.  So here is a revised roadmap that a panda brain (that is not so
> well working today due to fever) came up.
> 
>  - v1.5.4 will ship with gitexecdir=$(bindir) in Makefile.  But the
>    release notes for the version will warn users that:
> 
>    (1) using git-foo from the command line, and
> 
>    (2) using git-foo from your scripts without first prepending the
>        return value of "git --exec-path" to the PATH
> 
>    is now officially deprecated (it has been deprecated for a long time
>    since January 2006, v1.2.0~149) and upcoming v1.5.5 will ship with
>    the default configuration that does not install git-foo form in
>    user's PATH.
> 
>    If further will warn users that git-foo form will be removed in
>    v1.5.6 for many commands and it will be merely an accident if some of
>    them still work after that.
> 
>  - Post v1.5.4, start cooking gitexecdir=$(libexecdir)/git-core, aiming
>    for inclusion in v1.5.5, perhaps in Feb-Mar 2008 timeframe.  This
>    will also affect the sample RPM spec and resulting RPM binary
>    packages I will place on k.org, and I'll ask Gerrit to do the same on
>    Debian side.  The official binary packaging of individual distros are
>    not under my control, but if there is a handy list of people I can
>    send this notice to for other distros, that would help this process.
> 
>  - The release notes for v1.5.5 will warn users again that git-foo will
>    be removed in v1.5.6 for many commands and it will be merely an
>    accident if some of them still work.
> 
>  - Post v1.5.5, start cooking the change that does not install hardlinks
>    for built-in commands, aiming for inclusion in v1.5.6, in May-Jun
>    2008 timeframe.

Again, there needs to remain support in the Makefile to install the 
"dashed" versions of the commands for those that want it; and be able to 
set gitexecdir=$(binder) without editing the Makefile.
