From: Mike Hommey <mh@glandium.org>
Subject: Re: What's cooking in git.git (Jun 2016, #04; Tue, 14)
Date: Thu, 16 Jun 2016 13:16:30 +0900
Message-ID: <20160616041630.GA32045@glandium.org>
References: <xmqqtwgv77az.fsf@gitster.mtv.corp.google.com>
 <20160615023658.GA21270@glandium.org>
 <xmqqd1ni716g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 06:31:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDOxh-0005Q1-CC
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jun 2016 06:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbcFPEbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2016 00:31:19 -0400
Received: from [31.55.44.181] ([31.55.44.181]:36568 "EHLO glandium.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750898AbcFPEbS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 00:31:18 -0400
X-Greylist: delayed 885 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jun 2016 00:31:18 EDT
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bDOjG-0008PP-Km; Thu, 16 Jun 2016 13:16:30 +0900
Content-Disposition: inline
In-Reply-To: <xmqqd1ni716g.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297408>

On Wed, Jun 15, 2016 at 11:32:39AM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > On Tue, Jun 14, 2016 at 03:08:04PM -0700, Junio C Hamano wrote:
> 
> >> * mh/connect (2016-06-06) 10 commits
> >>  - connect: [host:port] is legacy for ssh
> >> ...
> >>  - connect: document why we sometimes call get_port after get_host_and_port
> >> 
> >>  Ok, folks, is everybody happy with this version?
> >
> > $gmane/296609
> > $gmane/296610
> 
> Oh, I have seen these, and I know you two are happy.
> 
> But I am having a hard time coming up with a few-line summary for
> this topic.  I can write the beginning part, i.e. "Git-URL parsing
> routine has been rewritten", but the concluding part of the sentence
> cannot be "... has been rewritten for no good reason." if I were to
> mark the topic as "Will merge to 'next'".  The best I can come up
> with is "... has been rewritten (hopefully) without changing the
> benaviour.", but that is not a strong-enough justificaiton to make
> the change to the codebase, either.
> 
> In short, while the update may not introduce new bugs, why would we
> want to have this change in the first place?

My original motivation was to avoid having to copy code from connect.c
into git-cinnabar, which is what I'm currently doing[1]. Things derailed
a little, and we got ourselves somewhat in the middle of a refactor,
that I'm willing to push a little further (like, refactor things such
that host_end only happens once). My hope is that this makes the code
more maintainable.

Mike

1. https://github.com/glandium/git-cinnabar/blob/master/connect.c
