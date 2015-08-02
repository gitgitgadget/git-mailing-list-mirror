From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] notes: add notes.merge option to select default
 strategy
Date: Sun, 2 Aug 2015 04:01:23 -0400
Message-ID: <20150802080123.GA17440@flurp.local>
References: <1438384341-2688-1-git-send-email-jacob.e.keller@intel.com>
 <1438384341-2688-3-git-send-email-jacob.e.keller@intel.com>
 <CAPig+cSws1EWRTuV2D49RCyy6reeC7yJ5YiOSO4ee3S1rjdhBg@mail.gmail.com>
 <CA+P7+xpTu6eKZEBTbzR9mg4gV3zAvTOc-3PTJP6QamEO_sA1=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 10:01:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLoD9-0008TV-Td
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 10:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbbHBIBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 04:01:31 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36723 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbbHBIBa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 04:01:30 -0400
Received: by ioeg141 with SMTP id g141so120574950ioe.3
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Dfk8W42swIj1MEiVtzQO4h7tEM+wVAo0GUskS4Ubsig=;
        b=NqwWp95nE1o25/LSw+cCroxNHPm0mJoQCVIhsUxQ/Pm1pfwijygo817voR2+oqiZlv
         Hg5hwH4Ksto5/PsKR5Rarro7pVdnCcKi1hLjGyiIj5ouTkCNOkvIZVel/DiCKlcFi+VZ
         DSprEpvAUKRUBnejXlQ32keWfeoF52+t76wuTzqbWQ3Ay9guTCrh842EeN5vjp0Chz1t
         vSPDzzfClav5+9kXMxc0U2aQRshQB8Gr7p9t5bqVjho/b7n6xtE4iJECkih8Ogym8Gqk
         QHGGioY3IhUHyULtMsjOfRum/ZGIoXuuXWJXErotfZ/2vXCE5bjmKe1Lk9bjbk2/Fccz
         Aoaw==
X-Received: by 10.107.150.145 with SMTP id y139mr14294486iod.128.1438502490307;
        Sun, 02 Aug 2015 01:01:30 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id q10sm3031067ige.16.2015.08.02.01.01.29
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 02 Aug 2015 01:01:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+P7+xpTu6eKZEBTbzR9mg4gV3zAvTOc-3PTJP6QamEO_sA1=A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275130>

On Sun, Aug 02, 2015 at 12:41:08AM -0700, Jacob Keller wrote:
> On Sat, Aug 1, 2015 at 7:46 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> >>  If conflicts arise and a strategy for automatically resolving
> >> -conflicting notes (see the -s/--strategy option) is not given,
> >> -the "manual" resolver is used. This resolver checks out the
> >> -conflicting notes in a special worktree (`.git/NOTES_MERGE_WORKTREE`),
> >> -and instructs the user to manually resolve the conflicts there.
> >> -When done, the user can either finalize the merge with
> >> -'git notes merge --commit', or abort the merge with
> >> -'git notes merge --abort'.
> >> +conflicting notes (see the -s/--strategy option or notes.merge
> >> +config option) is not given, the "manual" resolver is used.
> >> +This resolver checks out the conflicting notes in a special
> >> +worktree (`.git/NOTES_MERGE_WORKTREE`), and instructs the user
> >> +to manually resolve the conflicts there. When done, the user
> >> +can either finalize the merge with 'git notes merge --commit',
> >> +or abort the merge with 'git notes merge --abort'.
> >
> > When you re-wrap the text like this, it's difficult to spot your one
> > little change in all the diff noise. For the sake of review, it's
> > often better to minimize the change, even if it leaves the text more
> > jagged than you'd like.
> 
> This results in something incredibly jagged. I can't find a good way
> to split which minimizes the change. Would a 3rd patch which just
> re-flows this be an acceptable alternative
> 
> ie: add the words in one patch then re-flow afterwards in a second
> patch with no changes?
> 
> There is no good alternative as other re-flows I tried end up looking
> way too jagged, as compared to surrounding documentation.

Don't worry too much about it. Consider it something to keep in mind for
future patches. I reviewed the change and it seemed okay. I mentioned it
because one of the goals of patch submission, in addition to making an
actual change, is to ease the review process. If Junio is okay with
accepting it as is, then it's probably not worth spending more time
trying to refine it.

Having said that, I came up with the following for those two paragraphs,
which gives a much less noisy diff and doesn't look too jagged:

--- 8< ---
 If conflicts arise and a strategy for automatically resolving
-conflicting notes (see the -s/--strategy option) is not given,
-the "manual" resolver is used. This resolver checks out the
+conflicting notes (see -s/--strategy or notes.merge configuration) is
+not given, the "manual" resolver is used. This resolver checks out the
 conflicting notes in a special worktree (`.git/NOTES_MERGE_WORKTREE`),
 and instructs the user to manually resolve the conflicts there.
 When done, the user can either finalize the merge with
--- 8< ---

...and...

--- 8< ---
 	When merging notes, resolve notes conflicts using the given
-	strategy. The following strategies are recognized: "manual"
+	strategy. Overrides the "notes.merge" configuration variable.
+	The following strategies are recognized: "manual"
 	(default), "ours", "theirs", "union" and "cat_sort_uniq".
 	See the "NOTES MERGE STRATEGIES" section below for more
 	information on each notes merge strategy.
--- 8< ---
