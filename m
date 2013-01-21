From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git rm -u
Date: Mon, 21 Jan 2013 11:01:19 -0800
Message-ID: <7v1udegy2o.fsf@alter.siamese.dyndns.org>
References: <50FB1196.2090309@gmail.com> <20130119214921.GE4009@elie.Belkin>
 <vpq622s9jk1.fsf@grenoble-inp.fr> <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
 <CAA01Csrv26WrrJDAo-1cr+rW6rYFGQZpYgtafEh=Wgtzswdv_g@mail.gmail.com>
 <7v622qhouc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:01:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxMct-0004Ic-N3
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279Ab3AUTB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 14:01:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43994 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422Ab3AUTBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 14:01:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A4A4A18D;
	Mon, 21 Jan 2013 14:01:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ABA/CkHUPyEE2H5tndfq0aF4TTk=; b=YsJ63p
	ab9RmfY6gDYyZumYawUDu5rckYqelteaDtpensTuphFZC67qLOBkKHuR/xk+4CDp
	6EZdLGVpBzI+tMpD92wV7LbtziiW0bwn+Xd4oB8aAXJL3eso/3EqLMqDEcTIu6Hq
	x7VTUfvCJ65uWnBD2Klj++AWTysT7VFHtaKYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qgZusEYRepOvCl1dvXIPZvwYfD0gmUnv
	wpmL7s0EI8qeNAGFpt7yBhHVZ2zi5kjx6wDMUdErk8biAsfyRNiPOT3biOERUtX4
	wT7aY2rk4hAonKoa/bxMc19j1mgsMoLIuIv1Lgw0FUcuTSww9qxG0qiQGn+zvHpB
	/1rFKmKB2+g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DC3FA18C;
	Mon, 21 Jan 2013 14:01:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 097FFA188; Mon, 21 Jan 2013
 14:01:20 -0500 (EST)
In-Reply-To: <7v622qhouc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 21 Jan 2013 01:23:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1997948-63FC-11E2-911D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214140>

Junio C Hamano <gitster@pobox.com> writes:

> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>
>> Do you mean "git add" will be disallowed without "." or ":/" argument?
>> Or will this change in future and "git add" without argument will me
>> "whole tree", same as ":/" ?
>
> No.  This is only about "git add -u<RETURN>", not any other forms of
> "git add ...with or without other args...".

This part is still correct, but all the remainder of the message I
am responding to is a total garbage, written from faulty memory
without fact check.  Sorry about noise.

> "git add -u<RETURN>" historically meant,...

The very original "git add -u<RETURN>" done at v1.5.2-rc0~17^2
(git-add -u: match the index with working tree., 2007-04-20) did
update the index with every change under the root of the working
tree, no matter where you were.

But v1.5.2.5~1 (git-add -u paths... now works from subdirectory,
2007-08-16) changed the semantics to limit the operation to the
working tree.  The log message seems to suggest that this was a
deliberate semantics change post release (i.e. the "tree-wide" was a
bug); I do not recall if there was a discussion and concensus when
this change was made, though.
