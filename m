From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Wed, 25 Jun 2008 02:23:31 -0700
Message-ID: <7vr6al3m24.fsf@gitster.siamese.dyndns.org>
References: <20080624222105.GA24549@dervierte>
 <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com>
 <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 11:25:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBRFR-0007Z0-Vd
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 11:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbYFYJXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 05:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbYFYJXx
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 05:23:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbYFYJXx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 05:23:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A0D1C181DF;
	Wed, 25 Jun 2008 05:23:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B8367181DD; Wed, 25 Jun 2008 05:23:41 -0400 (EDT)
In-Reply-To: <48620C1A.6000509@panasas.com> (Boaz Harrosh's message of "Wed,
 25 Jun 2008 12:12:58 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6CA8EC9E-4298-11DD-8670-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86261>

Boaz Harrosh <bharrosh@panasas.com> writes:

> Junio C Hamano wrote:
> 
>> "reset --hard" has *ALWAYS* meant to be destructive --- discarding
>> potential local cruft is the whole point of the operation.
>
> I was under the impression that --hard means working-directory-also
> as opposed to tree-and-index-only. Nothing to do with 
> destructive-discarding.

Then you should revise your impression, as it is simply *WRONG*.  When
I say something about history of git, I know what I am talking about ;-)

Reset has been about nuking local changes from the very beginning.  That
is why it removes MERGE_HEAD, rr-cache/MERGE_RR as well as removing
conflicted stages in the index and reverts local changes from the worktree.

It is "my worktree state is a mess, and I cannot even describe nor care
which paths are dirty --- just get rid of the local changes so that I can
start working cleanly from a checkout of HEAD".
