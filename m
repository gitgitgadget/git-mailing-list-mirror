From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (stable)
Date: Sun, 17 Feb 2008 17:31:05 -0800
Message-ID: <7v3arrxd7q.fsf@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
 <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
 <m3d4qvbt40.fsf@localhost.localdomain>
 <7vtzk7xqg3.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802172050090.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 02:32:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQurq-0000ve-7j
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 02:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbYBRBbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 20:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbYBRBbt
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 20:31:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60560 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbYBRBbs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 20:31:48 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AE9C76846;
	Sun, 17 Feb 2008 20:31:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 F36906845; Sun, 17 Feb 2008 20:31:38 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74213>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 17 Feb 2008, Junio C Hamano wrote:
>
>> The more fundamental improvement was along the lines of what I suggested 
>> soon after Kristian's initial round was posted, but what the current 
>> code does is not wrong nor hack.  It is about a partial commit after all 
>> and is not performance critical either.
>
> You mean: at this point, it is not necessary to be careful about the 
> index, as the index that will be reloaded will already have the most 
> recent timestamps, right?

I do not understand the question, but if you are referring to my
"not performance critical", I meant: "A partial commit is
never performance critical".

A partial commit is by its nature "oops, I earlier told you to
git add this and git add that but I did not mean that, eh, I do
mean it but not for this commit yet, sorry, I want to commit
changes to these paths first please and then I'll deal with the
earlier added paths in later commit perhaps.", i.e. very
interactive.  Its performance requirement is unlike an automated
script slurping hundreds of changes per minute applying exactly
the change it wants in each commit to the index and making
commits in rapid succession.
