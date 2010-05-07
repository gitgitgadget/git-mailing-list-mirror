From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 10:10:09 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> <cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 07 19:13:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAR75-0007cY-OK
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 19:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab0EGRNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 13:13:14 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56212 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753961Ab0EGRNN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 13:13:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47HC4Fq030535
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 May 2010 10:12:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47HC4iT000990;
	Fri, 7 May 2010 10:12:04 -0700
In-Reply-To: <7v4oijhdsi.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.946 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146544>



On Fri, 7 May 2010, Junio C Hamano wrote:

> Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:
> 
> > - An attribute called "auto-eol" is set in the repository to turn on
> >   normalization of line endings.  Since attributes are content, the
> >   setting is copied when the repository is cloned and can be changed in
> >   an existing repository (with a few caveats).  Setting this attribute
> >   is equivalent to setting "core.autocrlf" to "input" or "true".
> 
> In what way is this attribute different from existing "crlf" attribute?

The existing crlf attribute is a no-op _unless_ core.autocrlf is set, 
isn't it?

The whole point of Eyvind's series is to be able to set crlf attributes 
without having to set the config option - because he wants to make sure 
that a new clone always gets the proper crlf handling without users 
having to do anything extra.

And I do have to say that it makes sense.

I also do think that maybe we could just change the existing crlf 
attribute to work even without 'core.autocrlf'. 

			Linus
