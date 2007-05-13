From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [PATCH] Make git compile with SUNs forte12 compiler
Date: Sun, 13 May 2007 09:47:32 +0000 (UTC)
Message-ID: <pan.2007.05.13.09.47.32@free.fr>
References: <11790057101792-git-send-email-sithglan@stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 13 11:50:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnAir-0000cV-2W
	for gcvg-git@gmane.org; Sun, 13 May 2007 11:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670AbXEMJuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 05:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757159AbXEMJuU
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 05:50:20 -0400
Received: from main.gmane.org ([80.91.229.2]:47256 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756670AbXEMJuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 05:50:18 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HnAiI-0000XF-9c
	for git@vger.kernel.org; Sun, 13 May 2007 11:50:02 +0200
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 May 2007 11:50:02 +0200
Received: from castet.matthieu by cac94-1-81-57-151-96.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 May 2007 11:50:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.125 (Potzrebie)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47134>

Hi,

On Sat, 12 May 2007 23:35:10 +0200, Thomas Glanzmann wrote:

> This patch moves two inline functions from a header file to the
> corresponding c file. Otherwise forte12 refuses to compile git with the
> following error:
> 
Did you understand what you did ?

You can't put a inline global function in a *.c : you need to put it in 
the header so that when parsing other files the compiler finds the 
definition and can inline it.

In your patch, you transform a static inline function to a global 
function whith is not the same thing...


Matthieu
