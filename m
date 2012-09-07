From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH v3 0/4] Support non-WIN32 systems lacking poll()
Date: Fri, 7 Sep 2012 14:51:30 +0200
Message-ID: <003901cd8cf7$80fac020$82f04060$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 14:51:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9y2Q-0002cB-BX
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 14:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760617Ab2IGMvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 08:51:51 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:54176 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755621Ab2IGMvu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 08:51:50 -0400
Received: from DualCore (dsdf-4d0a1723.pool.mediaWays.net [77.10.23.35])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0M51gc-1TVDPA3noM-00yYhi; Fri, 07 Sep 2012 14:51:39 +0200
References: 
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2M9zyvP7B3e8wRQH6ff/VB308ZHAAACaaw
Content-Language: de
X-Provags-ID: V02:K0:aY31x0Hk0jDIfC4GeLHeYxt+4dkKOxCHod7TFXsFVIN
 AQ2ZlowEsMgrHjvdHV69G+29aX95/5zsrr0BHkjS9t4vwCrpwh
 DdXgk+P5pjtABuBinczHCyrhOxlb2Gq4YuFQlx8BPSKbVlEXvn
 TTU9A+1DgDrlg1RaA+8QsRUQozDxHiWjFYkHYui3dYmenHnSfQ
 AwNorGLjDmTOP3Ndfoe0dZ3nyPX1Wzm8JfQRRHlAL49SdBiAGV
 waHz/F/VYOoWVRZiGOiWg4GxnYeXIKhP/J+/9ox6WQGpZC90Sg
 2GA2/OhhJsU5/m7kThw8b6I50mAYTz/eBnpRajiKWA38o2rhPu
 eqSCp+KIe9OYETUY2vQlj6ZGb4zHb7G8lbkktT9U9P79tR6QUi
 VJ7jUS1repDMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204960>

Here's now my series or patches to make the win32 implementation of poll() available to other platforms:

1 - poll() exits too early with EFAULT if 1st arg is NULL, as discussed with Paolo Bonzini from the gnulib team
2 - make poll available for other platforms lacking it by moving it into a separate directory and adjusting Makefile
3 - fix some win32 specific dependencies in poll.c by #ifdef the inclusion of two header files
4 - make poll() work on platforms that can't recv() on a non-socket, namely HP NonStop

Bye, Jojo
