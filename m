From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Makefile: do not optimize when DEBUG=1
Date: Wed, 07 Mar 2007 10:26:38 +0100
Organization: eudaptics software gmbh
Message-ID: <45EE854E.210EDAFF@eudaptics.com>
References: <Pine.LNX.4.63.0703062249540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 10:24:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOsNp-0002wE-Bv
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 10:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbXCGJYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 04:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbXCGJYZ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 04:24:25 -0500
Received: from main.gmane.org ([80.91.229.2]:41972 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422645AbXCGJYY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 04:24:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HOsNb-0002VM-8M
	for git@vger.kernel.org; Wed, 07 Mar 2007 10:24:15 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Mar 2007 10:24:15 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Mar 2007 10:24:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41660>

Johannes Schindelin wrote:
> You can do that now by removing just the object files containing the
> code you want to debug, and saying "make DEBUG=1".
> [...]
> -CFLAGS = -g -O2 -Wall
> +CFLAGS = -g -Wall
> +ifndef DEBUG
> +       CFLAGS += -O2
> +endif

I think the shortcut to remove just the interesting object file does not
work because Makefile notices (the GIT-CFLAGS rule) that there are "new
flags or prefix", and so recompiles everything.

-- Hannes
