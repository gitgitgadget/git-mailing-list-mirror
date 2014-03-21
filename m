From: Jeff King <peff@peff.net>
Subject: Re: [RFC] [GSoC] Draft of Proposal for GSoC
Date: Fri, 21 Mar 2014 01:42:08 -0400
Message-ID: <20140321054208.GA31737@sigill.intra.peff.net>
References: <CAM+=D-BWCt9kNSUUQ19ZcPykb6j-tuEr=igBz0ukEk2TA3vWkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Brian Bourn <ba.bourn@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 06:42:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQsDg-0003dZ-Co
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 06:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbaCUFmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 01:42:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:43806 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753573AbaCUFmK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 01:42:10 -0400
Received: (qmail 15011 invoked by uid 102); 21 Mar 2014 05:42:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Mar 2014 00:42:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Mar 2014 01:42:08 -0400
Content-Disposition: inline
In-Reply-To: <CAM+=D-BWCt9kNSUUQ19ZcPykb6j-tuEr=igBz0ukEk2TA3vWkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244642>

On Thu, Mar 20, 2014 at 02:15:29PM -0400, Brian Bourn wrote:

> Going through the annals of the listserve thus far I've found a few
> discussions which provide some insight towards this process as well as
> some experimental patches that never seem to have made it
> through[1][2][3][4]

Reading the past work in this area is a good way to get familiar with
it. It looks like most of the features discussed in the threads you link
have been implemented. The one exception seems to be negative patterns.
I think that would be a good feature to build on top of the unified
implementation, once all three commands are using it.

> I would start by beginning a deprecation plan for git branch -l very
> similar to the one Junio presents in [5], moving -create-reflog to -g,

That makes sense. I hadn't really considered "-l" as another point of
inconsistency between the commands, but it definitely is.

> Following this I would begin the real work of the project which would
> involve moving the following flag operations into a standard library
> say 'list-options.h'
> 
> --contains [6]
> --merged [7]
> --no-merged[8]
> --format
> This Library would build these options for later interpretation by parse_options

Can you sketch out what the API would look like for this unified
library? What calls would the 3 programs need to make into it?

> For the most part I haven't finalized my weekly schedule but a basic
> breakdown would be

Can you go into more detail here? Remember that writing code is only one
part of the project. You'll need to be submitting your work, getting
review and feedback, and iterating on it.

One problem that students have is queuing up a large amount of work to
send to the list. Then they twiddle their thumbs waiting for review to
come back (which takes a long time, because they just dumped a large
body of work on the reviewers). If you want to make effective use of
your time, it helps to try to break tasks down into smaller chunks, and
think about the dependencies between the chunks. When one chunk is in
review, you can be designing and coding on another.

> Additionally I am thinking about adding some more formatting tools
> such as numbering outputs. What do you all think of this?

Something like numbering might make sense as part of the formatting code
(e.g., a new placeholder that expands to "n" for the nth line of
output). I think that would be fairly straightforward, but again, it
makes sense to me to unify the implementations first, and then we can
build new features on top.

-Peff
