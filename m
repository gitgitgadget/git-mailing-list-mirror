From: "George Spelvin" <linux@horizon.com>
Subject: Re: [WARNING] Proposed future changes that are backward incompatible
Date: Fri, 27 Feb 2009 15:31:08 -0500
Message-ID: <20090227203108.10186.qmail@science.horizon.com>
References: <20090227192708.6266.qmail@science.horizon.com>
 <7v3adzk5wb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: linux@horizon.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 27 21:32:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld9Nx-0007Qn-NR
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 21:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755862AbZB0UbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 15:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758591AbZB0UbM
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 15:31:12 -0500
Received: from science.horizon.com ([192.35.100.1]:18567 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758408AbZB0UbL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 15:31:11 -0500
Received: (qmail 10187 invoked by uid 1000); 27 Feb 2009 15:31:08 -0500
In-Reply-To: <7v3adzk5wb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111708>

Junio C Hamano <gitster@pobox.com> wrote:

> "George Spelvin" <linux@horizon.com> writes:
>
> > There's one more change that was suggested that I'd like to propose:
> > - Make "git grep" search the whole repository by default; include an
> >   explicit "." path limiter to search only the current directory.
> >
> > In addition to being more consistent with other commands like "git log",
> > this saves a lot of typing working in drivers/net/usb/ if the identifier
> > you're looking for is in include/.  Typing the additional space-dot
> > is pretty trivial if you want the current directory only.
>
> I do not remember it was ever suggested, let alone coming to anything near
> consensus.

The suggestion was in <83vdsefz9j.fsf@kalahari.s2.org>, available as
http://marc.info/?l=git&m=123216049508531
but I agree that there was no consensus.  I just thought this thread was
a good place to elicit discussion, since it would be an incompatible change.

> The only way you could justify such a default change is to say:
>
>     Almost all the time, everybody wants to use this new behaviour; the
>     old behaviour is almost never useful in any situation other than a
>     narrow corner case; and if somebody wants to do such a useless thing
>     in a corner case, he can always add " ." at the end, so nothing is
>     lost.
>
> I do not think that is true for the change you are proposing here.  'He
> can always add " ." at the end' alone is not a good enough justification.

Please forgive me, I thought the above *might* be true, and wanted
to provoke discussion to see how people felt.  The "consistent with
git-log and all that stuff" argument is quite persuasive to me, but it's
a convenience feature, so it depends on how people feel.

> I however think your use case deserves to be supported, and I would not
> mind at all accepting a new "--full-tree" (or some shorter synonym) option
> if the patch is cleanly done (hint, hint).

Hint taken.  Half of the patch is available at
http://marc.info/?l=git&m=123207990016944

Is -t/--full-tree okay?  I'd rather use -a/--all, but that's taken.  -t
isn't used by grep(1) either.


> I'd rather not add this to "future changes that are backward incompatible"
> list.  It may be a useful new feature, but that is not what the topic of
> this thread is about.

Sorry for veering off on an inappropriate tangent.
