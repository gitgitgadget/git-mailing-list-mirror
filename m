From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Mon, 07 Jan 2013 23:37:48 -0800
Message-ID: <7v8v84gm5v.fsf@alter.siamese.dyndns.org>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
 <CACsJy8B0ftDDagTpO4wh-LsBOBy+BhwhV=H-68U246Lq4=Ssfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 08:38:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsTlD-0001xI-Bf
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 08:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103Ab3AHHhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 02:37:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093Ab3AHHhu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 02:37:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F6DA69E2;
	Tue,  8 Jan 2013 02:37:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A38d1f/zIj/CnpDrAYRfjlwYNtM=; b=bAMUUF
	2P4FMcqZirVtwTAdlcQ0Ji/Deb+ssun4F4mDgAVJooETprZYXYuNyYStp5vxG5Ig
	t2P6KVhhYvysP7zrjuThHsln7xhTFeKLEqb+tiUiyuKVE0DGVKvsTb0XGxWSuqYi
	zLuZeHWRHFumaqe32lQJdSIQiosH6NLMyrGP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jyfTU0bmI0P9mSwjCjEq0t/N90x8vxHF
	RC6vWvwWCEG0kcD6sAjLIjVjeIWmkazGSwY0CzsTeSh2uU2523sB+OcytjlM7ZoT
	XjsI/YVfeo2v3cq5q0xAHgSxHQZPO6ehs1m4MOmZgbHvq8mBtJXsXcPxjW1oxtJj
	b28M+BK4x7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 803DD69E0;
	Tue,  8 Jan 2013 02:37:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E464069D4; Tue,  8 Jan 2013
 02:37:49 -0500 (EST)
In-Reply-To: <CACsJy8B0ftDDagTpO4wh-LsBOBy+BhwhV=H-68U246Lq4=Ssfw@mail.gmail.com> (Duy
 Nguyen's message of "Tue, 8 Jan 2013 14:33:40 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DAFDF02-5966-11E2-918C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212941>

Duy Nguyen <pclouds@gmail.com> writes:

> If we choose not to do the off-by-one topic Junio suggested elsewhere
> in the same thread, I think this document patch should be turned into
> code instead. Just reject --depth=0 with an explanation. Users who are
> hit by this will be caught without the need to read through the
> document.

I thought --depth=0 was a way to explicitly say "I do not want any
shallow history" so far, so we would need to be a bit more careful,
though.
