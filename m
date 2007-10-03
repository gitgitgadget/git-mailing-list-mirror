From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] diffcore-rename: cache file deltas
Date: Tue, 2 Oct 2007 18:36:50 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710021832520.3579@woody.linux-foundation.org>
References: <20070925192941.GA8564@coredump.intra.peff.net>
 <7vy7eu4eos.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 03:37:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IctBB-0008Gx-W6
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 03:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551AbXJCBh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 21:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbXJCBh3
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 21:37:29 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59158 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753486AbXJCBh2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2007 21:37:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l931apMf018811
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Oct 2007 18:36:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l931aoJt032358;
	Tue, 2 Oct 2007 18:36:51 -0700
In-Reply-To: <7vy7eu4eos.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-4.747 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.46__
X-MIMEDefang-Filter: lf$Revision: 1.187 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59767>



On Tue, 25 Sep 2007, Junio C Hamano wrote:
> >
> >  - the name diff_free_filespec_data_large is horrible, but this is based
> >    on the fact that diff_free_filespec_data actually does too much (it
> >    frees the data _and_ some other auxiliary data). And renaming that
> >    would entail changing many callsites.
> 
> True.  But we can rename it to diff_file_filespec_blob() and
> that would perfectly well describe what it does.  Will do so
> when applying if it is Ok to you.

Well, that renaming apparently never happened, and it's still called 
diff_free_filespec_data_large() now that it's in master.

That said, I think this patch should make it into the maintenance branch 
too, renamed or not, since it's such a huge performance issue.

			Linus
