From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
   API
Date: Thu, 05 Nov 2009 08:33:17 +0100
Message-ID: <4AF27FBD.10203@viscovery.net>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>	 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>	 <alpine.LFD.2.00.0911041247250.10340@xanadu.home> <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com> <4AF21283.3080407@gmail.com> <4AF214D5.6050202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 08:33:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5wqY-0008H8-15
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 08:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbZKEHdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 02:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753538AbZKEHdQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 02:33:16 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:46729 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753222AbZKEHdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 02:33:16 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N5wqL-0001QX-ST; Thu, 05 Nov 2009 08:33:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9EFE84E9; Thu,  5 Nov 2009 08:33:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AF214D5.6050202@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132204>

Andrzej K. Haczewski schrieb:
> This patch implements native to Windows subset of pthreads API used by Git.
> It allows to remove Pthreads for Win32 dependency for msysgit and cygwin.
> 
> The patch modifies Makefile only for MSVC (that's the environment I'm
> capable of testing on), so it requires further corrections to compile
> with MinGW or Cygwin.

Looks quite good already.

In the next round, please squash this in.

diff --git a/Makefile b/Makefile
index bae1b40..6648d11 100644
--- a/Makefile
+++ b/Makefile
@@ -414,6 +414,7 @@ LIB_H += cache-tree.h
 LIB_H += commit.h
 LIB_H += compat/cygwin.h
 LIB_H += compat/mingw.h
+LIB_H += compat/win32/pthread.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
