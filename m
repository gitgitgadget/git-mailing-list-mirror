From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 23:34:36 -0400
Message-ID: <n2g32541b131005072034o2bceb6b7h34f68ad5c867eddf@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<alpine.LFD.2.00.1005071504280.901@i5.linux-foundation.org> 
	<h2q32541b131005071534r22cc2092t2a21bfad6d4bfd81@mail.gmail.com> 
	<alpine.LFD.2.00.1005071601470.901@i5.linux-foundation.org> 
	<q2y600158c31005071647i80871db0z7a55ae77e738d0d4@mail.gmail.com> 
	<alpine.LFD.2.00.1005071648400.901@i5.linux-foundation.org> 
	<i2v600158c31005071719r23db385bpab9a971534b5d7c3@mail.gmail.com> 
	<alpine.LFD.2.00.1005071728250.901@i5.linux-foundation.org> 
	<i2g600158c31005071839wc5269ffqc88cb26e48c44748@mail.gmail.com> 
	<alpine.LFD.2.00.1005071847100.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: hasen j <hasan.aljudy@gmail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 08 05:35:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAaoh-0007iU-OZ
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 05:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463Ab0EHDe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 23:34:58 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:32916 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab0EHDe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 23:34:57 -0400
Received: by ywh36 with SMTP id 36so1028734ywh.4
        for <git@vger.kernel.org>; Fri, 07 May 2010 20:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=d7ADJMV8zB1ijzYrB6RGNHX2xVmp4CTcw6+4zmk472g=;
        b=h344wRJbjMVUeiYy7aXPN/TKUwRNypUH5tbJuUMLIoANTwUYfYIAuF9uakgR6oBByB
         UKpSKi2Ujced4EIMzu+d7czYgcp9gAhwuwFVkbcBkiQf/mnw480uTEFxH72WC7uKYQ88
         OGqhw4gbw0EXibO2nCI2pqCIBoUgBohOKD16I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=bAWNUXa9OTNvIQyb04yfkNutB51jLIedcalnA510Y7//xpcHOWvvff0gXt7VRUmsH9
         O/xAQ9T2UAvrQAc2Q4KK5+s/0F2djod1Ii+qO6aAx6tk+R7odbrQr6mKRe1mH22iDh5P
         OK2AjCYueJU67PW4SAlw/ovHaegUN+mk5UcUA=
Received: by 10.150.47.4 with SMTP id u4mr4682779ybu.179.1273289696201; Fri, 
	07 May 2010 20:34:56 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 20:34:36 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071847100.901@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146630>

On Fri, May 7, 2010 at 9:49 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> So when you say "What does the platform care?", that is a totally idiotic
> and utterly stupid thing to ask.
>
> And since you ask it, I can only assume that you don't understand anything
> about the whole CRLF discussion, that you don't care about cross-platform
> repositories, and that as a result you should NEVER EVER actually use any
> of the git crlf conversion code.

I guess there's your use case for being able to turn off crlf=input, then. :)

Hasen: you and Linus don't seem to be communicating clearly, but it
looks to me like Linus's proposed changes would work fine for your use
case.  What you want is for the repository maintainer to be able to
control whether a file is checked out with crlf or not; this is
possible with *either* a per-project .gitconfig or a crlf=true
attribute that works when core.autocrlf is unspecified, which are
Linus's two suggested options.  If you really, truly want your crlf
characters not to be messed with, then set crlf=false, which means
"binary." [1].

[1] Which reminds me of my opinion about it being too hard to tell
what you're specifying given the current set of config options. But
'man gitattributes' makes at least this point clear.

Have fun,

Avery
