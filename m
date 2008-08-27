From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Are these bugs?
Date: Wed, 27 Aug 2008 16:47:03 -0700
Message-ID: <7v1w0akolk.fsf@gitster.siamese.dyndns.org>
References: <76718490808271636i4de8f385pdaeb1672f06a00d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git List" <git@vger.kernel.org>
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 01:48:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYUkJ-0003Yu-VQ
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 01:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbYH0XrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 19:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756752AbYH0XrK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 19:47:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756715AbYH0XrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 19:47:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5EA086AA31;
	Wed, 27 Aug 2008 19:47:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7E0276AA30; Wed, 27 Aug 2008 19:47:05 -0400 (EDT)
In-Reply-To: <76718490808271636i4de8f385pdaeb1672f06a00d7@mail.gmail.com>
 (Jay Soffian's message of "Wed, 27 Aug 2008 19:36:47 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75F0043C-7492-11DD-8648-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93990>

"Jay Soffian" <jaysoffian@gmail.com> writes:

> I understand why "git reset" failed, but at best the error message is
> confusing to a new user.

This is in "patches welcome" category.

> 2. "git add --ignore-errors" doesn't work with ignored files:
>
> $ git add --ignore-errors foo bar

The option, IIRC, is more about filesystem errors (failure to read), not
about safety against user errors (specifying otherwise ignored paths).

If you are automating something that uses xargs to drive addition to the
index, and the feeder to xargs knows better than .gitignore files, then
probably your script should be using '-f' unconditionally.  So I do not
see why you would think #2 could be a bug.
