From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 1/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 12:36:29 +0200
Organization: eudaptics software gmbh
Message-ID: <4625F4AD.5CDDC502@eudaptics.com>
References: <11768880622402-git-send-email-junkio@cox.net> <1176888062865-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 12:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He7Wr-0006jS-Rt
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 12:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422800AbXDRKgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 06:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422811AbXDRKgr
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 06:36:47 -0400
Received: from main.gmane.org ([80.91.229.2]:39138 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422800AbXDRKgq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 06:36:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1He7Wc-0000Lg-Q5
	for git@vger.kernel.org; Wed, 18 Apr 2007 12:36:34 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Apr 2007 12:36:34 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Apr 2007 12:36:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44883>

Junio C Hamano wrote:
> +       interpolate(cmdbuf, sizeof(cmdbuf), cmd, table, 3);
> +
> +       memset(&child, 0, sizeof(child));
> +       child.argv = args;
> +       args[0] = "sh";
> +       args[1] = "-c";
> +       args[2] = cmdbuf;
> +       args[3] = NULL;

If I read the code correctly, there does not happen any shell quoting
anywhere; hence, this shell invocation is dangerous.

-- Hannes
