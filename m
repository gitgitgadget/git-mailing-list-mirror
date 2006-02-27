From: Andrew Morton <akpm@osdl.org>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 15:37:02 -0800
Message-ID: <20060227153702.375db751.akpm@osdl.org>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	<20060225210712.29b30f59.akpm@osdl.org>
	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	<20060226103604.2d97696c.akpm@osdl.org>
	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
	<20060226202617.GH7851@redhat.com>
	<1141008633.7593.13.camel@homer>
	<Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060227011832.78359f0a.akpm@osdl.org>
	<7vhd6kxuea.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 00:38:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDrwT-0008Ck-5w
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 00:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbWB0XiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 18:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWB0XiH
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 18:38:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751653AbWB0XiG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 18:38:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1RNc1DZ018177
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Feb 2006 15:38:01 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k1RNc0be016797;
	Mon, 27 Feb 2006 15:38:00 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd6kxuea.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16894>

Junio C Hamano <junkio@cox.net> wrote:
>
> tell the higher echelon folks
>  to do:
> 
>  	$ git repo-config apply.whitespace error
> 
>  in their repositories

That might be reasonable, some might object to tiny amounts of extra work..

In my setup, trailing whitespace purely causes warnings.  But with a
quilt-style thing, it's trivial to unapply the patch, strip it, reapply.

git is different - I'd imagine that if warnings were generated while an
mbox was being applied, it's too much hassle to go and unapply the mbox,
fix the diffs up and then apply the mbox again.

I'd suggest that git have options to a) generate trailing-whitespace
warnings, b) generate trailing-whitespace errors and c) strip trailing
whitespace while applying.   And that the as-shipped default be a).
