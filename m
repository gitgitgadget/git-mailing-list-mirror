From: kirr@navytux.spb.ru
Subject: Re: What's cooking in git.git (Mar 2014, #04; Thu, 20)
Date: Fri, 21 Mar 2014 21:20:46 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20140321172046.GA6157@mini.zxlink>
References: <xmqq4n2sy3ux.fsf@gitster.dls.corp.google.com>
 <xmqqsiqcwlh4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 18:23:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR39z-0001KW-AG
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 18:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760950AbaCURXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 13:23:05 -0400
Received: from forward19.mail.yandex.net ([95.108.253.144]:60243 "EHLO
	forward19.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760940AbaCURXC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 13:23:02 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Mar 2014 13:23:02 EDT
Received: from smtp19.mail.yandex.net (smtp19.mail.yandex.net [95.108.252.19])
	by forward19.mail.yandex.net (Yandex) with ESMTP id E773A1125375;
	Fri, 21 Mar 2014 21:17:34 +0400 (MSK)
Received: from smtp19.mail.yandex.net (localhost [127.0.0.1])
	by smtp19.mail.yandex.net (Yandex) with ESMTP id 8CF11BE00E1;
	Fri, 21 Mar 2014 21:17:34 +0400 (MSK)
Received: from unknown (unknown [78.25.120.184])
	by smtp19.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id g5q9FnxnkX-HVTOYVo9;
	Fri, 21 Mar 2014 21:17:32 +0400
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 88d44557-96db-40a0-9e6c-ac942b31b9be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navytux.spb.ru; s=mail;
	t=1395422254; bh=S6AdFBWcXTY4WfAZJ3jguT0dL80Yeu38lZGqJ/71a/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:Organization:
	 User-Agent;
	b=AI0Y/NFSm90U0iydkIj6dPMr7MJtzvfwT4OHKVD6VMlsOjmVnOEjxf2NjLOVaLkbo
	 kCpDkPQaWgQ9YfeUbFuSihEeHs5m/dLt2VkA8KKdIJ23SI3oHudigK9W9gLpoRfm7f
	 bQibrHBIcUACRqvLekLy3H1D5gMLk3rxcJv9gPHw=
Authentication-Results: smtp19.mail.yandex.net; dkim=pass header.i=@navytux.spb.ru
Received: from kirr by mini.zxlink with local (Exim 4.82)
	(envelope-from <kirr@mini.zxlink>)
	id 1WR37e-0001na-GO; Fri, 21 Mar 2014 21:20:46 +0400
Content-Disposition: inline
In-Reply-To: <xmqqsiqcwlh4.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244704>

Junio,

On Thu, Mar 20, 2014 at 03:31:35PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Quite a few topics are still outside 'pu' and I suspect some of the
> > larger ones deserve deeper reviews to help moving them to 'next'.
> > In principle, I'd prefer to keep any large topic that touch core
> > part of the system cooking in 'next' for at least a full cycle, and
> > the sooner they get merged to 'next', the better.  Help is greatly
> > appreciated.
> > ...
> > * ks/tree-diff-nway (2014-03-04) 19 commits
> >  - combine-diff: speed it up, by using multiparent diff tree-walker directly
> >  - tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
> >  - Portable alloca for Git
> >  - tree-diff: reuse base str(buf) memory on sub-tree recursion
> >  - tree-diff: no need to call "full" diff_tree_sha1 from show_path()
> >  - tree-diff: rework diff_tree interface to be sha1 based
> >  - tree-diff: diff_tree() should now be static
> >  - tree-diff: remove special-case diff-emitting code for empty-tree cases
> >  - tree-diff: simplify tree_entry_pathcmp
> >  - tree-diff: show_path prototype is not needed anymore
> >  - tree-diff: rename compare_tree_entry -> tree_entry_pathcmp
> >  - tree-diff: move all action-taking code out of compare_tree_entry()
> >  - tree-diff: don't assume compare_tree_entry() returns -1,0,1
> >  - tree-diff: consolidate code for emitting diffs and recursion in one place
> >  - tree-diff: show_tree() is not needed
> >  - tree-diff: no need to pass match to skip_uninteresting()
> >  - tree-diff: no need to manually verify that there is no mode change for a path
> >  - combine-diff: move changed-paths scanning logic into its own function
> >  - combine-diff: move show_log_first logic/action out of paths scanning
> >
> >  Instead of running N pair-wise diff-trees when inspecting a
> >  N-parent merge, find the set of paths that were touched by walking
> >  N+1 trees in parallel.  These set of paths can then be turned into
> >  N pair-wise diff-tree results to be processed through rename
> >  detections and such.  And N=2 case nicely degenerates to the usual
> >  2-way diff-tree, which is very nice.
> 
> So I started re-reading this series, and decided that it might be
> easier to advance the topic piece-by-piece.  Will be merging up to
> "consolidate code for emitting diffs" to 'next', after tweaking that
> last commit a bit (see below).

Thanks, yes, I agree - merging it step-by-step is good approach as doing
it all at once requires more one-time effort, which is harder to do, and
otherwise the topic just stays without progress. So yes, let's do it
incrementally.


> Kirill Smelkov <kirr@mns.spb.ru> writes:
> 
> > Currently both compare_tree_entry() and show_path() invoke opt diff
> 
> s/show_path/show_entry/;

I agree, thanks for noticing.


> > callbacks (opt->add_remove() and opt->change()), and also they both have
> > code which decides whether to recurse into sub-tree, and whether to emit
> > a tree as separate entry if DIFF_OPT_TREE_IN_RECURSIVE is set.
> >
> > I.e. we have code duplication and logic scattered on two places.
> >
> > Let's consolidate it...
> > ...
> > +/* convert path, t1/t2 -> opt->diff_*() callbacks */
> > +static void emit_diff(struct diff_options *opt, struct strbuf *path,
> > +		      struct tree_desc *t1, struct tree_desc *t2)
> > +{
> > +	unsigned int mode1 = t1 ? t1->entry.mode : 0;
> > +	unsigned int mode2 = t2 ? t2->entry.mode : 0;
> > +
> > +	if (mode1 && mode2) {
> > +		opt->change(opt, mode1, mode2, t1->entry.sha1, t2->entry.sha1,
> > +			1, 1, path->buf, 0, 0);
> 
> This is not too bad per-se, but it would have been even better if
> this part was done as:
> 
> 	if (t1 && t2) {
> 		opt->change(opt, t1->entry.mode1, t1->entry.mode2,
>                 	    t1->entry.sha1, t2->entry.sha1,
> 			    1, 1, path->buf, 0, 0);
> 	}
> 
> Then we do not have to rely on an extra convention, "'mode == 0'
> means the entry is missing", in addition to what we already have,
> i.e. "t == NULL means the entry is missing".

I agree, but the reason it is done here so is to prepare for later changes in
"tree-diff: rework diff_tree() to generate diffs for multiparent cases as
well", where modes will be right-available from `struct combine_diff_path` and
would also indicate absent entries:

    -/* convert path, t1/t2 -> opt->diff_*() callbacks */
    -static void emit_diff(struct diff_options *opt, struct strbuf *path,
    -                     struct tree_desc *t1, struct tree_desc *t2)
    +/*
    + * convert path -> opt->diff_*() callbacks
    + *
    + * emits diff to first parent only, and tells diff tree-walker that we are done
    + * with p and it can be freed.
    + */
    +static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_diff_path *p)
     {
    -       unsigned int mode1 = t1 ? t1->entry.mode : 0;
    -       unsigned int mode2 = t2 ? t2->entry.mode : 0;
    -
    -       if (mode1 && mode2) {
    -               opt->change(opt, mode1, mode2, t1->entry.sha1, t2->entry.sha1,
    -                       1, 1, path->buf, 0, 0);
    +       struct combine_diff_parent *p0 = &p->parent[0];
    +       if (p->mode && p0->mode) {
    +               opt->change(opt, p0->mode, p->mode, p0->sha1, p->sha1,
    +                       1, 1, p->path, 0, 0);
            }
            else {
                    const unsigned char *sha1;
                    unsigned int mode;
                    int addremove;
     
    -               if (mode2) {
    +               if (p->mode) {
                            addremove = '+';
    -                       sha1 = t2->entry.sha1;
    -                       mode = mode2;
    +                       sha1 = p->sha1;
    +                       mode = p->mode;
                    }
                    else {
                            addremove = '-';
    -                       sha1 = t1->entry.sha1;
    -                       mode = mode1;
    +                       sha1 = p0->sha1;
    +                       mode = p0->mode;
                    }
     
    -               opt->add_remove(opt, addremove, mode, sha1, 1, path->buf, 0);
    +               opt->add_remove(opt, addremove, mode, sha1, 1, p->path, 0);
            }

    ...


So this way we are preparing the code for that big interesting patch.



> This is minor, so I will not squash such a change in while merging
> to 'next', but we may want to revisit and fix it up as a follow up
> patch once the series is settled.

I agree that this is minor, and could be reworked in-place, but
squashing it later is not applicable as the code is later removed.



> 
> > +	}
> > +	else {
> 
> Style; I've merged these two lines into one, i.e.
> 
> 	} else {
> 
> There was another instance of it in show_path(), which I also
> tweaked.

Ok and thanks,
Kirill
