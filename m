From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH gitk 0/4] gitk support for git log -L
Date: Mon, 19 Aug 2013 10:30:55 -0700
Message-ID: <xmqq61v18u5s.fsf@gitster.dls.corp.google.com>
References: <cover.1370806329.git.trast@inf.ethz.ch>
	<874nblpamj.fsf@linux-k42r.v.cablecom.net>
	<874nbdnomj.fsf@hexa.v.cablecom.net> <51F6CB7D.1070806@web.de>
	<87siyu98cq.fsf@linux-k42r.v.cablecom.net>
	<20130818115456.GA6772@iris.ozlabs.ibm.com>
	<874namay5p.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 19 19:31:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBTIF-0000Vg-TI
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 19:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044Ab3HSRa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 13:30:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab3HSRa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 13:30:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 231313967F;
	Mon, 19 Aug 2013 17:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lomgTph10nvvKQ73rHvtRF43gFU=; b=CKri4D
	K/hbVo5pQwQNWLnOD6r7sOhaNyc1l87WztGaqoaUOQDleQHwFcgKP8dNCh7CcsFd
	0p7tcxmwfdhbotyla005Iji5q2kmTDGsQspyyAXz0S2j2ETbnPNRVWu5IBdO/40D
	46tIrbMzqcAkLcDCSW38TMAsKFwDEKRxjMU3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cb2O0lv7wmX7UuXP0SLBzA6KeM07Yr/U
	6hK08+cOIM5ItjSW/BVArxfGoOMnOt1RCejEfK1SLNJqSaWQDVr8Hd/epXaaCvUE
	KGjCZXcOznJJmc0RrT1RAbOs2s3D2B2G9Y51VJNvW5mzZBUl0wHqVAubfbq961Po
	nrQRARQau9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1732F3967E;
	Mon, 19 Aug 2013 17:30:58 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 452293967A;
	Mon, 19 Aug 2013 17:30:57 +0000 (UTC)
In-Reply-To: <874namay5p.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Mon, 19 Aug 2013 10:21:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1B84D372-08F5-11E3-A43C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232557>

Thomas Rast <trast@inf.ethz.ch> writes:

> Whether the option value is a separate argument in argv, or directly
> stuck to the option.
>
> stuck:   gitk -L:foo:main.c
> unstuck: gitk -L :foo:main.c
>
> Existing gitk chokes on 'gitk -S foo', but works with 'git -Sfoo'.

I somehow thought that we encourage the "stuck/sticked" form, to
reduce things the users need to remember to cope better with options
with optional value.
