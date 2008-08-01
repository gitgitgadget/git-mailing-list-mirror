From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 15:27:20 -0700
Message-ID: <20080801152720.56dbff09.akpm@linux-foundation.org>
References: <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org>
	<20080801124550.26b9efc0.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
	<20080801131127.20b3acfd.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org>
	<20080801132415.0b0314e4.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
	<20080801135421.5ca0f6af.akpm@linux-foundation.org>
	<7vvdykqub6.fsf@gitster.siamese.dyndns.org>
	<20080801145804.85041bbd.akpm@linux-foundation.org>
	<20080801221539.GA8617@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, torvalds@linux-foundation.org,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:29:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP37t-00086c-6Y
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 00:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532AbYHAW2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 18:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756110AbYHAW2b
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 18:28:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53873 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755533AbYHAW2a (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 18:28:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71MRLaO012312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Aug 2008 15:27:22 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m71MRKTf006986;
	Fri, 1 Aug 2008 15:27:21 -0700
In-Reply-To: <20080801221539.GA8617@mit.edu>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.824 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91112>

On Fri, 1 Aug 2008 18:15:39 -0400 Theodore Tso <tytso@mit.edu> wrote:

> How about this as a compromise?  Git continues to store the names in
> its internal format as it always does, but there is a configuration
> option which controls whether the various Author: and Committer:
> fields when displayd by git-log are in RFC-822 format or not.  

Well I believe/expect/hope that git's name+email-address transformation
goes via a lookup in the kernel's .mailmap file.

And the existing .mailmap appears to have taken care that all the
"name" parts are in an MUA-usable form.  There are no periods or
commas.

So if everyone had a .mailmap entry then

- The Author: lines would all be MUA usable

- The Author lines would all be in their owners' preferred form.   I mean,
  converting

	"Morton, Andrew"

  into

	Morton, Andrew

  didn't improve things much.
