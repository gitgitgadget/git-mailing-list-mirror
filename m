From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: segfault when cloning over https
Date: Thu, 29 Jan 2009 19:46:07 +0100 (CET)
Message-ID: <alpine.DEB.1.10.0901291944030.5789@yvahk2.pbagnpgbe.fr>
References: <20090129184523.GI23133@fi.muni.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jan Kasprzak <kas@fi.muni.cz>
X-From: git-owner@vger.kernel.org Thu Jan 29 19:52:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSbzT-0006FU-HP
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 19:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbZA2SuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 13:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbZA2SuM
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 13:50:12 -0500
Received: from kluster1.contactor.se ([91.191.140.11]:32880 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbZA2SuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 13:50:11 -0500
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n0TIntoq003391;
	Thu, 29 Jan 2009 19:49:55 +0100
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <20090129184523.GI23133@fi.muni.cz>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107714>

On Thu, 29 Jan 2009, Jan Kasprzak wrote:

> without problems, but when I change http to https, it either segfaults or 
> fails with heap corruption detected:

> /lib64/libnsspem.so[0x7f845f3ee9c4]
> /lib64/libnss3.so[0x7f846210dc4d]
> /lib64/libnss3.so(PK11_CreateGenericObject+0x42)[0x7f846210ded2]
> /usr/lib64/libcurl.so.4[0x14b129]

This is a libcurl built to use a Fedora-patched NSS library for the SSL stuff. 
You could try to build your own libcurl with a different SSL library to see if 
that works fine, as then we could narrow this down a bit...

-- 

  / daniel.haxx.se
