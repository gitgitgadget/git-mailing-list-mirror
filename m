From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 20:34:23 -0400
Message-ID: <48B4A10F.10601@gmail.com>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>,
	=?ISO-8859-1?Q?Kristian_H=F8?= =?ISO-8859-1?Q?gsberg?= 
	<krh@redhat.com>, Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, users@kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 02:35:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY90g-0005nP-2P
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 02:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbYH0Aec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 20:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbYH0Aec
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 20:34:32 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:64846 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbYH0Aeb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 20:34:31 -0400
Received: by an-out-0708.google.com with SMTP id d40so358039and.103
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 17:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=k3zeXGbZHDEiP7mWqHzNwZIjyAY26XSduHxRx+Y5bag=;
        b=DAKYpej9a5pi08vtqFh/zUvMOXz94wgszAhDsFqpc2zLlaVqvTpONKczVeHbOr8YaT
         UTzYaxfN7HZMb3obazjHRCWW+AktljnF7hKOpkse8ZVvNLU2gW7lhUTR5zGQoX8WTlsD
         QENkQnpZwiIRR7F+XyMI5TSpUwInvu19PHLNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=ERbVo9iVsY0rGNRFb4/VTlWtd551EeCYy35MyeeA+aafB3LEWTQ0as2/jClCSyuU9I
         2mo/sDHOQcFIx73xu+RuY2nuEY5CEL2P/93zV+2LyDgtnom9MqkjbN3fyLRmtd0U44Sx
         K48PbF9gQmHz3wbVtxf7+TP+uEgJlUXLv8Xlo=
Received: by 10.100.249.10 with SMTP id w10mr6523080anh.139.1219797270525;
        Tue, 26 Aug 2008 17:34:30 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id d36sm10058122and.30.2008.08.26.17.34.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Aug 2008 17:34:29 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93842>

Linus Torvalds wrote:

> 
> So live with it, and just add the 
> 
> 	PATH="$PATH:$(git --exec-path)"
> 
> as a "compatibility layer" to your own setup already. There is no 
> downside, and I think there _is_ a big upside, and no, it's not just about 
> "/usr/bin" being smaller.

Actually, this is acceptable since I set gitexecdir to $(bindir) in my 
make invocation.

*BUT* the recent discussion of not creating the hardlinks in 
git/core/libexec, introducing obnoxious warnings when using the dashed 
forms, and eventually having the git binary error when invoked as a 
dashed command is NOT acceptable. The discussion that happened in 
November and December 2006 was only about about moving the executables 
out of /usr/bin, not the completely disabling of the dashed forms for 
those users and distributions that want them.
