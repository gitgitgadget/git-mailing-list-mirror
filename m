From: linux@horizon.com
Subject: Re: svn to git, N-squared?
Date: 12 Jun 2006 00:39:49 -0400
Message-ID: <20060612043949.20992.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Mon Jun 12 06:39:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpeDR-0004pX-Mm
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 06:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWFLEjv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 00:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWFLEjv
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 00:39:51 -0400
Received: from science.horizon.com ([192.35.100.1]:1870 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751293AbWFLEju
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 00:39:50 -0400
Received: (qmail 20993 invoked by uid 1000); 12 Jun 2006 00:39:49 -0400
To: git@vger.kernel.org, jonsmirl@gmail.com, torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21690>

>	for i in ??
>	do
>		cp -r $i $i.new
>		rm -rf $i
>		mv $i.new $i
>	done
>
> in your .git/objects/ directory (CAREFUL! Any script that does "rm -rf" 
> should be double- and triple-checked for sanity! ;)

Insanity is copying the data rather than just the file name.  Git is
good about not reading unnecessary files, and anything necessary should
be cached, so on-disk fragmentation is not a concern.

rmdir --ignore-fail-on-non-empty ??	# Probably unnecessary.
for i in ??
do
	mkdir $i.new
	mv $i/* $i.new
	rmdir $i
	mv $i.new $i
done
