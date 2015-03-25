From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] [PATCH] infinite loop due to broken symlink
Date: Wed, 25 Mar 2015 16:21:58 -0700
Message-ID: <xmqq1tkc1x49.fsf@gitster.dls.corp.google.com>
References: <5510399D.4020007@redhat.com> <55133C63.2010805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Petr Stodulka <pstodulk@redhat.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 26 00:22:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yauch-0001qj-8G
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 00:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbbCYXWC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 19:22:02 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751774AbbCYXWA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 19:22:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E681F43A07;
	Wed, 25 Mar 2015 19:21:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8gYj3S3dJns/9QhWpMwDOTAv1Ts=; b=Da4BAD
	+XKmcUx0Kx0qiq8+4W7fpftwrnleBoR4NruLV76BHkM3Uess+o4VTIWwzWDkSEC9
	7Q45jxRb4CWgbPcVa71dIM72aryR3yyUC2M279NCwW+DyYOxtU1tCBJzJB3MX4ll
	9c6uM5Tmj0L/LQCaZgdx82wPaFdsOKGeUBZB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aiaAkldG9u50Nhdjelgq8Bxsjsd7lx4F
	d9S8gpZh3xfZT3gj6DlKFdpZ/3Z+9f2IXTKH6SLnXsmkuuKN2iWFVpfWOQEDVPuO
	GW8YHvd85RplxOZJZhrOoxElLrwBXEJU3N0jYksWdaxrncXno4flUjC6YOmKnPSv
	huXIT1Pco94=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E021243A06;
	Wed, 25 Mar 2015 19:21:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 658FE43A05;
	Wed, 25 Mar 2015 19:21:59 -0400 (EDT)
In-Reply-To: <55133C63.2010805@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 25 Mar 2015 23:53:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC5C2CE8-D345-11E4-A3C3-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266309>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Thanks for the bug report. I can confirm the problem. In fact, I noticed
> the same problem when I was working on a refactoring in the area, but I
> still haven't submitted those patches.

Thanks.  It is nice to know that the refs.c API refactoring is still
being worked on.
