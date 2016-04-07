From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/4] builtin/interpret-trailers.c: allow -t
Date: Thu, 7 Apr 2016 20:30:34 +0300
Message-ID: <20160407202938-mutt-send-email-mst@redhat.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
 <1460042563-32741-2-git-send-email-mst@redhat.com>
 <xmqqr3eh1hq6.fsf@gitster.mtv.corp.google.com>
 <vpqtwjduymh.fsf@anie.imag.fr>
 <xmqqa8l51gae.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 19:30:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoDlY-00067P-DS
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 19:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757026AbcDGRao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 13:30:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48166 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756660AbcDGRan (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 13:30:43 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1C3564D11;
	Thu,  7 Apr 2016 17:30:37 +0000 (UTC)
Received: from redhat.com (vpn1-7-7.ams2.redhat.com [10.36.7.7])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u37HUZkX012514;
	Thu, 7 Apr 2016 13:30:36 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa8l51gae.fsf@gitster.mtv.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 07 Apr 2016 17:30:37 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290936>

On Thu, Apr 07, 2016 at 10:26:33AM -0700, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> >> I am in principle OK with the later step that teaches a single
> >> letter option to end-user facing "git am" that would be turned into
> >> "--trailer" when it calls out to "interpret-trailers" (I haven't
> >> checked if 't' is a sensible choice for that single letter option,
> >> though).
> >
> > If 'am' has -t == --trailer, I think it makes sense to have the same
> > shortcut in interpret-trailers for consistency.
> 
> It is the other way around.  "git am" may be OK with "-t" (or it may
> not--I do not know yet), but other commands that are currently
> unaware of "interpret-trailers" (cherry-pick, revert, etc.) may have
> better uses for a short-and-sweet 't'.
> 
> In the ideal future, "interpret-trailers" should not have to exist
> in the end-users' vocabulary, as all the front-line end-user facing
> programs would be aware of it.  But we are not there.
> 
> Letting it reserve a short-and-sweet 't' that allows it to dictate
> that its callers must have the same 't' is tail wagging the dog that
> I want to avoid.

It's mostly a short-cut I took by copying calls to applypatch.
Are there examples of other commands doing such transformations
on the fly?

-- 
MST
