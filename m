From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc0
Date: Wed, 07 Mar 2012 22:42:48 -0800
Message-ID: <7vlinbfv9z.fsf@alter.siamese.dyndns.org>
References: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
 <20120308063054.GD7643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 07:42:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5X3w-0007BW-77
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 07:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab2CHGmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 01:42:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159Ab2CHGmu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 01:42:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 977097C0D;
	Thu,  8 Mar 2012 01:42:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JcuQRdpr5kog/ivHKy77ox03VMs=; b=sOX3DT
	JfL1iUKy8VuSac+aXEtLTdpmk+tQcrV1DJWnd2HmCZmjx4Umxes+KvL3+XGIYY1k
	x3ZS6k1/FeHHWhIVUQ4DVMXG36kCJy2SvbZ8Rv/9iA70qAi1/js6mzOFhXjsdgfm
	ZTmZl9vd65i88ZOr6cwAq/xxl59ivUMvyQ4H8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RW2mdkH/c2vsMgaee1VNPR2q4xV3RMtU
	ZaAFO0jSZnGZ8to5wP+xlO8Q5qqjMr3FTvh5sDzoH5Jvy/xuJGEazOSewfV+R8TB
	Mn1Ozzxdtf4lYafpp/lS1Q1f43QC3En76Jcj319wpwkkftKk2Cb1Pn3jYoZQkayi
	WNnJpv4iIuE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E5BB7C0C;
	Thu,  8 Mar 2012 01:42:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 267EB7C0A; Thu,  8 Mar 2012
 01:42:50 -0500 (EST)
In-Reply-To: <20120308063054.GD7643@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 8 Mar 2012 01:30:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC7665B6-68E9-11E1-B75D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192526>

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
