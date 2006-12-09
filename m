X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Documentation/git-commit.txt
Date: Sat, 09 Dec 2006 14:58:11 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612091442470.2630@xanadu.home>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612082141260.2630@xanadu.home>
 <7vpsatelvv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sat, 9 Dec 2006 19:58:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vpsatelvv.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33829>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt8Kv-0004DU-8v for gcvg-git@gmane.org; Sat, 09 Dec
 2006 20:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761864AbWLIT6O (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 14:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761863AbWLIT6O
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 14:58:14 -0500
Received: from relais.videotron.ca ([24.201.245.36]:51072 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759457AbWLIT6N (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 14:58:13 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA0006JKVGZPQ60@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Sat,
 09 Dec 2006 14:58:12 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, 8 Dec 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Frankly I feel unconfortable with this.
> >
> > 1) too many examples.
> >
> > Yes, examples are good, but somehow there is something in the current 
> > text that make me feel they are not providing the clarification they 
> > should.  Dunno... I think I'd still push them after option list.
> 
> Hmmm.  I was merely trying to respond with recent requests on
> the list (might have been #git log) to make common usage
> examples more prominent.  While I feel that following the UNIXy
> manpage tradition to push examples down is the right thing to
> do, you and I are not the primary audience of Porcelain
> manpages, so...

Sure, but sometimes too much is just as bad as not enough.  And given 
the amount of text in your version I feel the essence of the information 
gets dilluted too much.

> > 2) explanation of how to resolve and commit a conflicting merge should 
> >    really be found in git-merge.txt not in git-commit.txt.
> >
> > It feels a bit awkward to suddenly start talking about git ls-files and 
> > merge here.
> 
> I agree that it looks a bit out of place; the primary reason I
> talked about the merge was to make it clear that a conflicted
> merge will still stage the changes for cleanly auto-resolved
> paths.  In other words, it makes me feel uneasy that there is no
> mention of it in the list in your version that follows this
> sentence:
> 
> > +... All changes
> > +to be committed must be explicitly identified using one of the following
> > +methods:
> 
> It would make me happier if you had, at the end of enumeration,
> something like:
> 
> 	Note that the contents of the paths that resolved
>         cleanly by a conflicted merge are automatically staged
>         for the next commit; you still need to explicitly
>         identify what you want in the resulting commit using one
>         of the above methods before concluding the merge.

But why couldn't this be in the git-merge man page instead?  That is 
precisely the sort of addition that makes me feel like we're trying to 
say too much at the same time.  When in the context of learning how 
"commit" works, it is certainly not necessary to talk about how "merge" 
works.  That should really be mentioned in the "merging" documentation 
(with a link to git-commit for more options on commit).

> Another reason I described the merge workflow is it would become
> much less clear why --only is useless in merge situation if the
> reader does not know that a conflicted merge stages the
> auto-resolved changes.

Sure, but the whole merge concept might still not make any sense at the 
moment the user is learning about commit.  In other words, the "commit" 
documentation must not depend on the "merge" concept.  It should rather 
be the other way around, i.e. the "merge" documentation can easily 
depend on the "commit" documentation.

Just like I carefully avoided talking about "commit -a" in the git-add 
man page to avoid circular conceptual dependencies.  But obviously the 
git-commit man page must talk about the "add" concept.

This way you get a progressive knowledge base with git-add which pretty 
much stands on its own, then you move to git-commit that depends on 
git-add, then you move to merging and resolving conflicts that depend on 
git-commit.  And so without being distracted by concepts you don't need 
to know just yet along the way.


