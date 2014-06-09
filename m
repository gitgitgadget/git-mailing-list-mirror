From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git reset --hard with staged changes
Date: Mon, 09 Jun 2014 16:28:31 -0700
Message-ID: <xmqq61k9d5nk.fsf@gitster.dls.corp.google.com>
References: <CANWD=rWmzgAwTp=E_1=th0Myk-dh4m5Y9PE3=fpHeirsVVQKwQ@mail.gmail.com>
	<CANWD=rX-MEiS4cNzDWr2wwkshz2zu8-L31UrKwbZrJSBcJX-nQ@mail.gmail.com>
	<87vbsayy9w.fsf@fencepost.gnu.org>
	<CANWD=rVB249Vu1QMk64V+FxfCfJPzxqZgCfyEuixJJ_iKoTLPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: =?utf-8?Q?Pierre-Fran=C3=A7ois?= CLEMENT <likeyn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:28:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8za-0008Gv-LM
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbaFIX2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2014 19:28:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53090 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932349AbaFIX2h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jun 2014 19:28:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 27D681D51D;
	Mon,  9 Jun 2014 19:28:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mbm3JDbS0QYW
	Xul6wERxafgOABg=; b=to+stEjG173KycAXywUQJRHkGUy1vDEc5DR+BQE88NJa
	xLCdcbH0gsk6cFOFeudKB4GgWJRevAhXh9732WQpucIjMAGB0MNRn8YI8f0yINgm
	a00t77UJbcVjySXGuj29HwEL/A5ZREgebltDcchTfoFJLEhbRa2OdnXu9Yu9ods=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=e5DU58
	5aIHGWhxCUtyqlOUH7VMINfYDNWW2/8P6zJhZrM2mbw/AAbRfozzClH9TUSsFBqO
	NDn0nan0VjLPVB4XkxvmtQo5OO4LSjFIHe8lCW7PJ86JpbJARx7Ru45AIElhreUP
	4y3MfogrZGj8HeKnWKcsDbmQa0o6Y6v8Rj4y8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E7391D51C;
	Mon,  9 Jun 2014 19:28:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 43A871D517;
	Mon,  9 Jun 2014 19:28:33 -0400 (EDT)
In-Reply-To: <CANWD=rVB249Vu1QMk64V+FxfCfJPzxqZgCfyEuixJJ_iKoTLPQ@mail.gmail.com>
	(=?utf-8?Q?=22Pierre-Fran=C3=A7ois?= CLEMENT"'s message of "Tue, 10 Jun
 2014 01:22:55
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C5BBE7A2-F02D-11E3-A0BA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251145>

Pierre-Fran=C3=A7ois CLEMENT <likeyn@gmail.com> writes:

> Hm, I didn't think of "git apply --index"... Makes sense for this
> special use, but I'm not sure about the other use cases.

Try merging another branch that tracks a file your current branch
does not know about and ending up with conflicts during that merge.
Resetting the half-done result away must remove that new path from
your working tree and the index.
