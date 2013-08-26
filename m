From: Lukas Fleischer <git@cryptocrack.de>
Subject: Re: Issue with compiling git 1.8.4 under uclibc with gcc 4.6.3
Date: Mon, 26 Aug 2013 22:18:04 +0200
Message-ID: <20130826201804.GB13130@blizzard>
References: <521BB643.304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lance <lancethepants@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 22:18:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE3Ew-0008Fc-Oq
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 22:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376Ab3HZUSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 16:18:13 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:10827 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681Ab3HZUSL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 16:18:11 -0400
Received: from localhost (p57B4037E.dip0.t-ipconnect.de [87.180.3.126]);
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id a7c1db75;
	TLS version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO;
	Mon, 26 Aug 2013 22:18:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <521BB643.304@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233023>

On Mon, Aug 26, 2013 at 02:10:43PM -0600, Lance wrote:
> Up until the latest release, I've been able to compile git for a
> uclibc based embedded linux. The toolchain I use is from "entware",
> which is based off of the openwrt toolchain.
> https://code.google.com/p/wl500g-repo/
> 
> Somewhere between git 1.8.3.4 & 1.8.4 there seems to be some changes
> that breaks compilation for my particular situation.  When cross
> compiling I receive the following error.  I also receive the same
> error when compiling natively on the uclibc based device itself.
> Not sure if being uclibc based has anything to do with it, but is
> noteworthy. I am not a c programmer.
> Both the cross compiler, and embedded device's version off gcc is 4.6.3.
> Previous versions compile fine
> 
>     CC config.o
> config.c: In function 'get_next_char':
> config.c:220:14: error: expected identifier before '(' token
> config.c:220:14: error: expected statement before ')' token
> config.c:220:14: error: expected statement before ')' token
> config.c:224:11: error: expected identifier before '(' token

Does changing line 220 of config.c to

    int c = (cf->fgetc)(cf);

fix it?

> 
> Lance
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
