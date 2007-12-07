From: "Blake Ramsdell" <blaker@gmail.com>
Subject: Re: [PATCH] Silence iconv warnings on Leopard
Date: Thu, 6 Dec 2007 16:44:04 -0800
Message-ID: <985966520712061644k72a4c4ecpfe26d4e00d14b337@mail.gmail.com>
References: <1196968023-45284-1-git-send-email-win@wincent.com>
	 <985966520712061504s686395d6jf680363c7b3b9de7@mail.gmail.com>
	 <200712070111.23283.jnareb@gmail.com>
	 <alpine.LFD.0.9999.0712061628070.13796@woody.linux-foundation.org>
	 <985966520712061641y4eba054dj5dea1d0308d50b12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Wincent Colaiuta" <win@wincent.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 01:44:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0RKQ-0001hO-Nx
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 01:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486AbXLGAoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 19:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbXLGAoH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 19:44:07 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:24006 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbXLGAoG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 19:44:06 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1008135wah
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 16:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4LGBBMnUHxcqnpE+/jHgJWgSrAUTcaIVCgtEFgPuk1c=;
        b=if/62luTV9p205CWBHiKj4ivtbcKYTsb85idXgKM/S1n8Ru7uhf2BXpkj4Ws7UQo4lYuvFIuvBG4mn+HAZ9fDHAIxxnMXS7Hax+gOvCjMHegY0eB0yjdA4I3suESafl0tbj7aKHWTNQhx8p1CfSDYOaJ4HDYixeOlJ3k2voofAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X8H6yvZn3sBakNNzF6FHIlXiC4WAGvbBXnPYfyKTzMklUJrHmI8Ile7aAbGlbqM2t8n+NGcb+LRnm1DdnHNLo9GS1ALP871G2cKkifuPwAuGehgxWtGAGhPu4O42U7FsWPVEFKxB+pcwS1DmUbLYaWSY2iwVawAvyjXZziD9a0Y=
Received: by 10.114.106.1 with SMTP id e1mr1524516wac.1196988244851;
        Thu, 06 Dec 2007 16:44:04 -0800 (PST)
Received: by 10.115.110.7 with HTTP; Thu, 6 Dec 2007 16:44:04 -0800 (PST)
In-Reply-To: <985966520712061641y4eba054dj5dea1d0308d50b12@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67362>

On Dec 6, 2007 4:41 PM, Blake Ramsdell <blaker@gmail.com> wrote:
> On Dec 6, 2007 4:30 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > Umm. Why not just make the test be whether the following compiles cleanly?
> >
> >         #include <iconv.h>
> >
> >         extern size_t iconv(iconv_t cd,
> >           char **inbuf, size_t *inbytesleft,
> >           char **outbuf, size_t *outbytesleft);
> >
> > because if the compiler has seen a "const char **inbuf", then it  should
> > error out with a "conflicting types for 'iconv'" style message..
>
> Yeah, this is what I did:

My apologies. Your suggestion is completely different, and should work
without -Werror. Let me try that.

Blake
-- 
Blake Ramsdell | http://www.blakeramsdell.com
