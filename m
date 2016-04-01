From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/7] CRLF: unify the "auto" handling
Date: Fri, 01 Apr 2016 15:25:03 -0700
Message-ID: <xmqqa8ldge68.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1459526909-19946-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Sat Apr 02 00:25:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am7VB-0001Xc-69
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 00:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbcDAWZI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2016 18:25:08 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752688AbcDAWZG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2016 18:25:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D43FA4F82F;
	Fri,  1 Apr 2016 18:25:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pIYaaKhkR39Q
	M5q/d6DLiBWUIZ4=; b=WavagVOMol1K0XwMhs7/ve+/i4WxXGJiEInaAt7mi3or
	DIFb3dc1XvafSIeurysYK8aaZHn5Hw1egQCBQ7vppxCCI1EmYCXx1QehtCwu70Fx
	I8jRq6fHQ4KUayAGFXuKk1wTY9ZqOdfNKAAwhuqLpqHCto65whLkmdFoDqL+a9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CA+HVi
	PWMrTw1K3PS++zImEZ8OmipcRDIUWYjh5vb/7B+TZgIt9fKPRIzkub/WQpSWhOCK
	0iYK+QcdqrIiqu7/IcAfmeQkrLl8lWxGd8wm45G0x2QAyicw6rR/eno/kjCq+hL+
	FL3QBBTm08kRlhzzR+reTQ+LajqrMOZXAljnY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC7A14F82D;
	Fri,  1 Apr 2016 18:25:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 453184F820;
	Fri,  1 Apr 2016 18:25:05 -0400 (EDT)
In-Reply-To: <1459526909-19946-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Fri, 1 Apr 2016 18:08:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 95751E4E-F858-11E5-BBEF-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290586>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Make .gitattributes "* text=3Dauto eol=3Dcrlf" to do the same as
> setting core.autocrlf=3Dtrue and "* text=3Dauto eol=3Dcrlf" the same
> as core.autocrlf=3Dinput

"Earlier we didn't do so and instead did X, which was not great
because it caused symptom Y and Z"

would be necessary for future readers to understand why the above
change is a good idea.
