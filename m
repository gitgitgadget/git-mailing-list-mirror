From: Anupam Srivastava <srivasta@itt.uni-stuttgart.de>
Subject: Re: Error compiling git
Date: Sun, 19 Aug 2007 23:18:19 +0200
Message-ID: <46C8B39B.6060603@itt.uni-stuttgart.de>
References: <46C8AAC6.4060101@itt.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 19 23:18:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMsAC-0003Z7-FA
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 23:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987AbXHSVSV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 17:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754502AbXHSVSV
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 17:18:21 -0400
Received: from ittli1.itt.uni-stuttgart.de ([129.69.36.101]:21545 "EHLO
	ittli1.itt.uni-stuttgart.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754762AbXHSVSV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2007 17:18:21 -0400
Received: from [129.69.36.169] (fornax.itt.uni-stuttgart.de [129.69.36.169])
	by ittli1.itt.uni-stuttgart.de (Postfix) with ESMTP id ECC3D624DA
	for <git@vger.kernel.org>; Sun, 19 Aug 2007 23:18:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <46C8AAC6.4060101@itt.uni-stuttgart.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56150>

Anupam Srivastava wrote:
> Hello all!
> 
> I am trying to compile git. The catch is that my zlib is installed in 
> non-standard directory, namely: /tmp/dont.delete/fakeroot
> 
> Here are my environment varialbes:
> LDFLAGS=-L/tmp/dont.delete/fakeroot/lib
> LD_RUN_PATH="/tmp/dont.delete/fakeroot/lib
> CC="ccache cc -o3"
> 
> but after running make, the compilation stops ate linking with this error:
> <snip>
>     AR xdiff/lib.a
>     LINK git-convert-objects
> /usr/lib64/gcc/x86_64-suse-linux/4.1.2/../../../../x86_64-suse-linux/bin/ld: 
> skipping incompatible /usr/lib/libz.so when searching for -lz
> /usr/lib64/gcc/x86_64-suse-linux/4.1.2/../../../../x86_64-suse-linux/bin/ld: 
> skipping incompatible /usr/lib/libz.a when searching for -lz
> /usr/lib64/gcc/x86_64-suse-linux/4.1.2/../../../../x86_64-suse-linux/bin/ld: 
> cannot find -lz
> collect2: ld returned 1 exit status
> make: *** [git-convert-objects] Error 1
> </snip>
> Which to my understating means that it is not even trying to find zlib 
> in /tmp/dont.delete/fakeroot
> 
> My way of compiling is:
> make configure
> ./configure --cache-file=config.cache --prefix=/tmp/dont.delete/fakeroot
> make
> 
Solved.
Removed/updated manually CFLAGS and LDFLAGS in Makefile

This is, I suppose, a bug in Makefile then.

The configure script created by Makefile should update Makefile with the 
arguments passed to it.

Anupam
