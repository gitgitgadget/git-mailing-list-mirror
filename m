From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Mon, 02 Nov 2009 09:31:03 -0800
Message-ID: <7vhbtcvnoo.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com>
 <7vzl75v737.fsf@alter.siamese.dyndns.org>
 <20091102154104.GR10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 02 18:32:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N50l8-00028i-PJ
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 18:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580AbZKBRbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 12:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755464AbZKBRbL
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 12:31:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbZKBRbL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 12:31:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E0D5571BA2;
	Mon,  2 Nov 2009 12:31:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wr0gy5tnWMFHP7nGSW0TXgIgnCc=; b=yJ+xdU
	7E+czQp2fiqxW5bzKPuoHVtw9F3M17gcUw17POnc7K1MZ8cXdRlWgxCeDoAH05W6
	gmNWpjqR2Qsv0Inrl1p/dJPH7dsJDWmqSCQB9Ptrjy6iO8Y3Te4UF/nDhVSs3Xpr
	2UhwsWYidd3gyZRgOiQQ5m1XvIrQkTDVAIiIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OSe63cyFb/9XvoHz0ax3PfZIJH3jcpaq
	042wMvV4V6wRFkAH6/DHWS70aHvyjfqZq9H0DqY4WxmgklGKn2RCX+gPJGM4tW5i
	CRnB3edzWE0hyMVuJ2x1bqiWpon4h38Y/SmjHgYhWAD/qPN14AcGpqaGQgkC2mTq
	CXR+h8mCsmM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB17471BA1;
	Mon,  2 Nov 2009 12:31:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9287771B9F; Mon,  2 Nov
 2009 12:31:04 -0500 (EST)
In-Reply-To: <20091102154104.GR10505@spearce.org> (Shawn O. Pearce's message
 of "Mon\, 2 Nov 2009 07\:41\:04 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 82EFB622-C7D5-11DE-9F1D-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131928>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If its SHA-1 you are talking about, I wanted this to be a MUST
> use lowercase, but people screamed about it (Jakub and Ilari
> IIRC).  The current C code accepts uppercase due to its use of
> get_sha1_hex(), and they wanted to follow the "be liberal in what
> you accept" suggestion from other IETF authors.
>
> IIRC, all implementations use lowercase.  We should be able to safely
> say MUST produce lowercase, and MUST accept lowercase, and SHOULD
> NOT accept uppercase,...

I do not see a point in loosening or tightening the definition
document that is written to describe a protocol of a reference
implementation after the fact.  It is not like producing lowercase
hexdegits is a lot more work on some weird platforms.

Everybody writes in lowercase, expects to see lowercase, and some may
accept uppercase by accident.  I think it is acceptable to describe that
as "MUST produce, MUST accept lc and MAY accept uc", but I do not think it
is even necessary to specifically say "and MAY accept uc".

It is actively wrong to say "SHOULD NOT accept uc"---it won't help
anybody.
