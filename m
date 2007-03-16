From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 09:06:51 +0100
Organization: eudaptics software gmbh
Message-ID: <45FA501B.FA5B9F30@eudaptics.com>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 09:07:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS7T4-0000Lq-JA
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 09:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbXCPIGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 04:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbXCPIGk
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 04:06:40 -0400
Received: from main.gmane.org ([80.91.229.2]:51725 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083AbXCPIGi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 04:06:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HS7SO-0001sc-Tt
	for git@vger.kernel.org; Fri, 16 Mar 2007 09:06:36 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Mar 2007 09:06:36 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Mar 2007 09:06:36 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42333>

"Shawn O. Pearce" wrote:
> "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
> >     o Avoid dying when a function call fails (eg, malloc())
> 
> malloc is a huge problem in the Git code today.  Almost all
> of our malloc calls are actually through the xmalloc wrapper.
> All xmalloc callers assume xmalloc will *never* fail.  This
> makes it, uh, interesting.  ;-)

You could think about longjmp(3)ing out into main(), which would have to
setjmp(3). But in order to clean up intermediate frames, you would have
to have a stack of setjmp/longjmp buffers.

Oh, well, how do I *love* them C++ exceptions!

-- Hannes
