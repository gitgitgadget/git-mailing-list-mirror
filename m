From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow local branching to set up rebase by default.
Date: Thu, 08 May 2008 11:23:39 -0700
Message-ID: <7v1w4cd590.fsf@gitster.siamese.dyndns.org>
References: <1209502182-39800-1-git-send-email-dustin@spy.net>
 <7vprrycce9.fsf@gitster.siamese.dyndns.org>
 <585390AA-289C-4B2F-B851-DD383C6C7A73@spy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dustin Sallings <dustin@spy.net>
X-From: git-owner@vger.kernel.org Thu May 08 20:24:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuAnG-0005iD-4H
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 20:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761431AbYEHSXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 14:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754714AbYEHSXs
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 14:23:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761431AbYEHSXq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 14:23:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6115697FA;
	Thu,  8 May 2008 14:23:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 985C597F9; Thu,  8 May 2008 14:23:41 -0400 (EDT)
In-Reply-To: <585390AA-289C-4B2F-B851-DD383C6C7A73@spy.net> (Dustin
 Sallings's message of "Thu, 8 May 2008 10:32:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E468A400-1D2B-11DD-AD55-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81548>

Dustin Sallings <dustin@spy.net> writes:

>>> +	When `never`, rebase is never automatically set to true.
>>> +	When `local`, rebase is set to true for tracked branches of
>>> +	other local branches.
>>> +	When `remote`, rebase is set to true for tracked branches of
>>> +	remote branches.
>>> +	When `always`, rebase will be set to true for all tracking
>>> +	branches.
>>> +	This option defaults to never.
>>
>> How does this interact with a similarly named configuration option,
>> autosetupmerge, whose settings can be false, true, and always?
>
> 	I can direct the user to the autosetupmerge config
> documentation since it also documents the flags that override its
> behavior.  Is this  acceptable?

Oh, it was not a request to change the description quoted above but a pure
question -- asking for information.  "This new configuration variable is
orthogonal and does not interact with the autosetupmerge", "This takes
effect only the other one decides (or --track is given from the command
line) to make it track", etc.  were the expected answers.  It might not
hurt to insert "(see branch.<name>.autosetupmerge)" before the comma in
"tracks another branch," below, though...

    +branch.autosetuprebase::
    +       When a new branch is created with `git-branch` or `git-checkout`
    +       that tracks another branch, this parameter tells git to set
