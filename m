From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: CFT: merge-recursive in C (updated)
Date: Tue, 27 Jun 2006 12:10:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606271205130.3927@g5.osdl.org>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
 <Pine.LNX.4.64.0606271116360.3927@g5.osdl.org>
 <Pine.LNX.4.63.0606272043400.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 21:10:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvIxQ-0000ej-N0
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 21:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWF0TKi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 15:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWF0TKh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 15:10:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31635 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932534AbWF0TKg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 15:10:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5RJACnW018667
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Jun 2006 12:10:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5RJA8iX008774;
	Tue, 27 Jun 2006 12:10:09 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606272043400.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22751>



On Tue, 27 Jun 2006, Johannes Schindelin wrote:
> 
> Note that all Alex does was to translate the Python code to C. And in 
> Python, this horrible graph thing was necessary, because git is not 
> libified yet.

Ahh. I thought the Python thing used an external program to do all graph 
calculations.

One thing to look out for is (as Junio mentioned) that you do often want 
to merge things with externally controlled "history": either by having 
something like cherry-pick/rebase give fake history information, or by 
manually forcing a certain merge-base (possibly even an empty tree) in 
order to generate a merge of two unrelated histories.

> HOWEVER, I think it is a very good start. It _works_, albeit slow, and we 
> have test cases in place to make sure that our wonderful optimizations do 
> not break the tool.

Yeah, once it's all in C, it's going to be easier to move functionality 
around incrementally.

		Linus
