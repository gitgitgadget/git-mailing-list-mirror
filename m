From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bug: segfault during git-prune
Date: Mon, 2 Jul 2007 14:01:19 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707021356570.9434@woody.linux-foundation.org>
References: <200706281134.58453.andyparkins@gmail.com>
 <200707021100.16610.andyparkins@gmail.com>
 <alpine.LFD.0.98.0707020441460.3323@woody.linux-foundation.org>
 <200707021425.38367.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 23:01:40 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5T1c-0001Dm-LM
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 23:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbXGBVB2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 17:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754682AbXGBVB2
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 17:01:28 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41853 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754653AbXGBVB1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jul 2007 17:01:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l62L1PoR007872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Jul 2007 14:01:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l62L1JSA006909;
	Mon, 2 Jul 2007 14:01:20 -0700
In-Reply-To: <200707021425.38367.andyparkins@gmail.com>
X-Spam-Status: No, hits=-2.643 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51404>



On Mon, 2 Jul 2007, Andy Parkins wrote:
> 
> I've pushed it out as-is as a bug fix patch now; and will happilly make the 
> above change on top.  However, I've not understood what all the parameters 
> are for in the process_XXXX() functions:

Yeah, never mind, your patch is fine. The process_xxx() parameters are 
really only there so that process_tree() can generate the proper path and 
names, and they are passed to process_blob/gitlink() just to make all the 
processing look the same.

But it's nonsensical to do for the case of the index (although you could 
pass a NULL path and the name from the index), and we haven't created the 
object array there, so just ignore my suggestion - your original patch is 
fine.

		Linus
