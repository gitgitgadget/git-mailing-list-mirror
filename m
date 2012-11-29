From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] reset: learn to reset to tree
Date: Thu, 29 Nov 2012 11:36:45 -0800
Message-ID: <7vmwy0p5f6.fsf@alter.siamese.dyndns.org>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
 <1354213975-17866-1-git-send-email-martinvonz@gmail.com>
 <1354213975-17866-2-git-send-email-martinvonz@gmail.com>
 <7v4nk8qmaj.fsf@alter.siamese.dyndns.org>
 <CANiSa6j2sriXaGr0yH9kMrxDEvKHsjNPX_Exbc2_6ecnPYdroQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 20:37:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te9ux-00014S-Vm
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 20:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734Ab2K2Tgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 14:36:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45236 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab2K2Tgs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 14:36:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D01E9F9A;
	Thu, 29 Nov 2012 14:36:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RY5Aj/ooCIXt6YmHc9rL2Zacr7A=; b=DN/bR3
	nc6lT/yU3AzcKlPk6sxlv9La3Ys0kHyz8DlojspKKuCnvFBVpQyiGK5mcyrZtkef
	t9gK+JgEHgbN+8swTdj57yYxuOexAz0Mt6Ab3XY3zSqetlI9h6zEX8fStw5XP3Ry
	SaSF/yACxWkZ1nzknjA5rnmgkMGvZUusHnCTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q8vaaIiNhQLne5XqRokcm0Z6MmLXwiyP
	jRz5ypu4g88m1/Au/RiEYsqNQRTuiQ+hHFjFxvEBEOVrTqnbPvz1RQ7o4AcgJf1m
	SpGQx6Lf8wgCJIIMSpH32hYkuiof0/eFoWpeSriSIew6F/psePcAaueL+nCy4Sgw
	MulfdmjJz+I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED7D29F99;
	Thu, 29 Nov 2012 14:36:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E5709F97; Thu, 29 Nov 2012
 14:36:47 -0500 (EST)
In-Reply-To: <CANiSa6j2sriXaGr0yH9kMrxDEvKHsjNPX_Exbc2_6ecnPYdroQ@mail.gmail.com> (Martin
 von Zweigbergk's message of "Thu, 29 Nov 2012 11:04:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D1645F8-3A5C-11E2-A7AE-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210872>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> Would the correct fix be to
> first make "git reset --hard -- $path" work (*sigh*)? I have never
> understood why that doesn't (shouldn't) work.

What does it even mean, even when you are on an existing commit, to
hard reset partially?

Perhaps you looking for "git checkout $tree -- $path"?
