From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] fast-import: Stream very large blobs directly to	pack
Date: Fri, 29 Jan 2010 23:17:59 -0800
Message-ID: <7vfx5oysbc.fsf@alter.siamese.dyndns.org>
References: <20100129012350.GD20488@spearce.org>
 <7vockdjx6w.fsf@alter.siamese.dyndns.org>
 <20100129152254.GC21821@spearce.org> <20100129163838.GD21821@spearce.org>
 <m3aavwbwaz.fsf@localhost.localdomain> <20100129183024.GA22101@spearce.org>
 <4B63691F.4000507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 30 08:18:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb7ax-0001Qi-Oz
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 08:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab0A3HSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 02:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821Ab0A3HSJ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 02:18:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab0A3HSI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 02:18:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3167395C58;
	Sat, 30 Jan 2010 02:18:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TREM7UHFiUd5a+ianE9K7HykW+I=; b=HoAzdt
	uUa/j96xjPG21lPZCXHQhYbDLXXGTM26JmGOHDlVa+BhhTzgZJDsR8rwwIqT2ezV
	8ZvJHSlhgqngjVk1lJEfDd34FoI5D1kbtReBeCp9zB6dDo4BwmLlZn/sPNotUM7E
	9dyzcsE5mmnW59y3MAtWnN8dRUggdV9R4tKnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kiOYJfDGEbnVhfBtwAQFQCoHFmHOP0qw
	wGTjVG3rL8LalefOL52P/YuoXs9Hge5kVjSN9/Ap6e0Mg5YLRzxTYT+M3t1LvXkH
	q+l/P88wR0B0iNS7/thbBTkj0q5Uu5uQhl13b+MAwCOB6hm5judhcIhFw7ZVH7sR
	zJI4UHRdpEk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1BDC95C57;
	Sat, 30 Jan 2010 02:18:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C9BD95C56; Sat, 30 Jan
 2010 02:18:01 -0500 (EST)
In-Reply-To: <4B63691F.4000507@gmail.com> (A. Large Angry's message of "Fri\,
 29 Jan 2010 18\:02\:55 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9BBA4BD8-0D6F-11DF-97BA-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138457>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Shawn O. Pearce wrote:
> ...
>> Implemented as core.bigFileThreshold in this patch... but I didn't
>> document it...
>
> Bad dog! No biscuit!

:-)

Patches welcome.
