From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 12:45:00 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005071240590.901@i5.linux-foundation.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>  <cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org>  <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org> 
 <alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org>  <n2k32541b131005071211sb2411334v4f0919abfeb4cbb7@mail.gmail.com>  <alpine.LFD.2.00.1005071213550.901@i5.linux-foundation.org> <i2i32541b131005071235z64c9de56w29a2d555cf801c9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 21:48:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATWi-0006Wi-0z
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143Ab0EGTry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 15:47:54 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53848 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754666Ab0EGTry (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 15:47:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47Jku1l016132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 May 2010 12:46:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47JkuuR007981;
	Fri, 7 May 2010 12:46:56 -0700
In-Reply-To: <i2i32541b131005071235z64c9de56w29a2d555cf801c9a@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146572>



On Fri, 7 May 2010, Avery Pennarun wrote:
> 
> 1) Whether a project has files that should be EOL-converted
> automatically (we seem to all agree that this is set in
> .gitattributes, whichever attribute is used).
> 
> 2) Whether a particular person wants those particular files to be
> EOL-converted, and what to convert them to.

So? If we were to have a .gitconfig file, then both of those things would 
just work. It's no different from Eyvind's patch, except the exact details 
on syntax (and which file to set) would differ slightly.

So it's a syntactic difference, nothing more.

That said, I don't think the extra .gitconfig is even worth it, the same 
way I do _not_ think Eyvind's extra .gitattributes things are worth it. We 
already have perfectly good .gitattributes, and the only real issue is 
that they just don't take effect in some situations where people would 
_want_ them to take effect.

So just a small semantic change to how .gitattributes crlf works would 
likely make everybody happy.

The only downside is that it _is_ a semantic change. It really would 
change existing git behavior. Now, I think most people would consider the 
change in behavior to be a clear improvement, but hey...

			Linus
