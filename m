From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Sun, 04 May 2014 12:55:43 +0200
Message-ID: <m2mwexke34.fsf@linux-m68k.org>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
	<1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
	<5365D91E.70207@alum.mit.edu> <536606AB.1020803@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun May 04 12:55:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgu5N-0007KN-6R
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 12:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbaEDKzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 06:55:51 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:60733 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbaEDKzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 06:55:51 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3gM3yX63Xnz4KKhB;
	Sun,  4 May 2014 12:55:48 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3gM3yX57G8zbbcR;
	Sun,  4 May 2014 12:55:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id eUiefgCzUV-N; Sun,  4 May 2014 12:55:48 +0200 (CEST)
X-Auth-Info: yFvD+3b9rBOa1DHVzlV4RBpNpnhLXmQyUbJv1EGb1bM=
Received: from linux.local (ppp-93-104-158-29.dynamic.mnet-online.de [93.104.158.29])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun,  4 May 2014 12:55:48 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id B84741E56C4; Sun,  4 May 2014 12:55:44 +0200 (CEST)
X-Yow: YOW!!
In-Reply-To: <536606AB.1020803@kdbg.org> (Johannes Sixt's message of "Sun, 04
	May 2014 11:21:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248092>

Johannes Sixt <j6t@kdbg.org> writes:

> I think that a compiler that has different size and alignment requirements
> for the proposed struct object_id and an unsigned char[20] would, strictly
> speaking, not be a "C" compiler.

Unlike arrays, a struct can have arbitrary internal padding.  It is
perfectly compliant (and even reasonable) to make struct object_id
require 8 byte alignment, adding 4 bytes of padding at the end.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
