From: Jeremy Huddleston <jeremyhu@apple.com>
Subject: Re: 1.7.3.4 build regression
Date: Thu, 16 Dec 2010 20:02:33 -0800
Message-ID: <21774743-8BA8-4A1C-BDCF-1E3F7D85EFB5@apple.com>
References: <8779CB66-03D3-4EC9-8650-521532112CA5@apple.com> <20101217034123.GA7362@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 05:02:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTRWq-0007M6-3M
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 05:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847Ab0LQECn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 23:02:43 -0500
Received: from cloud.CS.Berkeley.EDU ([128.32.36.234]:46786 "EHLO
	mail.outersquare.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab0LQECm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 23:02:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.outersquare.org (Postfix) with ESMTP id 44A8054113;
	Thu, 16 Dec 2010 20:02:40 -0800 (PST)
X-Virus-Scanned: amavisd-new at mail.outersquare.org
Received: from mail.outersquare.org ([127.0.0.1])
	by localhost (mail.outersquare.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XpnDNUu0Tv0Z; Thu, 16 Dec 2010 20:02:34 -0800 (PST)
Received: from 75-144-255-90-sfba.hfc.comcastbusiness.net (75-144-255-90-SFBA.hfc.comcastbusiness.net [75.144.255.90])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jeremy@mail.outersquare.org)
	by mail.outersquare.org (Postfix) with ESMTPSA id 3C38F51F7C;
	Thu, 16 Dec 2010 20:02:34 -0800 (PST)
In-Reply-To: <20101217034123.GA7362@burratino>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163859>

On Dec 16, 2010, at 19:41, Jonathan Nieder wrote:

> Hi Jeremy,
> 
> Jeremy Huddleston wrote:
> 
>> 1.7.3.4 seems to have a regression (over 1.7.3.2 ... didn't try 1.7.3.3)
>> building.  I do:
>> 
>> make
>> (strip the built executables)
>> make install
>> 
>> During 'make install', the executables get remade even though they
>> shouldn't be.
> 
> Just a wild guess: do you pass CC on the "make" and not the "make
> install" command line?

Yes.  Good guess.  Why would that be affecting it?

Some updates:

It occurs with 1.7.3.3 as well.

"make" line is:
/Developer/usr/bin/make -C /tmp/Git-16.roots/Git-16~obj/i386/ -j`sysctl -n hw.activecpu` prefix=/usr NO_FINK=YesPlease NO_DARWIN_PORTS=YesPlease RUNTIME_PREFIX=YesPlease GITGUI_VERSION=0.12.0 V=1 CFLAGS='-ggdb3 -Os -pipe -Wall -Wformat-security -D_FORTIFY_SOURCE=2' 'CC=cc -arch i386' 'uname_M=i386' 'uname_P=i386' && touch /tmp/Git-16.roots/Git-16~obj/i386/build.timestamp

"make install" line is:
/Developer/usr/bin/make -C /tmp/Git-16.roots/Git-16~obj/i386 -j`sysctl -n hw.activecpu` prefix=/usr NO_FINK=YesPlease NO_DARWIN_PORTS=YesPlease RUNTIME_PREFIX=YesPlease GITGUI_VERSION=0.12.0 V=1 CFLAGS='-ggdb3 -Os -pipe -Wall -Wformat-security -D_FORTIFY_SOURCE=2' \          'DESTDIR=/tmp/Git-16.roots/Git-16~dst' \
          install
