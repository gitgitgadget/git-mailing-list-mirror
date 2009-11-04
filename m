From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH bg/format-patch-p-noop] log-tree: always add --- marker 
 when options are patch and a stat
Date: Tue, 03 Nov 2009 23:31:24 -0800
Message-ID: <7vhbtakapf.fsf@alter.siamese.dyndns.org>
References: <1257283456-7007-1-git-send-email-bebarino@gmail.com>
 <7vy6mmltz9.fsf@alter.siamese.dyndns.org>
 <6672d0160911032300w1a2dfdbck5b1db98f2059639b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 08:31:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5aLE-0001Qm-Pn
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 08:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbZKDHba convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 02:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbZKDHba
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 02:31:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbZKDHb3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 02:31:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B60373EF3;
	Wed,  4 Nov 2009 02:31:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SfAxv4QMfojJ
	p/tNwkIH0lbQhek=; b=tq+07bA2Abn8Mwh63WNysYFlMNtnEg4IrCavHkyqZhcK
	b0LrAb1LpdXs9QG+WD2UX066mmT/nN81rVmJQArZcEcQqxLCKt4zjcn+/8IQun9s
	rq9tmOYuyk8bOWg2PJjfr0SX3JRRyRfQRhQrveI7ZOs+Umd3YLDeT0LBfuLLa6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=W/5ujm
	VQKlWBUfBv8FsT4y7I1sr2ll9nKGBqa3hCLSw4gUcIWoxgNLxiaVwQytHuSvz9IO
	FGgWuEIjEg1wqhJzUc0IeSsSg4bdY9I8WjVK+n5uoTZRDcrAui+cinmfWxae1WJa
	xXJbsxMUL9fW9raS+K8xuOznQFU9oKvjxqADk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D41C373EF2;
	Wed,  4 Nov 2009 02:31:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B95473EF1; Wed,  4 Nov
 2009 02:31:26 -0500 (EST)
In-Reply-To: <6672d0160911032300w1a2dfdbck5b1db98f2059639b@mail.gmail.com>
 (=?utf-8?Q?=22Bj=C3=B6rn?= Gustavsson"'s message of "Wed\, 4 Nov 2009
 08\:00\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 11885436-C914-11DE-BFB0-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132055>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> Since -p has been broken for 14 months, is really necessary to reinst=
ate
> it? (Or has the breakage not been reported because the people who car=
e
> still use a git version older than 14 months?)

Oh, 1.6.0 has the old behaviour and we see many people still on 1.5.X
series.  Hopefully nobody uses 1.4.X series anymore but I wouldn't be
overly surprised if somebody raised hand in the next 6 hours after seei=
ng
this message ;-)

> Why not just add a new --no-stat option?

I am all for teaching _new_ people to say "format-patch --no-stat", but=
 it
won't help people who have been happy with 1.6.0 when they update, if t=
hey
have to change their "format-patch -p" to "format-patch --no-stat".
