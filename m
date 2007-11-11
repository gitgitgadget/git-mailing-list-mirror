From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Deprecate git-fetch-pack?
Date: Sat, 10 Nov 2007 16:48:29 -0800
Message-ID: <7v4pftip42.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711101752490.29952@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 01:48:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir10Q-0006G0-Ie
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 01:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847AbXKKAsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 19:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755858AbXKKAsf
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 19:48:35 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52551 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755758AbXKKAse (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 19:48:34 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 73B402F0;
	Sat, 10 Nov 2007 19:48:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 02707941DB;
	Sat, 10 Nov 2007 19:48:52 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711101752490.29952@iabervon.org> (Daniel
	Barkalow's message of "Sat, 10 Nov 2007 18:11:53 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64390>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Now that git-fetch is in C, built in, and doing the fetch-pack in the same 
> process, the normal usage patterns don't involve actually executing 
> git-fetch-pack. Can we deprecate it at this point, or it is plausibly 
> being used by scripts? As it is now, I'm not entirely confidant that the 
> tests in t5500 won't be fooled by git-fetch working even with 
> git-fetch-pack being broken in various ways, which should be fixed if we 
> want to keep it.
>
> We also might as well deprecate peek-remote now that it's a synonym for 
> ls-remote.

Especially because git-fetch is no longer as hackable as it used
to be, and because people may still find special needs that can
be hacked up with direct access to low level transports from the
script more easily than going down to the C level, I'd rather
wait and see for a cycle or two to decide.  There is no strong
reason to drop it, is there?

As to peek-remote, ls-remote over the native transport is a
synonym so I do not think anybody doing the scripting would have
problem doing s/peek-/ls-/ to their script, but again I do not
see a heavy maintenance burden to keep the synonym, yet.
