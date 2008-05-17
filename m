From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL characters
Date: Sat, 17 May 2008 12:07:26 +0200
Message-ID: <20080517100726.GA24416@cuci.nl>
References: <482BE5F7.2050108@thorn.ws> <alpine.DEB.1.00.0805161139530.30431@racer> <alpine.DEB.1.00.0805161148010.30431@racer> <alpine.DEB.1.00.0805161403130.30431@racer> <32541b130805160703r27a55b91xbad03eb1d107a176@mail.gmail.com> <alpine.DEB.1.00.0805161529390.30431@racer> <32541b130805160756h5a8fc4d7x313f9bfde4760568@mail.gmail.com> <alpine.DEB.1.00.0805170058160.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Tommy Thorn <tommy-git@thorn.ws>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 17 12:08:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxJKv-0006Un-UA
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 12:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbYEQKHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 06:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbYEQKHb
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 06:07:31 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:47965 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbYEQKHb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 06:07:31 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id A8B685461; Sat, 17 May 2008 12:07:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805170058160.30431@racer>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82340>

Johannes Schindelin wrote:
>On Fri, 16 May 2008, Avery Pennarun wrote:
>> fread is about 18x faster than fgetc().  getc() is the same speed as
>> fgetc().  getc_unlocked() is definitely faster than getc, but still at
>> least 7x slower than fread().

>Well, my question was more about fgetc() vs fgets().
>If you feel like it, you might benchmark this patch:

Wouldn't it be better to improve the implementation of getc()
in glibc instead?

getc() is meant to be the fast version of fgetc(), and if it isn't
(anymore), then the library needs fixing.
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.
