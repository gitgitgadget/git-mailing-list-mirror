From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Wed, 19 Apr 2006 07:44:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604190742240.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
 <7vy7y2csv8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604181735480.3701@g5.osdl.org>
 <Pine.LNX.4.64.0604181745410.3701@g5.osdl.org> <4445F1B0.4060105@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 16:45:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWDvZ-0007MX-OD
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 16:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWDSOpG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 10:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWDSOpF
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 10:45:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24209 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750808AbWDSOpE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 10:45:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3JEivtH023544
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 19 Apr 2006 07:44:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3JEiuXb022455;
	Wed, 19 Apr 2006 07:44:57 -0700
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4445F1B0.4060105@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18926>



On Wed, 19 Apr 2006, Andreas Ericsson wrote:
> 
> Except that you'll have to explicitly state HEAD:pathname:with:colon, or does
> it try finding a file with the argument verbatim first?

If you have a pathname:with:colon and you _just_ want to use it as a 
pathname, you'd do one of either:

 - use "--" to separate the pathnames from the revision info. That always 
   works.
 - even without the "--", if the first part of the pathname:with:colon (ie 
   the "pathname" part) cannot be looked up as a SHA1 tag, then the
   pathname:with:colon is left alone and seen as a normal file.

So "--" is always the dis-ambiguator. But it almost certainly will never 
be needed.

		Linus
