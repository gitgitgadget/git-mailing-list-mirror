From: Lukas Fleischer <git@cryptocrack.de>
Subject: Re: Bisect needing to be at repo top-level?
Date: Tue, 17 Sep 2013 19:58:13 +0200
Message-ID: <20130917175813.GA14173@blizzard>
References: <CAJTo0LZ=bNNUc8O=bDDOp2vudsc_wL+-nqsXW5r1rq3H7M0e7Q@mail.gmail.com>
 <xmqqbo3rz7ca.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Burton, Ross" <ross.burton@intel.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 19:58:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLzXc-0001OK-HQ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 19:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370Ab3IQR6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 13:58:20 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:20014 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab3IQR6T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 13:58:19 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id ff3a6d63;
	TLS version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO;
	Tue, 17 Sep 2013 19:58:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqbo3rz7ca.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234896>

On Tue, Sep 17, 2013 at 10:27:49AM -0700, Junio C Hamano wrote:
> "Burton, Ross" <ross.burton@intel.com> writes:
> 
> > Why does git-bisect need to be ran from the top level of the working
> > tree?  It sources git-sh-setup.sh which sets GIT_DIR, which
> > git-bisect.sh then appears to consistently use.  Is there a reason for
> > needing to be at the top-level, or is this an old and redundant
> > message?
> 
> A wild guess.
> 
> Imagine if you start from a subdirectory foo/ but the directory did
> not exist in the older part of the history of the project.  When
> bisect needs to check out a revision that was older than the first
> revision that introduced that subdirectory, what should happen?
> Worse yet, if "foo" was a file in the older part of the history,
> what should happen?

If that is the real explanation, why do we allow running git-checkout(1)
from a subdirectory?

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
