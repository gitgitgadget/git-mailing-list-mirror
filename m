From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Tue, 18 Sep 2007 14:03:39 +0200
Message-ID: <8c5c35580709180503g24ef6c5hda2877e2215ba58d@mail.gmail.com>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>
	 <11900461843997-git-send-email-hjemli@gmail.com>
	 <20070918005013.GA6368@muzzle>
	 <8c5c35580709172312w55613a1bw8cc58b200c526fab@mail.gmail.com>
	 <7v4phsxy55.fsf@gitster.siamese.dyndns.org>
	 <46EF7EA1.6020402@vilain.net> <46EF9687.6070304@vilain.net>
	 <8c5c35580709180419i4500a2d4s8a997d45dd31944e@mail.gmail.com>
	 <46EFBB9A.5070404@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Eric Wong" <normalperson@yhbt.net>,
	"Andreas Ericsson" <ae@op5.se>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Chris Shoemaker" <c.shoemaker@cox.net>, git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 14:04:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXbo8-0002YY-Vq
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 14:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693AbXIRMDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 08:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755673AbXIRMDw
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 08:03:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:58635 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755573AbXIRMDv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 08:03:51 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2390699wah
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 05:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yijDwFrMm6Y2d06mwJUaTmFwmqGR8DEIIW29TXo+j/8=;
        b=KatVWYLTTzVqD8cHPHdMKHTvlWPR2DGcYaJuyDF5myV0ofhWb2sT8Q6vBGUUkYLTO+ywGRgPYirAWMInrA6WP42dzK9TdmT+TyFa+SGE1ZZZ/3p83Ys4JEfT6AiK1Ky7VwiaFfC5KEBh1N6RGzwwypDkuebgFItxUKHCK+w6Ns8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jvfBXUwYEA8kvAPFhhuzHTKyh7u6KYVlhTmPKFhbPtyYO0m7BFPih4vZuhkHAc4UgZZUOEnuEXOZabDt9jQBoswa2wG2zPn6RIEqb3wnvFYeFeYKCpTbbeWQ1geL0NZMxmw/MwTJhTFTuB0U0p75R7tN9BJaj8oCAB2+twknyPA=
Received: by 10.115.49.16 with SMTP id b16mr4145739wak.1190117019976;
        Tue, 18 Sep 2007 05:03:39 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Tue, 18 Sep 2007 05:03:39 -0700 (PDT)
In-Reply-To: <46EFBB9A.5070404@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58589>

[...sorry for making this such a long thread...]

On 9/18/07, Sam Vilain <sam@vilain.net> wrote:
> Lars Hjemli wrote:
> > On 9/18/07, Sam Vilain <sam@vilain.net> wrote:
> >
> >> I think that writing a real fast-forward merge should only happen on
> >> dcommit, not git merge, because that is what is required for SVN.
> >>
> >
> > I don't think git-svn has any way of knowing that the user wanted a
> > merge, unless a merge commit is present. So the user would have to
> > specify the set of commits which should be considered a merge during
> > dcommit (this would actually resemble how merges are performed in
> > subversion).
> >
>
> Sure it can.  If you're committing to branch X, and the current tree has
> a whole lot of commits above that, then it should do the only thing you
> can do with SVN.
>
> Which is write a squash commit, and set the "svn:merge" and/or
> "svk:merge" properties to represent what happened.

I often have prepared a series of local commits which I _want_ to
preserve as different subversion revisions.

Also, doing a --squash means that I loose the merge history in git
(and then I need to edit the grafts file again)

>
> > Sidenote: this might be slightly controversial, but I've sometimes
> > missed a --no-ff option to 'git merge' when working on plain git
> > repositories; IMHO preserving the 'logical' merge history when the
> > merge of a topic branch results in a fast-forward can be interesting.
>
> If you really want one, use git commit-tree directly.

Yeah, that's an option, but --no-ff is somewhat less work ;-)

--
larsh
