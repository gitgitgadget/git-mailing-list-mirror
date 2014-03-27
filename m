From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] patch-id: make it stable against hunk reordering
Date: Thu, 27 Mar 2014 20:39:17 +0200
Message-ID: <20140327183917.GA3980@redhat.com>
References: <1395912239-29663-1-git-send-email-mst@redhat.com>
 <xmqqvbuzefy6.fsf@gitster.dls.corp.google.com>
 <20140327175746.GA3853@redhat.com>
 <xmqqfvm3ecxp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 19:39:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFCo-0004by-RY
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756819AbaC0SjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:39:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37644 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754922AbaC0SjE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 14:39:04 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2RIctBW022692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 27 Mar 2014 14:38:55 -0400
Received: from redhat.com (vpn1-7-130.ams2.redhat.com [10.36.7.130])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s2RIcq2Z003630;
	Thu, 27 Mar 2014 14:38:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfvm3ecxp.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245304>

On Thu, Mar 27, 2014 at 11:03:46AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > I started to remove that code, but then I recalled why I did it like
> > this.  There is a good reason.  Yes, you can't simply reorder hunks just
> > like this.  But you can get the same effect by prefixing the header:
> 
> Yes, that is one of the things I personally have on the chopping
> block.  Having to deal with more than occurrences of the same
> pathname in the input made things in builtin/apply.c unnecessarily
> complex and I do not see a real gain for being able to concatenate
> two patches and feed it into a single "git apply" invocation.

Well - I expect that this will surprise some people: gnu
patch accepts this, and it's a natural assumption
that it works. There could be tools producing such diffs, too.

Anyway - we can drop this from patch-id and git apply at
the same time?

-- 
MST
