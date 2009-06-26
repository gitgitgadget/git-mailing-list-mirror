From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Troubles when directory is replaced by symlink
Date: Fri, 26 Jun 2009 16:14:26 +0200
Message-ID: <4A44D7C2.1060706@viscovery.net>
References: <c6c947f60906042243v2e36251dn9a46343cf6b8a2f4@mail.gmail.com> <c6c947f60906090118n78d3c40fq11d1390f8776c2c0@mail.gmail.com> <20090611114846.GC4409@coredump.intra.peff.net> <861vpmkhob.fsf@broadpark.no> <885649360906241507r6ac78495s802f8b7758bcabf9@mail.gmail.com> <868wjf9lxq.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: James Pickens <jepicken@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Alexander Gladysh <agladysh@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Fri Jun 26 16:15:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKCCw-0002Om-5C
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 16:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759952AbZFZOOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 10:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759069AbZFZOOa
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 10:14:30 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42352 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758793AbZFZOO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 10:14:29 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MKCCB-00080n-5Z; Fri, 26 Jun 2009 16:14:27 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B58C14E4; Fri, 26 Jun 2009 16:14:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <868wjf9lxq.fsf@broadpark.no>
X-Spam-Score: -0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122301>

Kjetil Barvik schrieb:
> Subject: [PATCH] lstat_cache: guard against full match of length of 'name' parameter
> 
> longest_path_match() in symlinks.c does exactly what it's name says,
> but in some cases that match can be too long, since the
> has_*_leading_path() functions assumes that the match will newer be as
> long as the name string given to the function.

And these "some cases" are? When "a directory was replaced by a symlink"
("or what??" I am inclined to add). Would you please be very specific
here, perhaps with an example, so that we still know the details in 6 months.

> +test_expect_success 'checkout of master - alpha/file and beta/alpha/file should exist' '

test_expect_success 'checkout replaces symlink by directory' '

BTW, this is what the test seems to check, and it is the opposite of what
the mail's Subject says. So, which one is it?

> +
> +	git checkout master &&
> +	ls alpha/file beta/alpha/file

	git checkout master &&
	! test -h alpha &&
	test -f alpha/file &&
	test -f beta/alpha/file

-- Hannes
