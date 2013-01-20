From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] am: invoke perl's strftime in C locale
Date: Sun, 20 Jan 2013 09:47:22 -0800
Message-ID: <7vvcarn3v9.fsf@alter.siamese.dyndns.org>
References: <20130114205933.GA25947@altlinux.org>
 <20130115155953.GB21815@sigill.intra.peff.net>
 <CALWbr2w+q5=Z8__g+J_s2NtTMgziHrntFqsi8vCJyvfO2qi81A@mail.gmail.com>
 <20130115165058.GA29301@sigill.intra.peff.net>
 <20130115174015.GA7471@altlinux.org> <20130115190517.GB7963@altlinux.org>
 <7vehhiqlcx.fsf@alter.siamese.dyndns.org>
 <20130119202853.GD1652@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Antoine Pelisse <apelisse@gmail.com>,
	git@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 18:47:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twyzi-0004zZ-SY
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 18:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437Ab3ATRr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 12:47:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41052 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380Ab3ATRrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 12:47:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CAA7B59F;
	Sun, 20 Jan 2013 12:47:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wlAQJ2P8S/Dz1LUMCY22Sm86LDw=; b=IemBdD
	rW9Nwcy7CpMqNtBXv52KoffAa27lhWILsRCE4rZZvVCM12CVsRR/ISEEOZ/kzoDe
	VRk+fACmsMVFt//eXnk5qKARAoRUgKypCwFJUp5rKFFSmLrxWFzZNKeoQbKrQaqe
	6k2CUiNkZAlYIX/OHc9p3TMPTjRneTEK33nXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J3UgzQwSiCFPdzG0MPWjeJ1SVKE3E0lA
	y0AVc/lrvrMCH1sfv6t0Nso1stMijLrpAdzv7ktfwVMeYz1qRgTLYVt3otgCm/0e
	77uJtS60Sxd8sOrnY1oV4hYuf4t+sQmniqqgXjCE9LH8ZrVWiFS+lplqtl9rF8sB
	AfaJFzvwVJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40DA0B59E;
	Sun, 20 Jan 2013 12:47:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9D52B59C; Sun, 20 Jan 2013
 12:47:23 -0500 (EST)
In-Reply-To: <20130119202853.GD1652@altlinux.org> (Dmitry V. Levin's message
 of "Sun, 20 Jan 2013 00:28:53 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7261AA98-6329-11E2-A341-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214024>

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> Personally I prefer 2nd edition that is simpler and does the right thing
> (not that LC_ALL=C is necessary and sufficient, you neither need to add
> things like LANG=C nor can relax it to LC_TIME=C).

I guess everybody involved is in agreement, then.

Just FYI, "LC_ALL=C LANG=C" comes from the inertia dating back when
not everybody understood LC_*; I do not personally know of a system
that will be helped by the extra LANG=C these days, but I know it
will not hurt anybody, so...
