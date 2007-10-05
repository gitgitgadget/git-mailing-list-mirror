From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [AGGREGATED PATCH] Fix in-place editing functions in convert.c
Date: Fri, 5 Oct 2007 12:33:42 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710051232300.23684@woody.linux-foundation.org>
References: <20071005082026.GE19879@artemis.corp>  <20071005085522.32EFF1E16E@madism.org>
  <alpine.LFD.0.999.0710050819540.23684@woody.linux-foundation.org> 
 <20071005162139.GC31413@uranus.ravnborg.org> 
 <alpine.LFD.0.999.0710050933330.23684@woody.linux-foundation.org> 
 <20071005172425.GD31413@uranus.ravnborg.org> 
 <alpine.LFD.0.999.0710051036282.23684@woody.linux-foundation.org>
 <37fcd2780710051227n96d29a9v543831ca8292c862@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 21:34:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idswo-0002dI-21
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 21:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760757AbXJETep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 15:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759733AbXJETeo
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 15:34:44 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57609 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759320AbXJETeo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2007 15:34:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l95JXhWX006924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Oct 2007 12:33:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l95JXgFq021422;
	Fri, 5 Oct 2007 12:33:42 -0700
In-Reply-To: <37fcd2780710051227n96d29a9v543831ca8292c862@mail.gmail.com>
X-Spam-Status: No, hits=-3.24 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60124>



On Fri, 5 Oct 2007, Dmitry Potapov wrote:
> 
> On the other hand, I don't see what is the problem with using C string
> routines with it. ::data() returns a pointer and :capacity () returns
> allocated size of the buffer. ::resize() changes the size of the string.
> If you need a greater allocated size, you can use ::reserve().
> Or did I miss something?

No, you didn't miss anything. Except for the fact that the original point 
was that it's just a damn lot simpler and more straightforward to code 
just using "sb->buf" for the data. IOW, go back two or three emails in the 
thread.

		Linus
