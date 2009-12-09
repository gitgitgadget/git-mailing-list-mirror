From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 12:38:50 +0200
Message-ID: <20091209103850.GD2977@redhat.com>
References: <20091208144740.GA30830@redhat.com> <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 11:41:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIJzJ-0007Vv-Lk
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 11:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056AbZLIKla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 05:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753986AbZLIKl3
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 05:41:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23732 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753687AbZLIKl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 05:41:29 -0500
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nB9AfYcX007732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 9 Dec 2009 05:41:34 -0500
Received: from redhat.com (vpn2-9-43.ams2.redhat.com [10.36.9.43])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id nB9AfWcf014704;
	Wed, 9 Dec 2009 05:41:33 -0500
Content-Disposition: inline
In-Reply-To: <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134956>

On Tue, Dec 08, 2009 at 12:22:59PM -0800, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Add --revisions flag to rebase, so that it can be used
> > to apply an arbitrary range of commits on top
> > of a current branch.
> 
> Many people wanted to have "pick many commits onto the current HEAD" and I
> think it would be a natural, uncontroversial and welcome addition to allow
> "git cherry-pick A..B".  In fact, historically, people who wanted to have
> "pick many commits" complained that the "rebase" interface was backwards,
> because it works in the _wrong_ direction for _their_ usecase.  Of course,
> when you _are_ rebasing a branch on top of some other branch, the way
> "rebase" currently works is the _right_ direction.
> 
> But I think it is a reasonable thing to _implement_ the feature to
> range-pick commits reusing the sequencing logic already in "rebase" and
> "rebase -i".  That essentially is what we wanted to do with "git
> sequencer" that would be a sequencing logic backend shared among rebase,
> cherry-pick, and perhaps am.
> 
> So perhaps a good way to move forward is to teach "git cherry-pick A..B"
> to be a thin wrapper that invokes a new hidden mode of operation added to
> "rebase" that is not advertised to the end user.
> 
> I would suggest calling the option to invoke that hidden mode not
> "--revisions", but "--reverse" or "--opposite" or something of that
> nature, though.  It makes "rebase" work in different direction.

cherry-pick is a binary though while rebase is a shell script.
Should I just exec git rebase? git-rebase?

-- 
MST
