From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Untracked working tree files
Date: Wed, 15 Oct 2008 12:24:07 -0700
Message-ID: <20081015122407.f06e8f53.akpm@linux-foundation.org>
References: <20081015115654.fb34438f.akpm@linux-foundation.org>
	<alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm>
	<alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Wed Oct 15 21:25:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqBzv-0007Rv-P9
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 21:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbYJOTYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 15:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbYJOTYU
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 15:24:20 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46243 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752694AbYJOTYU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 15:24:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FJO7Ue004826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 15 Oct 2008 12:24:08 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m9FJO7FF025725;
	Wed, 15 Oct 2008 12:24:07 -0700
In-Reply-To: <alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.869 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98301>

On Wed, 15 Oct 2008 12:14:34 -0700 (PDT)
david@lang.hm wrote:

> On Wed, 15 Oct 2008, david@lang.hm wrote:
> 
> > On Wed, 15 Oct 2008, Andrew Morton wrote:
> >
> >> Date: Wed, 15 Oct 2008 11:56:54 -0700
> >> From: Andrew Morton <akpm@linux-foundation.org>
> >> To: git@vger.kernel.org
> >> Subject: Untracked working tree files
> >> 
> >> I often get this (running git 1.5.6.rc0 presently):
> >> 
> >> y:/usr/src/git26> git-checkout linux-next
> >> error: Untracked working tree file 'arch/x86/kernel/apic.c' would be 
> >> overwritten by merge.
> >> 
> >> which screws things up.  I fix it by removing the offending file, which
> >> gets irritating because git bails out after the first such instance, so
> >> I need to rerun git-checkout once per file (there are sometimes tens of 
> >> them).
> >
> > what I do when I run into this is "git reset --hard HEAD" which makes all 
> > files in the working directory match HEAD, and then I can do the other 
> > checkout.

I was using this but it seems it wasn't in the right place in the script.


> I think you can also do git checkout -f head to force the checkout to 
> overwrite all files

OK, I'll try that.

> the fact that git will happily leave modified things in the working 
> directory appears to be very helpful for some developers, but it's also a 
> big land mine for others.

These files weren't modified.  By me, at least.  git might have
"modified" them, but it has all the info necessary to know that the
file has no uncommitted changes.

> is there a way to disable this?
> 
> David Lang
