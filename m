From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix in-index merge.
Date: Sat, 23 Aug 2008 01:50:52 -0700
Message-ID: <7vd4k02jyr.fsf@gitster.siamese.dyndns.org>
References: <20080823060839.GB23800@genesis.frugalware.org>
 <1219479293-29111-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 10:52:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWoqv-0000Mf-B4
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 10:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbYHWIvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 04:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbYHWIvE
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 04:51:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbYHWIvD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 04:51:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BD02D6AAF5;
	Sat, 23 Aug 2008 04:50:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 177ED6AAF4; Sat, 23 Aug 2008 04:50:54 -0400 (EDT)
In-Reply-To: <1219479293-29111-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Sat, 23 Aug 2008 10:14:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9BB295FE-70F0-11DD-9E3F-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93443>

Miklos Vajna <vmiklos@frugalware.org> writes:

> There were 3 issues:
>
> 1) We need read_cache() before using unpack_trees().
>
> 2) commit_tree() frees the parents, so we need to malloc them.
>
> 3) The current HEAD was missing from the parent list.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Fri, Aug 22, 2008 at 08:36:39AM +0200, Paolo Bonzini <bonzini@gnu.org> wrote:
>> I had already posted this bug report yesterday but it was hidden in a
>> cover
>> letter at
>> http://permalink.gmane.org/gmane.comp.version-control.git/93143
>
> This should fix the issue.
>
>  builtin-merge.c          |   11 +++++++----
>  t/t7607-merge-inindex.sh |   29 +++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 4 deletions(-)
>  create mode 100755 t/t7607-merge-inindex.sh

Please do not add new testfiles unnecessarily.  You already have test
scripts that cover "git-merge".  Add new ones to them.  The same comment
goes to the other patch.
