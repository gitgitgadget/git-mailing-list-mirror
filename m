From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc0
Date: Wed, 07 Mar 2012 22:46:47 -0800
Message-ID: <7vk42vfv3c.fsf@alter.siamese.dyndns.org>
References: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
 <20120308063054.GD7643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 07:46:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5X7m-00034z-Ss
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 07:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724Ab2CHGqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 01:46:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159Ab2CHGqt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 01:46:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2164C7CA6;
	Thu,  8 Mar 2012 01:46:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dAC6SRljKm/yplotgjAgqORZvKQ=; b=MhI78f
	5WglpAwWTGkqqIULNvwvOh4EB3qnoXpKnNjhaS/6GgCLm4mpxn4xsmPvbbbUhH+r
	6T0t/FLffT5MB1k9rAlLDoj31F5USt3n+v5ouLFl/eaBR5uFmgAUkWM5vdrBrDrg
	g9XA+54gojkZyDqy1Q/ZYnD6YBHd+UVU1uPBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZEj6RZK92AQeyTDr3K09cYUpGJnfAUZm
	xxewfGUF5gexn0hGbQavP31WHKfpx/GasK0vJcLzgPd814tXNKchILy1j8G1uCJJ
	LskxP6rg/JGrTIenBY5ULp0Gnlbb8AvtAOiR45qM7gV98qQ3PwRiSlWHx3whKFAA
	SDCSkBhPCe0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1853E7CA4;
	Thu,  8 Mar 2012 01:46:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A04117CA3; Thu,  8 Mar 2012
 01:46:48 -0500 (EST)
In-Reply-To: <20120308063054.GD7643@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 8 Mar 2012 01:30:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A9E7EA0-68EA-11E1-B531-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192527>

Jeff King <peff@peff.net> writes:

Thanks to all other points.

>>  * "git log -G" learned to pay attention to the "-i" option and can
>>    find patch hunks that introduce or remove a string that matches the
>>    given pattern ignoring the case.
>
> This didn't parse well for me. Also, it affects -S, too, doesn't it?
> Maybe:
>
>   * "git log -G" and "git log -S" learned to pay attention to the "-i"
>     option. When "-i" is given, their patterns will match
>     case-insensitively.

I was torn about this item, and indeed my earlier draft read like
yours but I removed "-S" as it felt it was more confusing than it
was worth.  The thing is that -S does not take any pattern --- it is
meant to be given a (typically a multi-line) block of text to find
where the exact block cease to exist in the file.

 * "git log -G" and "git log -S" learned to pay attention to the "-i"
   option.  With "-i", "log -G" finds patch hunks that introduce or
   remove a string that matches the given pattern ignoring the case.
   Similarly with "-i", "log -S" finds where the given block of text
   appears or disappears from the file, but this comparison is done
   case-insensitively.
