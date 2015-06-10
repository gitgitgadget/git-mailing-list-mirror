From: Bob Bell <b_git@thebellsplace.com>
Subject: Re: Using clean/smudge scripts from repository
Date: Wed, 10 Jun 2015 16:55:43 -0400
Message-ID: <20150610205542.GB5417@robin.thebellsplace.net>
References: <20150610015349.GA5417@robin.thebellsplace.net>
 <xmqq1thjoafp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 22:55:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2n2P-0006oO-Fc
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 22:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbbFJUzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 16:55:48 -0400
Received: from srv02.macroped.com ([66.85.181.99]:48543 "EHLO
	srv02.macroped.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965130AbbFJUzp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 16:55:45 -0400
Received: from c-24-218-186-205.hsd1.nh.comcast.net ([24.218.186.205]:43189 helo=robin)
	by srv01.macroped.com with esmtpa (Exim 4.85)
	(envelope-from <b_robin_bbell_robin@thebellsplace.com>)
	id 1Z2n2G-0006Z0-8T; Wed, 10 Jun 2015 16:55:44 -0400
Received: by robin (Postfix, from userid 1000)
	id 3DE5A2000B7; Wed, 10 Jun 2015 16:55:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqq1thjoafp.fsf@gitster.dls.corp.google.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.23 (2014-03-12)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv01.macroped.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thebellsplace.com
X-Get-Message-Sender-Via: srv01.macroped.com: authenticated_id: admin@thebellsplace.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271351>

On Wed, Jun 10, 2015 at 08:22:18AM -0700, Junio C Hamano wrote:
> Bob Bell <b_git@thebellsplace.com> writes:
> > Is this a proper solution, or did I just "luck out"?  Am I perhaps
> > doing something foolish?
> 
> Yes, we happen to run checkout in the index order, but that is not
> something we guarantee, so you can call yourself lucky.  You are
> being doubly lucky that nobody in your project is committing a
> malicious script in the repository.  It may also count as foolish,
> depending on how important the security is for you and how
> trustworthy your collaborators are.

Hrm, that's unfortunate.  So I gather it'll work, consistently, but
there's no guarantee that future versions of git won't break the
ordering assumption?  Is there anything available I can leverage here?
git has to at least assure that .gitattributes is checked out before the
files to which it could refer, right?

This is development in a corporate environment, and the collaborators
are trustworthy.  The alternative is to place the files on some network
share, where the same collaborators could edit it, etc.  But I was
hoping for a more self-contained solution, without such dependencies.

Thanks,
Bob
