From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix capitalization of "renamelimit" in docs to agree
 with code
Date: Sun, 18 Dec 2011 17:02:26 -0800
Message-ID: <7vsjkhnzkt.fsf@alter.siamese.dyndns.org>
References: <4EEE86AC.2030802@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 02:02:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcRcw-0004Ds-WB
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 02:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab1LSBCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 20:02:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37670 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033Ab1LSBC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 20:02:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD7C46F92;
	Sun, 18 Dec 2011 20:02:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z63ofnRcb1R4Yrm+4IBjTlDp3nY=; b=tgaz7N
	HlNAUT5X+mkjrcW8KktBeRRsXfpqcmjofsPg5gCVYXsG4fzKJt9uLGcBqj1Y+hLF
	1EPqALCbXfdjLAQe2wQ0dwcCtR16UgduJl9edaWPZGqug+nl6+bN+rxgMKBsdWhy
	7d0/kN7lbJh7weLbv+3dPsz8BEmJHmiSSjZ0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hoXVcN+n2R7cRK6LUzyMoINO8F84AnYH
	n8O9I8WnJIDmMul9VQMYzTl1kc0w1x/RpDVLIxdhAVNT5USKaAPSsHsxjksrpRkQ
	rO5419Tj+BFlSNuFAno2Efq1X9lXVHi6U79gJPFc5FvHkSgIhC4S/y3UqfqLAIHR
	qvs92s6QC/g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C60CF6F91;
	Sun, 18 Dec 2011 20:02:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45ED56F90; Sun, 18 Dec 2011
 20:02:28 -0500 (EST)
In-Reply-To: <4EEE86AC.2030802@pcharlan.com> (Pete Harlan's message of "Sun,
 18 Dec 2011 16:34:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F083208-29DD-11E1-BC6F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187432>

Pete Harlan <pgit@pcharlan.com> writes:

> Signed-off-by: Pete Harlan <pgit@pcharlan.com>
> ---
> The documentation and bash-completion have always capitalized
> "renamelimit" as "renameLimit".  The code has always lowercased the
> whole name.  Repair the docs.

Please don't do this.

Exactly because we treat the variable name part (and the top-level section
part of three-part names) case insensitively, the code lowercases before
comparing as an implementation detail.

However, you will be naming the same variable whether you spell it using
all lowercase, or using camelCase (i.e. it does not really matter what
case the user uses). The camelCase makes it slightly easier to see where
the word boundaries are than alllowercase, and that is why we try to use
it in our documentes, which is after all meant to be read by humans.

I would also appreciate if people tried not to overflow my mailbox with an
incorrect patch that hasn't been discussed and hasn't seen concensus on
the list that the particular change is a good thing to do, unless the
patch is about an area that I am an area expert (you can see who the area
experts are by asking "git shortlog --no-merges -n" or "git blame").

Thanks.
