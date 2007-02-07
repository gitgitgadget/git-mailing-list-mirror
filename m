From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git log filtering
Date: Wed, 7 Feb 2007 13:53:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702071334060.8424@woody.linux-foundation.org>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
 <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64ad7l12.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org>
 <7vps8l65fh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Don Zickus <dzickus@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 22:54:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEujd-0007oc-TA
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 22:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161448AbXBGVx1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 16:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161447AbXBGVx1
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 16:53:27 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39849 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161448AbXBGVx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 16:53:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l17LrJdD021155
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Feb 2007 13:53:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l17LrIOE028320;
	Wed, 7 Feb 2007 13:53:18 -0800
In-Reply-To: <7vps8l65fh.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.447 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.113__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38978>



On Wed, 7 Feb 2007, Junio C Hamano wrote:
> 
> We could go pcre and let you say "(?i)".  That would all be post
> 1.5.0, though.

Hmm. PCRE is probably wide-spread enough that it could be an option. 

What's PCRE performance like? I'd hate to make "git grep" slower, and it 
would be stupid and confusing to use two different regex libraries..

Maybe somebody could test - afaik, PCRE has a regex-compatible (from a API 
standpoint, not from a regex standpoint!) wrapper thing, and it might be 
interesting to hear if doing "git grep" is slower or faster..

(I realize that the performance thing depends heavily on the patterns and 
the working set they are used on, but I guess _I_ personally only care 
about fairly simple patterns on the kernel ;)

		Linus
