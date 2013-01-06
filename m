From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] git-fast-import(1): reorganise options
Date: Sun, 6 Jan 2013 14:28:25 +0000
Message-ID: <20130106142825.GH6440@serenity.lan>
References: <20130105164415.39B144044B@snark.thyrsus.com>
 <20130105231151.GD3247@elie.Belkin>
 <7vy5g6okdi.fsf@alter.siamese.dyndns.org>
 <20130106132915.GG6440@serenity.lan>
 <20130106135109.GF22081@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org,
	David Michael Barr <b@rr-dav.id.au>,
	Pete Wyckoff <pw@padd.com>, Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 15:29:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrrDh-0002HS-7Q
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 15:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003Ab3AFO2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 09:28:43 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:45642 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755982Ab3AFO2l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 09:28:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 12835CDA590;
	Sun,  6 Jan 2013 14:28:41 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7jXjmU-nxEsu; Sun,  6 Jan 2013 14:28:40 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by jackal.aluminati.org (Postfix) with ESMTP id 403ACCDA520;
	Sun,  6 Jan 2013 14:28:39 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 12498276DE7;
	Sun,  6 Jan 2013 14:28:39 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W4Tb6UxMNbPA; Sun,  6 Jan 2013 14:28:38 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id 2F0C4276DE3;
	Sun,  6 Jan 2013 14:28:27 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130106135109.GF22081@elie.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212805>

On Sun, Jan 06, 2013 at 05:51:09AM -0800, Jonathan Nieder wrote:
> John Keeping wrote:
>> I left the "Semantics of execution" options with the general options
>> since I couldn't think of a sensible heading
> 
> Neat trick. :)

I took inspiration from git-pull(1), which has a few general options
followed by several "Options related to..." sections.

> [...]
> > -- <8 --
> > The options in git-fast-import(1) are not currently arranged in a
> > logical order, which has caused the '--done' options to be documented
> > twice (commit 3266de10).
> >
> > Rearrange them into logical groups under subheadings.
> 
> Nice description.
> 
> > While doing this, fix the duplicate '--done' documentation by taking the
> > best bits of each.  Also combine the descriptions of '--relative-marks'
> > and '--no-relative-marks' since they make more sense together.
> 
> I'd prefer to keep those as separate patches, if that's manageable.

I'll send a series of three patches if the discussion below seems
reasonable:

[1/3] remove duplicate '--done'
[2/3] combine --[no-]relative-marks
[3/3] reorganize options

> The organization you propose is:
> 
> 	OPTIONS
> 	-------
> 	--quiet
> 	--stats
> 	--force
> 	--cat-blob-fd
> 	--export-pack-edges
> 
> 	Options related to the input stream
> 	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 	--date-format
> 	--done
> 
> 	Options related to marks
> 	~~~~~~~~~~~~~~~~~~~~~~~~
> 	--export-marks
> 	--import-marks
> 	--import-marks-if-exists
> 	--relative-marks
> 	--no-relative-marks
> 
> 	Options for tuning
> 	~~~~~~~~~~~~~~~~~~
> 	--active-branches
> 	--big-file-threshold
> 	--depth
> 	--max-pack-size
> 
> These headings are less cryptic than the ones I proposed, which is a
> nice thing.
> 
> My only nitpicks:
> 
> I'd worry that the catch-all toplevel category would grow larger
> and larger with time, since it's the obvious place to put any new
> option.

I agree that that's a concern, perhaps '--cat-blob-fd' should be
combined with '--date-format' and '--done' into a section called
"Options for frontends" or similar?

And maybe '--export-pack-edges' can move to the performance/compression
tuning section?  I expect the interested audience would be the same.

That only leaves three options in that section, which seems more
reasonable.

> Part of what I tried to do with the proposed categorization was to
> separate options that change the semantics of the import (which one
> uses with "feature" when they are specified in the fast-import stream
> since ignoring them results in a broken import) from options that only
> change superficial aspects of the interface or the details of how the
> resulting packfiles representing the same objects get written.
>
> The phrasing of the name of the category "Options related to the input
> stream" is too broad.  All options relate to the input stream, since
> consuming an input stream and acting on it is all fast-import does.
> Something more specific than "related to" and a mention of "syntax"
> could make it clearer --- how about something like "Input Syntax
> Features"?
> 
> Likewise, lots of functionality is _related_ to marks, but the marks
> options are the options that specify marks files.  I don't know a good
> way to say that --- maybe "Location of Marks Files"?
>
> "Options for Tuning" could also be made more specific --- e.g.,
> "Performance and Compression Tuning".

I realise it's personal taste, but I like the subheadings of the form
"Options (for|related to) ...", so maybe:

Options for input stream features
Options related to marks files
Options for performance and compression tuning

Note that I chose sentence case instead of title case to be consistent
with git-pull(1).

> I like how you put important options like --force on top.  Perhaps
> the less important --quiet and --stats could be split off from that
> into a subsection like "Verbosity" to make them stand out even more.

I quite like having the verbosity options near the top since those are
the ones that are most likely to be of interest to a user, whereas the
rest are likely to be prescribed by the frontend (or only really useful
to frontend authors).


John
