From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git fetch -v not at all verbose?
Date: Thu, 21 Jan 2010 08:57:37 -0800
Message-ID: <20100121165737.GG19078@spearce.org>
References: <20100121050850.GA18896@Knoppix> <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com> <20100121155136.17b59e8f.rctay89@gmail.com> <20100121140054.GH18213@onerussian.com> <20100121224100.624c9c9d.rctay89@gmail.com> <20100121155637.GA19078@spearce.org> <20100121160707.GA31276@glandium.org> <20100121161016.GA16300@redhat.com> <20100121161858.GC19078@spearce.org> <20100121163518.GA16466@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 17:57:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY0Lr-0004bv-PF
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 17:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849Ab0AUQ5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 11:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636Ab0AUQ5m
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 11:57:42 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:50743 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab0AUQ5k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 11:57:40 -0500
Received: by yxe17 with SMTP id 17so172874yxe.33
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 08:57:40 -0800 (PST)
Received: by 10.150.45.37 with SMTP id s37mr2342829ybs.281.1264093060261;
        Thu, 21 Jan 2010 08:57:40 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 8sm458089ywg.49.2010.01.21.08.57.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Jan 2010 08:57:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100121163518.GA16466@redhat.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137672>

"Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Jan 21, 2010 at 08:18:58AM -0800, Shawn O. Pearce wrote:
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On many of my trees (with linux kernel), git fetch is slower than git clone.
> > > Even more annoyingly, it would hang sometimes for tens of minutes without any
> > > output, even if -v is supplied.
...
> > Given the symptom, it sounds to me like your local repository
> > is some 1,000s of commits ahead of the remote repository you are
> > fetching from.  Is that true?
> 
> Hmm, no, but what is true is that I fetched several remotes
> that diverged significantly into the same local repository.
> Would that have same effect?

Yes.

> > Are you fetching from a configured remote that has tracking branches,
> > or are you fetching through a one-shot URL pasted onto the command
> > line?
> 
> Configured remote.

Hmm.  I wonder if we should try to shortcut the commit walking in
a case like this and just feed the tracking branches we already have.

-- 
Shawn.
