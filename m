From: Jan Engelhardt <jengelh@inai.de>
Subject: RE: git on HP NonStop
Date: Sun, 19 Aug 2012 18:25:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1208191824100.29175@frira.zrqbmnf.qr>
References: <001101cd79f2$f21b3bd0$d651b370$@schmitz-digital.de> <7vr4r98rfd.fsf@alter.siamese.dyndns.org> <004b01cd7a34$dbf2c160$93d84420$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Sun Aug 19 18:25:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T38Ju-0004vM-QA
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 18:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989Ab2HSQZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 12:25:42 -0400
Received: from seven.medozas.de ([5.9.24.206]:40554 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab2HSQZk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 12:25:40 -0400
Received: by seven.medozas.de (Postfix, from userid 25121)
	id 78D1096A07D8; Sun, 19 Aug 2012 18:25:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id 5AB2D96A02A2;
	Sun, 19 Aug 2012 18:25:38 +0200 (CEST)
In-Reply-To: <004b01cd7a34$dbf2c160$93d84420$@schmitz-digital.de>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203721>


On Tuesday 2012-08-14 17:52, Joachim Schmitz wrote:
> @@ -98,6 +99,11 @@
> #include <stdlib.h>
> #include <stdarg.h>
> #include <string.h>
>+#ifdef __TANDEM
>+# include <strings.h> /* for strcasecmp() */
>+  typedef int intptr_t; /* not "int *" ?!? */
>+  typedef unsigned int uintptr_t; /* not "unsigned int *" ?!? */

Of course not. intptr_t is an integral value capable of holding
a pointer; it is not a pointer to int (because that would really
be redundant to int*.)
