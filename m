From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/11] Column display
Date: Sun, 26 Feb 2012 17:37:52 -0800
Message-ID: <7v8vjpcaz3.fsf@alter.siamese.dyndns.org>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <7vaa45dwq7.fsf@alter.siamese.dyndns.org>
 <CACsJy8AyZcNSPEY8S0WczVu0ychGKr61BoBm0iy39ZsVM=zHpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 02:37:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1pXL-00010H-IT
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 02:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369Ab2B0Bhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 20:37:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab2B0Bhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 20:37:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 303EF6C3A;
	Sun, 26 Feb 2012 20:37:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3HHEX0YIuZqip0xvhyHhPSOKVjc=; b=Ov53jj
	CBQchMlLro7O0pDNMbkPQvFb1i6iCbapCUDCJ9I3IjwwW3vEV4xsIMkDN9Ljf2kE
	s4vRvyaWxVOS4lDrcWlwmE2Kpnk+8SK/W1UhcRfupcG5m32540ypNMnZXXyWP6CJ
	A++aaWyj8ksdo564XFekZs1Kx8d53yN8ZQn1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ObPgtZ4Vs0bwoQ1TaS5Yt5IASqzzlVwP
	OeL+COwLdmfL4hCyqKDpTvpayoDJZzWB5QI4+akLnCylYWgVXGGw2BWIVJBRrbyG
	V6hDsQM1DsGkH/knhxj0hp2uac/enb/wKpUHqGeinBwtrrx0310RflF1dI522flB
	/BUqH4zKkJc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28ACC6C39;
	Sun, 26 Feb 2012 20:37:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B47A76C38; Sun, 26 Feb 2012
 20:37:53 -0500 (EST)
In-Reply-To: <CACsJy8AyZcNSPEY8S0WczVu0ychGKr61BoBm0iy39ZsVM=zHpA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 27 Feb 2012 07:40:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AAD119AC-60E3-11E1-835E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191593>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> It used to be test-column. But we would need an external program to
> pipe through to minimize changing display code, especially when
> display code can get complicated (e.g. git-tag for example).

Hrm, I was hoping that we don't have to resort to a hacky implementation
like that; upload-pack/receive-pack that are not run directly by the end
users but having to be somewhere in path were bad enough, but they were
very much about git.

But at least with your series, "git column" is as invisible as git-sh-setup
and git-stripspace by being marked as purehelpers, so your patch may be
the best we could do.  I dunno.
