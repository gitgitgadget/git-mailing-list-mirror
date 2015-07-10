From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v4] notes: Allow treeish expressions as notes ref
Date: Fri, 10 Jul 2015 16:22:28 +0900
Message-ID: <20150710072228.GA5302@glandium.org>
References: <CALKQrgd_eB2ZUwUz54vW9OFOuZshvGGe9dx+suvd0=WA0OmOFQ@mail.gmail.com>
 <1436491711-19056-1-git-send-email-mh@glandium.org>
 <CALKQrgdGJy6vtBRL413bbSHSi+=KTh4Q98hpbgg29j4J191=bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jul 10 09:22:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDSdy-0002YI-3r
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 09:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbbGJHWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 03:22:42 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:39653 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbbGJHWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 03:22:41 -0400
Received: from glandium by zenigata with local (Exim 4.86_RC4)
	(envelope-from <glandium@glandium.org>)
	id 1ZDSdg-0001OJ-TZ; Fri, 10 Jul 2015 16:22:28 +0900
Content-Disposition: inline
In-Reply-To: <CALKQrgdGJy6vtBRL413bbSHSi+=KTh4Q98hpbgg29j4J191=bA@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273805>

On Fri, Jul 10, 2015 at 09:16:16AM +0200, Johan Herland wrote:
> On Fri, Jul 10, 2015 at 3:28 AM, Mike Hommey <mh@glandium.org> wrote:
> > init_notes() is the main point of entry to the notes API. It is an arbitrary
> > restriction that all it allows as input is a strict ref name, when callers
> > may want to give an arbitrary treeish.
> >
> > However, some operations that require updating the notes tree require a
> > strict ref name, because they wouldn't be able to update e.g. foo@{1}.
> >
> > So we allow treeish expressions to be used in the case the notes tree is
> > going to be used without write "permissions", and to distinguish whether
> > the notes tree is intended to be used for reads only, or will be updated,
> > a flag is added.
> >
> > This has the side effect of enabling the use of treeish as notes refs in
> > commands allowing them, e.g. git log --notes=foo@{1}.
> 
> Looks good. However, on a second pass I noticed that the patch comes
> with no tests. I'd like at least a couple of tests thrown in there to verify
> correctness; e.g. reading notes from refs/notes/commits^{tree} shall
> succeed, and trying to write notes to refs/notes/commits^{tree} shall fail.

Fair enough. Will update.

Mike
