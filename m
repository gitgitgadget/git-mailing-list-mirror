From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep -P: add tests for matching ^ and $
Date: Mon, 27 Feb 2012 12:21:22 -0800
Message-ID: <7v4nuc6n99.fsf@alter.siamese.dyndns.org>
References: <7vlinpdxsu.fsf@alter.siamese.dyndns.org>
 <1330361149-26741-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, michal.kiedrowicz@gmail.com
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Mon Feb 27 21:21:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S274c-00064V-Kd
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 21:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251Ab2B0UVZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 15:21:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134Ab2B0UVY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 15:21:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48B657D7D;
	Mon, 27 Feb 2012 15:21:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iOuQguZ1Wv0I
	8uYzrhDAJNz03es=; b=wgaZvRXc3yWKvHPlt8XhU6QMym5FJzWqMj9KNjXl4nea
	mruk1E9NagWGHCK9roZFFVBzzNQEYkLH74gkL3ADn6Zn9ztu1QCMjBuwh5H1fJrK
	66MULY2uJw6/U5RWo0igiM142ZHYCCDesTZrIy/szPycOFwnIFfpb77N/sZ5qFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xKGGC0
	XFzeQCN3+AM4AlZqKhUGV3T7Vp6R2fUjhJ+9EcBx9cK8K8VTPNlUEk3cxxhiMLR1
	jM03TTZMrqX81z4bTAqEmcVlggqueNpD8mLmL9OENP7ZFVIp/W+TBlefWkBSDRB0
	FmJPbRuzZxUx/+CPnT++hWrMKYOja2uc/OsIo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FE837D7B;
	Mon, 27 Feb 2012 15:21:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C86087D7A; Mon, 27 Feb 2012
 15:21:23 -0500 (EST)
In-Reply-To: <1330361149-26741-1-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Mon, 27 Feb 2012
 17:45:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E5B5032-6180-11E1-A7F7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191665>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> From: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
>
> When a fix for matching ^ and $ with -P was commited to master in
> fba4f1 (grep -P: Fix matching ^ and $), the tests were missing the
> LIBPCRE prerequisite check and were dropped from the patch. Here are
> the tests guarded with LIBPCRE.

Thanks.

The real reason I separated it was because I didn't want to worry about
the test part when merging this down to older maintenance releases.
