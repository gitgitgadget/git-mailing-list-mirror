From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix "Use of uninitialized value" error
 in 'history' view
Date: Sat, 05 Apr 2008 00:51:51 -0700
Message-ID: <7v63uwyc14.fsf@gitster.siamese.dyndns.org>
References: <200804041623.44595.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 05 09:52:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ji3Cn-00063x-UO
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 09:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbYDEHwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 03:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbYDEHwD
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 03:52:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbYDEHwB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 03:52:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F3E330FC;
	Sat,  5 Apr 2008 03:51:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C28B130FB; Sat,  5 Apr 2008 03:51:55 -0400 (EDT)
In-Reply-To: <200804041623.44595.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 4 Apr 2008 15:23:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78841>

Jakub Narebski <jnareb@gmail.com> writes:

> When asked for history of a file with no $hash ('h') parameter set,
> and which file is not present in current branch ("HEAD" or given by
> $hash_hase ('hb') parameter), but is present deeper in the full
> history of a branch, gitweb would spew multiple of "Use of
> uninitialized value" warnings, and some links would be missing.
> This commit fixes this bug.

Thanks, does gitweb itself generate such a link?

I can _artificially_ reproduce this, and I can also see that the patch
would solve it, so I do not mind applying it, but I am curious how this
was originally triggered.
