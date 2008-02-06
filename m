From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] allow setting GIT_WORK_TREE to "no work tree"
Date: Wed, 06 Feb 2008 12:54:01 -0800
Message-ID: <7v4pclvmae.fsf@gitster.siamese.dyndns.org>
References: <20080206102608.GA1007@coredump.intra.peff.net>
	<47A98F07.4000402@viscovery.net>
	<20080206110131.GA4167@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:55:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMrIR-0004nQ-TB
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 21:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766AbYBFUye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755763AbYBFUyd
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:54:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35658 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbYBFUyd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 15:54:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FB742B3F;
	Wed,  6 Feb 2008 15:54:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F1D962B3B;
	Wed,  6 Feb 2008 15:54:23 -0500 (EST)
In-Reply-To: <20080206110131.GA4167@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 6 Feb 2008 06:01:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72853>

Jeff King <peff@peff.net> writes:

> On Wed, Feb 06, 2008 at 11:42:15AM +0100, Johannes Sixt wrote:
>
>> > The special value is a blank GIT_WORK_TREE; it could be any
>> > value, but this should not conflict with any user values
>> > (and as a bonus, you can now tell git "I don't have a work
>> > tree" with "GIT_WORK_TREE= git", though I suspect the use
>> > case for that is limited).
>> 
>> Hrm. Unfortunately, on Windows there is no such thing as an empty
>> environment string. setenv(x, "") *removes* the environment variable.
>
> Bleh. Maybe "GIT_WORK_TREE=:"? It doesn't make sense by itself since we
> don't try to execute the contents of GIT_WORK_TREE, but it's unlikely to
> be used by a user, and I believe there was recent talk of making
> "GIT_EDITOR=:" work.
>
> The other option is setting
>
>   GIT_MAGICALLY_SET_GIT_DIR_SO_DONT_ACT_LIKE_THE_USER_DID=1
>
> but I was hoping to avoid that.

Yuck.  Let's then try your original (slightly redundant) one.
