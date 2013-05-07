From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-tree: handle directory/empty conflict correctly
Date: Mon, 06 May 2013 22:17:17 -0700
Message-ID: <7v61yvnzc2.fsf@alter.siamese.dyndns.org>
References: <CADEJa-5prhhY-fUHgkk91M8HKWRG3enODS_h7Mq0dgo7V9sYsQ@mail.gmail.com>
	<20130506133937.GB25912@serenity.lan>
	<CADEJa-5-UpkUaNQ=QResY54cH4TvXqiUSeG-jewH+n+HsZqmHA@mail.gmail.com>
	<20130506142923.GC25912@serenity.lan>
	<20130506144958.GD25912@serenity.lan>
	<20130506152054.GE25912@serenity.lan>
	<CADEJa-5M3Pe+s+Df70AN5XS6UBWHr_BW3KZ4GKHm2d_GXNG+hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Andreas Jacobsen <andreas@andreasjacobsen.com>
X-From: git-owner@vger.kernel.org Tue May 07 07:17:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZaHF-0000wC-L3
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 07:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363Ab3EGFRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 01:17:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51719 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772Ab3EGFRU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 01:17:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1CB51723C;
	Tue,  7 May 2013 05:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=giLQ0WP0VDfBjlqZwGl77+hCFDA=; b=MGUvvR
	WFOXbbRg/25Yt9FDXy3RcgpMRy3AtLRqbqskfv3HEBek3R3Aw5yQ94pUVoOm1SyJ
	Lm17YQ03S7nEBTK1EHqI90hgFlawVV5TBy1QhfK7KSO1SbwFRTeAkxDI1VEKSOnr
	7Q3QkI6s0t66c2+XRdtxai+BJSQ4KaGDSYN5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jzan5V7nFqXKxxSc+1cMOQMwsJnl5vHH
	PzCQSIN63M7Q19x9lDbjw2Kb14/XDwi2lq371Mpr/uBBnWcL8ZDvQ+pkUst1+j2/
	trXktdZCisGIU1JplIY8UN1e6fQU7BX4fuPzT7lPlWL4jFwbk0Igzv8qbqfXsfqN
	mC4ho/uNi6I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4A6F1723B;
	Tue,  7 May 2013 05:17:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3858D1723A;
	Tue,  7 May 2013 05:17:19 +0000 (UTC)
In-Reply-To: <CADEJa-5M3Pe+s+Df70AN5XS6UBWHr_BW3KZ4GKHm2d_GXNG+hA@mail.gmail.com>
	(Andreas Jacobsen's message of "Tue, 7 May 2013 06:54:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63C10B50-B6D5-11E2-8845-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223551>

Andreas Jacobsen <andreas@andreasjacobsen.com> writes:

> On 6 May 2013 17:20, John Keeping <john@keeping.me.uk> wrote:
>> Andreas, can you try this patch and see if it fixes your test case?
>
> Worked perfectly. Thank you, John :)

Thanks, both.
