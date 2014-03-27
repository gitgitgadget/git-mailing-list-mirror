From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] patch-id: make it stable against hunk reordering
Date: Thu, 27 Mar 2014 19:34:55 +0200
Message-ID: <20140327173455.GB2593@redhat.com>
References: <1395912239-29663-1-git-send-email-mst@redhat.com>
 <xmqqvbuzefy6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 18:36:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTEET-0003q1-GM
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 18:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141AbaC0Rgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 13:36:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39541 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755441AbaC0Rgn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 13:36:43 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2RHYWwQ005392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 27 Mar 2014 13:34:33 -0400
Received: from redhat.com (vpn1-7-130.ams2.redhat.com [10.36.7.130])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s2RHYULq007888;
	Thu, 27 Mar 2014 13:34:31 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbuzefy6.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245298>

On Thu, Mar 27, 2014 at 09:58:41AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Patch id changes if you reorder hunks in a diff.
> 
> If you reorder hunks, the patch should no longer apply [*1*], so a
> feature to make patch-id stable across such move would have no
> practical use ;-), but I am guessing you meant something else.
> 
> Perhaps this is about using "-O <orderfile>" option, even though you
> happened to have implemented the id mixing at per-hunk level?

Yes.

> 
> [Footnote]
> 
> *1* It has been a long time since I looked at the code, and I do not
> know offhand if "git apply" has such a bug not to diagnose a hunk
> for a file for an earlier part that comes later in its input stream
> after seeing another hunk for the same file as a bug. If it does
> not, perhaps we should.

Hmm you are right.
For some reason I thought that it does work.
I'll drop this part then, less code this way.

Thanks!

Any more comments before I spin v2?

-- 
MST
