From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Support tags in uncommit - use git_id instead of
	rev_parse
Date: Wed, 03 Oct 2007 17:44:52 -0400
Message-ID: <1191447892.31052.5.camel@dv>
References: <20070930172647.18972.49369.stgit@tt.roinet.com>
	 <b0943d9e0710011500o1bd621a4q10dfe0468c8795e2@mail.gmail.com>
	 <1191362591.26879.3.camel@dv>
	 <b0943d9e0710031335o1c7f3a10i6f2055b76376bfd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 23:46:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdC2R-0007LH-2v
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 23:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbXJCVpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 17:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755242AbXJCVpi
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 17:45:38 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:45403 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661AbXJCVph (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 17:45:37 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1IdC1M-0006sS-VY
	for git@vger.kernel.org; Wed, 03 Oct 2007 17:44:45 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1IdC1V-00089S-30; Wed, 03 Oct 2007 17:44:53 -0400
In-Reply-To: <b0943d9e0710031335o1c7f3a10i6f2055b76376bfd4@mail.gmail.com>
X-Mailer: Evolution 2.10.3 (2.10.3-4.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59895>

On Wed, 2007-10-03 at 21:35 +0100, Catalin Marinas wrote:

> Without this patch, the 'stg uncommit -t patch' fails with 'Unknown
> revision: patch'. With the patch applied, it still fails but with
> 'Commit ... does not have exactly one parent'. I don't say that the
> first one is good but I don't think the latter is clearer. The 'stg
> uncommit --help' states that the '--to' option takes a commit argument
> but if one passes a patch name the error message gets pretty
> confusing.

Actually, 'Commit ... does not have exactly one parent' means that stg
misinterpreted the patch name as some non-existing hash and started
iterating back until it hit the first merge.

Perhaps stgit should make sure that the hash is valid before walking the
commit tree.  If it's not, stgit could provide a better message.

-- 
Regards,
Pavel Roskin
