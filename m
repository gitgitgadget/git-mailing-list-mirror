From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch 0/5] Create single PDF for all HTML files
Date: Sun, 07 Oct 2012 13:54:23 -0700
Message-ID: <7vipamoveo.fsf@alter.siamese.dyndns.org>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
 <20121006193205.GD3644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Ackermann <th.acker66@arcor.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 07 22:54:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKxrw-0008Ce-G7
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 22:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247Ab2JGUy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 16:54:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46843 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838Ab2JGUy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 16:54:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0989E95FE;
	Sun,  7 Oct 2012 16:54:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S5yuO0RLtYPhcxqEuXe36WC8djI=; b=CjUo2p
	c7m3al/PwbjP1AX38Eyf49nBsCubggjIj/mKYAAPSd82CT7PaQJlAHtQfBvRVGcJ
	mPH2lyAylqNdpd4y8WW3RvuV1x/6R/S9FHGpT/qgbM7QaM+78EvQbTdg6FRhVstV
	wJ9VUEfKRNt6uyno4N0vZWG8+1rdQkslTLNQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xL74bUjiZR2ZYuJjihuN5lmD/cQgbO+s
	YJludowsjX4ZYBWP0Vei1BkvMP39ANB06Mgx3D5XIg3kogOCDBUBIMxCX9+wDE+w
	8vRkCSfTVLn2tgClseq/C3tiRTDyF0qDzEiRxZ4mXGXafwJUJuFyHe/cubPtS3DN
	DwHDNRy+tSY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB33895FD;
	Sun,  7 Oct 2012 16:54:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 626B995FC; Sun,  7 Oct 2012
 16:54:25 -0400 (EDT)
In-Reply-To: <20121006193205.GD3644@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 6 Oct 2012 15:32:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D967B2E-10C1-11E2-8EF5-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207197>

Jeff King <peff@peff.net> writes:

> Another way of doing this would be to format the individual troff
> manpages into dvi or postscript, convert that into pdf, and then
> concatenate that. Something like:
>
>   for i in *.[157]; do
>     man -Tdvi -l "$i" >"$i.dvi"
>     dvipdfm "$i"
>   done
>   pdftk *.[157].pdf cat output full.pdf
>
> works for me, though obviously that does not handle some of the non-man
> items you included. No idea on how the output compares to yours, but
> it's something you may want to look at.

Yes, that would be far more straight-forward and less error prone
way to do this.
