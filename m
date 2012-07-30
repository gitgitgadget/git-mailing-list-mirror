From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A new way to get a sha1?
Date: Mon, 30 Jul 2012 08:45:26 -0700
Message-ID: <7vipd5s161.fsf@alter.siamese.dyndns.org>
References: <jv5tln$96e$1@dough.gmane.org>
 <alpine.LNX.2.01.1207301426090.25013@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Badie <thomas.badie@gmail.com>, git@vger.kernel.org
To: Jan Engelhardt <jengelh@inai.de>
X-From: git-owner@vger.kernel.org Mon Jul 30 17:45:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvsAG-0000Qa-Qb
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 17:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab2G3Ppm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 11:45:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57503 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263Ab2G3Pp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 11:45:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D525D8E9B;
	Mon, 30 Jul 2012 11:45:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4kfwWfnqkkPAnawfEUgJX9FtuZU=; b=FIH/z5
	X4Hl6dXLgxaD3OYgfNwQ2K7118nVZkYBIdupU2sKoa/KU1THyVlA6mJ+QbWFfjd3
	h3et9Jy/ZiCHYxSILIpQfNDOwF3bNYxmfWjwz84mlrlRpYFdHcqU8Zr4tVZxqofr
	r4PX2ydLJ4fTWzUJL+fBNmumH+6ohn64XnDDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jILBYCtAFRshbVJE/GWL5UgfztTSUp+D
	pRiWAq1AGAfz3oyJxxoyuzTkGbNDGO936TtinoA0v13p6R8jN9LTZqDeR1z6Ch90
	h84YB4fJsd8mnW58oGZ/Y04YAiegWYaOZXgkZvAH3+bYqk1xOdJsLSMhwChehS97
	1p+wO5ibIA0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C25708E92;
	Mon, 30 Jul 2012 11:45:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40E628E91; Mon, 30 Jul 2012
 11:45:28 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.01.1207301426090.25013@frira.zrqbmnf.qr> (Jan
 Engelhardt's message of "Mon, 30 Jul 2012 14:28:36 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96172E5E-DA5D-11E1-86EA-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202567>

Jan Engelhardt <jengelh@inai.de> writes:

> On Monday 2012-07-30 14:11, Thomas Badie wrote:
>
>>Hi all,
>>
>>When I should fixup or squash a commit, I nearly never
>>remember how to get the sha1 of the commit I want to fixup.
>>Because sometimes HEAD~n is not enough, I make `git log`,
>>copy the sha1 of the right commit and paste it in my git
>>fixup command. So I wrote a perl script to avoid the usage
>>of the mouse.
>
> If you use screen(1), you can use the keyboard as well; it offers ^A [ 
> and ^A ] for copy, and then paste. tmux and all those screen clones 
> probably have something similar. Maybe ratpoison-like WMs do as well.
> Or, you can use `git log --oneline`, look for the commit and then
> type the (usually) 6-char part of the hash manually, which may be faster 
> than ^A[, moving the cursor to the copy position, marking it, etc.

Also,

	git show -s ':/^t1100-.*: Fix an interm'

would work well.  It your log messages are not descriptive enough,
however, that may not, but that is easily fixable by training you
and your colleages to give a more descriptive title to each commit,
which will make your project better.
