Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B60261F855
	for <e@80x24.org>; Thu,  4 Aug 2016 23:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbcHDXnO (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 19:43:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59850 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964848AbcHDXnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 19:43:13 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55CFA83F3B;
	Thu,  4 Aug 2016 23:43:13 +0000 (UTC)
Received: from redhat.com (unused [10.16.197.238] (may be forged))
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u74NhBep016019;
	Thu, 4 Aug 2016 19:43:12 -0400
Date:	Fri, 5 Aug 2016 02:43:11 +0300
From:	"Michael S. Tsirkin" <mst@redhat.com>
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
Subject: Re: storing cover letter of a patch series?
Message-ID: <20160805024032-mutt-send-email-mst@kernel.org>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <xmqqh9n241el.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xq9P2NHqQe-y+2n38ZvbR74UxR0Rik=btgy=JtEoZbX2A@mail.gmail.com>
 <xmqqvbbi2jy5.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xodgeu6Vo+Rt57_iFycxkEnNjxP-TTOfY8DdXwzeVKbZg@mail.gmail.com>
 <A20C476954134C53B0D256D644B1CCC2@PhilipOakley>
 <CA+P7+xq2H-ZRix_71bQdswuEm++64ZA8FmK7J+1jhUhFeCZbgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xq2H-ZRix_71bQdswuEm++64ZA8FmK7J+1jhUhFeCZbgg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 04 Aug 2016 23:43:13 +0000 (UTC)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Sep 10, 2015 at 02:03:48PM -0700, Jacob Keller wrote:
> On Thu, Sep 10, 2015 at 1:09 PM, Philip Oakley <philipoakley@iee.org> wrote:
> > From: "Jacob Keller" <jacob.keller@gmail.com>
> >>
> >> On Thu, Sep 10, 2015 at 11:44 AM, Junio C Hamano <gitster@pobox.com>
> >> wrote:
> >>>
> >>> Jacob Keller <jacob.keller@gmail.com> writes:
> >>>
> >>>> I hadn't thought of separating the cover letter from git-send-email.
> >>>> That would be suitable for me.
> >>>
> >>>
> >>> Yeah, I said this number of times over time, and I said it once
> >>> recently in another thread, but I think it was a mistake to allow
> >>> git-send-email to drive format-patch.  It may appear that it will
> >>> make things convenient in the perfect world where no user makes
> >>> mistakes, but people are not perfect in real life.  Expecting them
> >>> to be is being naive.
> >>>
> >>
> >> Yep. I didn't even know cover-letter was an option of format-patch
> >> only thought it was in send-email.
> >>
> > Actually, the one feature I'd like (I think) is to be able to join together
> > the empty commit mechanism and the cover letter mechanism within format
> > patch so that:
> >
> > * the empty commit message would detected and automatically become the [0/N]
> > in the patch series (without need to say --cover-letter)
> >
> > * the cover letter would still have some 'template' markings to say "***
> > insert what's changed here***" or smilar (with option to exclude them).
> >
> > That way, when starting a series / branch, the first item would be to add
> > the explanatory 'empty commit' that states the requirements of what one
> > hopes to achieve (a key cover letter content), which is then followed by
> > commits that move toward that goal.
> >
> > The series can then be rebased as the user develops the code, and that cover
> > note can be edited as required during the rebase.
> >
> > When it comes time to show it to the list, the format patch will *know* from
> > the empty commit that it is the [0/N] cover letter and (perhaps -option) add
> > the appropriate markers ready for editing.

And perhaps git am could learn an option to apply 0/N
as a cover commit.

> > The user edits the cover letter with the extra 'what's changed' / interdiff
> > / whatever, and sends. sendmail barfs if the user hasn't edited the markers.
> >
> > This could also work with the sendmail patch formating (though I've never
> > used that workflow) as now the cover letter becomes automatic for the
> > upstream.
> >
> > Philip
> 
> If there was a way to store this empty commit message tagged as "cover
> letter" that could work well, though generally I prefer the
> non-fast-forward merges as this shows you where the series ended *and*
> began. It's somewhat confusing to newer users.. and this doesn't get
> rebased very well either.
> 
> Some way to indicate a particular "empty" commit is actually a cover
> letter seems easy enough. This seems like the way that I was thinking.

Start the subject with "cover! "?
I have a patch that teaches git-rebase to keep empty commits
where the subject has a given prefix, that might be helpful there.


> Using "edit description" of git-branch seems also to be pretty
> effective for this, even if it doesn't get shared across remotes. (not
> really a necessary feature for what I do).
> 
> But having some way to indicate "cover letter" which gets used as the
> beginning of a log message when doing a particular "merge
> --tip-as-cover" or something like Junio suggested above seems like the
> nicest approach.
> 
> Regards,
> Jake
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
