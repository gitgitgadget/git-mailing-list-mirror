From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: new gitk feature
Date: Wed, 26 Apr 2006 08:09:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604260802050.3701@g5.osdl.org>
References: <17487.21137.344427.173131@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 17:09:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYle0-0008Md-6O
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 17:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWDZPJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 11:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWDZPJ2
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 11:09:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10716 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964800AbWDZPJ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Apr 2006 11:09:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3QF9PtH027729
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 26 Apr 2006 08:09:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3QF9OtD029658;
	Wed, 26 Apr 2006 08:09:25 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17487.21137.344427.173131@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19207>



On Wed, 26 Apr 2006, Paul Mackerras wrote:
>
> I just pushed some changes to gitk which add a new feature, the
> ability to have multiple "views" of a repository.  Each view is a
> subgraph of the full graph.  At the moment the only subgraph that you
> can specify is the subgraph containing the commits that affect a
> specified set of files or directories.  You can switch between views
> quickly, and if the currently selected commit exists in the new view
> when you switch views, it is selected in the new view.

This gets close to something I wanted, but at the same time falls very 
short of it because the views are always shown completely disjoint.

I've wanted for a long time to have a way to _highlight_ commits. That's 
actually very much a "view" thing, but it's a mode where you really see 
one view, but the commits that exist in another view have a different 
color (or have the commits that _don't_ exist in the other view be grayed 
out).

I hope that your new "view" thing would support this notion too: instead 
of having to totally switch between view, it would be wonderful if you 
could have one "master view" and then use another view to "highlight".

Also, I think revision information should be part of a view. For example, 
in the "highlight" case, I'd love to have the "main view" be the default 
"everything", and then have some way to _highlight_ the view that is 
defined by the revision pattern "v1.3.1.."

Any possibility of something light that? I'd _love_ to be able to see the 
whole tree, but with things that touch certain files or things that are 
newer highlighted.

(Btw, the "revision information" is also cool things like "--unpacked". I 
actually use "gitk --unpacked" every once in a while, just because it's 
such a cool way to say "show me everything I've added since I packed the 
repo last).

			Linus
