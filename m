From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v8 4/4] git-rebase: add keep_empty flag
Date: Wed, 25 Apr 2012 06:38:28 -0400
Message-ID: <20120425103828.GA18895@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334932577-31232-1-git-send-email-nhorman@tuxdriver.com>
 <1334932577-31232-5-git-send-email-nhorman@tuxdriver.com>
 <xmqqipgoeewl.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 12:38:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMzcZ-0006my-5f
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 12:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758119Ab2DYKin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 06:38:43 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:37948 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756970Ab2DYKim (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 06:38:42 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SMzcD-0004oE-TD; Wed, 25 Apr 2012 06:38:36 -0400
Content-Disposition: inline
In-Reply-To: <xmqqipgoeewl.fsf@junio.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196304>

On Tue, Apr 24, 2012 at 06:50:26PM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > Add a command line switch to git-rebase to allow a user the ability to specify
> > that they want to keep any commits in a series that are empty.
> > ...
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 5812222..ef263e0 100644
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -167,6 +167,15 @@ has_action () {
> >  	sane_grep '^[^#]' "$1" >/dev/null
> >  }
> >  
> > +is_empty_commit() {
> > +	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null ||
> > +		die "$1: not a commit that can be picked")
> > +	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null ||
> > +		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904)
> > +
> > +	return test "$tree" = "$ptree"
> > +}
> 
> I've amended the above and removed "return " from the last line.
> 
> The series is now in 'next', so if we need further enhancement or fixup,
> they need to come as incremental updates, not as replacements.
> 
> Thanks.
> 
Fastastic, thank you!
Neil
