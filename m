From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Performance regression due to #33d4221: write_sha1_file: freshen existing objects
Date: Mon, 20 Apr 2015 13:04:11 -0700
Message-ID: <xmqq1tjelg78.fsf@gitster.dls.corp.google.com>
References: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
	<20150417140315.GA13506@peff.net>
	<CADoxLGOPXDgb0LBcSBm+xRDhbnGV_y-TXENyPV7oK_+KZzPKRQ@mail.gmail.com>
	<20150420195337.GA15447@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Saasen <ssaasen@atlassian.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 22:04:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkHva-0000Au-Lu
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 22:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbbDTUER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 16:04:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754023AbbDTUEO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 16:04:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 21C04499A1;
	Mon, 20 Apr 2015 16:04:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7ez1TI7qg27n46Cljg8r0NCDTig=; b=cOESsf
	arNpwaiO8XdOgNl2c+V39KZRTuuPkupaC5o8R+kYFU9f7kJCWbcpHEzqJsIwnldL
	c14HKsA8+qbxbM9XsZh79OnvY+ML1THXljQzAFwCPJfgiPhgrDI7YwLdqb0UThZq
	/GzfDNGyLib34HWCf+gJKrXaG154bB3qRp0FM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S0LPuSx0tPS4sXB36ibhle2zRiIMjk1C
	Xsm5nSSjXf45mdP0fJgoFrFeuOA5nGFChHmihu4xBATCpPo7xNOBH/7nq2QgzHFX
	8hTEKBkO4brKu0kIG9K1rBH/MDbzmQLctPL5wD1dIAtjc1HoxuG+Hr3fQY9lquzS
	gFCy3VBMNF8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B087499A0;
	Mon, 20 Apr 2015 16:04:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CF354999F;
	Mon, 20 Apr 2015 16:04:12 -0400 (EDT)
In-Reply-To: <20150420195337.GA15447@peff.net> (Jeff King's message of "Mon,
	20 Apr 2015 15:53:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 69E955AA-E798-11E4-B7A6-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267496>

Jeff King <peff@peff.net> writes:

> ... But I don't know
> if this counts as critical (it is for you, certainly, but I don't think
> that many people are affected, as the crucial factor here is really the
> slow NFS filesystem operations).

If it is critical to some people, they can downmerge to their custom
old installations of Git they maintain with ease, of course, and
that "with ease" part is the reason why I try to apply fixes to tip
of the original topic branch even though they were merged to the
mainline eons ago ;-).

Thanks.  The patches look good from cursory reading.
