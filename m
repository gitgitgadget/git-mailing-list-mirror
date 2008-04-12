From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add two core.sharedRepository options: group-readable
 and world-readable
Date: Fri, 11 Apr 2008 21:48:36 -0700
Message-ID: <7vzlrzlluj.fsf@gitster.siamese.dyndns.org>
References: <20080411140916.GA30667@zakalwe.fi>
 <7vfxtrnban.fsf@gitster.siamese.dyndns.org>
 <20080412030021.GB31039@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <shdl@zakalwe.fi>
X-From: git-owner@vger.kernel.org Sat Apr 12 06:49:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkXgE-0001lE-NT
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 06:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbYDLEsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 00:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbYDLEsu
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 00:48:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbYDLEst (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 00:48:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B9BE2D41;
	Sat, 12 Apr 2008 00:48:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 343D92D40; Sat, 12 Apr 2008 00:48:41 -0400 (EDT)
In-Reply-To: <20080412030021.GB31039@zakalwe.fi> (Heikki Orsila's message of
 "Sat, 12 Apr 2008 06:00:21 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79329>

Heikki Orsila <shdl@zakalwe.fi> writes:

> On Fri, Apr 11, 2008 at 05:53:36PM -0700, Junio C Hamano wrote:
> ...
>> For example, you may want to enforce "ug+rw,o=" in a repository.  How
>> would you do that?
>
> Isn't that PERM_GROUP? The user always keeps u+rw for oneself.

My question was about the "o=" part.  I did not see you dropping bits for
others in your patch.

And if your answer is "the user should have xx7 umask", that defeats the
whole point of your patch, as you are trying to dissociate the umask used
by the user for his usual task and enforce particular permission policy
for the repository.
