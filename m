From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Call Me Gitless
Date: Mon, 18 Aug 2008 19:12:43 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808181839390.19665@iabervon.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
 <7vtzdiklbw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:13:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVDv2-0004EF-0F
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYHRXMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbYHRXMp
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:12:45 -0400
Received: from iabervon.org ([66.92.72.58]:43827 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758AbYHRXMo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:12:44 -0400
Received: (qmail 30787 invoked by uid 1000); 18 Aug 2008 23:12:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Aug 2008 23:12:43 -0000
In-Reply-To: <7vtzdiklbw.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92753>

On Mon, 18 Aug 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > if you'd get:
> >
> > --- (index)/foo/bar
> > +++ ./foo/bar
> >
> > people would at least be clear on what information they were getting, even 
> > if they didn't know why they were getting that as opposed to a different 
> > combination.
> 
> [Removed somebody who decided not use git from CC.]
> 
> I know you mentioned this as an example of differenciating the output
> between the modes, and not as a serious suggestion.  The above may apply
> cleanly because "(index)" and "." are both one level deep, but they look
> ugly and the filenames do not align.

I actually think it would be fine; the filenames don't align, but it 
doesn't matter much because we practically never have patches where they 
aren't the same anyway (unless there are also rename headers), so there's 
no need for it to be easy to compare them visually.

> I often make a quick patch all inside the work tree, never committing, and
> then send it out by including "git diff --stat -p" output in the mail as a
> suggested patch.  If we did what you suggest, people could tell such a
> patch and a format-patch output.  I actually do like the fact that we
> consistently say "a/" vs "b/", but some people actually may prefer to see
> the difference.

You could use --src-prefix and --dest-prefix to put it back to a/ and b/ 
(or whatever else you wanted to make it look like). The opposite isn't 
really true though; while I can use --src-prefix='(index)/' 
--dest-prefix='./', I'd need to figure out per-command-line what I'm going 
to be getting, which sort of defeats the purpose.

Actually, this weekend I was trying to cherry-pick the aggregated changes 
to certain files from one branch onto another, and was repeatedly confused 
by the fact that the only available diffs are backwards and there're no 
clues in the output. (That is, you can't get the difference between (---) 
the {index,working tree} and (+++) some commit, and when you've done "git 
diff messy", the resulting diff doesn't give any clues that you're 
deciding whether to add the - lines and remove the + lines.)

	-Daniel
*This .sig left intentionally blank*
