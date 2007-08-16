From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] Fix an unitialized pointer in merge-recursive.c
Date: Thu, 16 Aug 2007 15:16:08 +0200
Message-ID: <87ps1nwrfr.fsf@mid.deneb.enyo.de>
References: <e5bfff550708160100t5aa93430x6cbe83e6e7a61d73@mail.gmail.com>
	<7vsl6jkila.fsf@gitster.siamese.dyndns.org>
	<e5bfff550708160111n66b5ea94k26cf2fecc06fd84c@mail.gmail.com>
	<7vodh7khuo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 15:16:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILfD1-0007hS-5X
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 15:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbXHPNQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 09:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757410AbXHPNQN
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 09:16:13 -0400
Received: from mail.enyo.de ([212.9.189.167]:2894 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757395AbXHPNQM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 09:16:12 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1ILfCr-0005HL-NH
	for git@vger.kernel.org; Thu, 16 Aug 2007 15:16:09 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1ILfCq-00048H-FH
	for git@vger.kernel.org; Thu, 16 Aug 2007 15:16:08 +0200
In-Reply-To: <7vodh7khuo.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 16 Aug 2007 01:23:59 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56014>

* Junio C. Hamano:

> Third option.  Change the assignment from "mrtree = NULL" to
> "mrtree = mtree".  It is a standard idiom to work around stupid
> gcc warnings.

Is it?  It's also undefined according to the C standard.  In other
words, the compiler may assume that this particular declaration is
never reached.
