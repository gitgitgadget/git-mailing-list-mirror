From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-sh-i18n: detect and avoid broken gettext(1)
 implementation
Date: Fri, 20 Jan 2012 12:21:31 -0800
Message-ID: <7vfwfadt10.fsf@alter.siamese.dyndns.org>
References: <CALxABCZWBtgX736Acoy-CCAz8RJb0EKnHf+7g72dOdVS+BOhSw@mail.gmail.com>
 <1327063775-28420-1-git-send-email-avarab@gmail.com>
 <7vobtydu0o.fsf@alter.siamese.dyndns.org>
 <CALxABCZJATyVRf9akmfpn3WpJ8Xt80Ky0isFOTwDGpFKvFp3nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 21:21:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoKxw-0008Cq-44
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 21:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012Ab2ATUVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 15:21:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37634 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754080Ab2ATUVf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 15:21:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EA505319;
	Fri, 20 Jan 2012 15:21:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u+XMW+5nOHEebk/8cxU3y4XUnTc=; b=ppp1eu
	su0ZSAHuDS0l1GeYBu5JJEWmmgEMK3/RvSnovfx1l4p4HNhUq8IaIoxp1tbnzTcT
	xDsvcuRtyTFovCoUzaIyJAACJEgSUwWqpMzF2ewbh/1GDA0a5E6i0vU7r/Dhogru
	dut8Gd1eohOPEZHUas9BglBYMxLK2w5LPnsU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r3pWW4AVP0eBuVX8ICCxRIe3qyGLc5Ev
	Jrvf9IG33G2h1lJcCeIfUQlF8eUX/e1EbtqYVEBmt7tXPd9Dt6tMOZqIll+mMngh
	UC0YFj2wBylqXLnIhPUsAn6yb3TxVjp1dX5V+ihIHNx15POW63LipcubUtG0oz87
	4tjPurMNVHw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 557F75318;
	Fri, 20 Jan 2012 15:21:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE3735317; Fri, 20 Jan 2012
 15:21:33 -0500 (EST)
In-Reply-To: <CALxABCZJATyVRf9akmfpn3WpJ8Xt80Ky0isFOTwDGpFKvFp3nw@mail.gmail.com> (Alex
 Riesen's message of "Fri, 20 Jan 2012 21:13:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58AC5E68-43A4-11E1-BBCB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188900>

Alex Riesen <raa.lkml@gmail.com> writes:

>> ... At build time, instead
>> of, or in addition to, the $(cmd_munge_script), we could replace the
>> single @@GETTEXT_SH_SCHEME@@ token above with whatever scheme we want to
>> use to hardcode the decision we make at the compile time.
>
> I can imagine a Solaris system being upgraded to GNU gettext _after_ Git
> installation. Hardcoding the decision might break git scripts then.

Just like you would break http transport by removing libcurl after
installing Git? What else is new?
