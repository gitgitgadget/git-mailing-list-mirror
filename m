From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: epic fsck SIGSEGV! (was Recovering from epic fail (deleted
 .git/objects/pack))
Date: Wed, 10 Dec 2008 19:28:15 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812101854230.3340@localhost.localdomain>
References: <1228867861.14165.19.camel@starfruit.local> <7vd4g051ax.fsf@gitster.siamese.dyndns.org> <1228903606.4445.53.camel@starfruit.local> <493FAA5A.8070801@viscovery.net> <1228949523.27061.20.camel@starfruit.local> <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
 <alpine.LFD.2.00.0812102031440.14328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "R. Tyler Ballance" <tyler@slide.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 04:29:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAcFC-0008Tm-Fs
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 04:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbYLKD2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 22:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754461AbYLKD2Z
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 22:28:25 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39316 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754429AbYLKD2Y (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2008 22:28:24 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBB3SGpA001003
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Dec 2008 19:28:17 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBB3SF8l009134;
	Wed, 10 Dec 2008 19:28:15 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0812102031440.14328@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.426 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102770>



On Wed, 10 Dec 2008, Nicolas Pitre wrote:

> On Wed, 10 Dec 2008, Linus Torvalds wrote:
> 
> > But we should definitely fix this braindamage in fsck. Rather than 
> > recursively walk the commits, we should add them to a commit list and just 
> > walk the list iteratively.
> 
> What about:
> 
> 	http://marc.info/?l=git&m=122889563424786&w=2

Not very pretty. The basic notion is ok, but wouldn't it be nicer to at 
least use a "struct object_array" instead?

Let me try to cook something up.

		Linus
