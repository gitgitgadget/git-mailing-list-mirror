From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Horrible re-packing?
Date: Mon, 5 Jun 2006 14:27:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606051424320.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606050951120.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606051140530.5498@g5.osdl.org> <Pine.LNX.4.64.0606051155000.5498@g5.osdl.org>
 <20060605211436.GA58708@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 05 23:28:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnMc6-0001M1-JS
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 23:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWFEV1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 17:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWFEV1v
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 17:27:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48263 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750904AbWFEV1u (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 17:27:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k55LRB2g011932
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Jun 2006 14:27:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k55LRAso025382;
	Mon, 5 Jun 2006 14:27:10 -0700
To: Olivier Galibert <galibert@pobox.com>
In-Reply-To: <20060605211436.GA58708@dspnet.fr.eu.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21345>



On Mon, 5 Jun 2006, Olivier Galibert wrote:
> 
> Why don't you just sort the full path+filename with a strcmp variant
> that starts by the end of the string for comparison?  May at least be
> simpler to understand.

That's actually what I was going to do, but we don't save the whole name, 
just the sorting number.

(This is actually an area where saving space is important - we can easily 
be working with hundreds of thousands or millions of objects, and we don't 
want to keep the name of each of them around).

So the suggested hash sort is designed exactly to end up approximating 
that ascii sort-from-end-of-string.

		Linus
