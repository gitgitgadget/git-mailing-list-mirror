From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/14] Fix non-constant array creation
Date: Fri, 21 Aug 2009 14:04:48 -0700
Message-ID: <7viqggdgjz.fsf@alter.siamese.dyndns.org>
References: <cover.1250860247.git.mstormo@gmail.com>
 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
 <40aa078e0908210641m660b003do6f637535293672ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <mstormo@gmail.com>, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 23:05:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MebIt-0002XS-PA
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 23:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789AbZHUVFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 17:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbZHUVFD
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 17:05:03 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932789AbZHUVFB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 17:05:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14317138DE;
	Fri, 21 Aug 2009 17:05:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LJHgY2Cw42/tCZOyq0h/BSE3/1g=; b=mFMhXt
	CVKGQCP4groyjS9b1gQ8jaLLhF2ovYbtgUFeFD1rHrIe1AtC/xrbJ+GgYmaQhaFD
	Dgqx+xHsrzZq40EiiD79CBJR/oDrao7VrswXIhwPkvbKts1mf3yHvan6wywHakRV
	S8dBV4fV947cYVV1y21MbxjAIyxg8dWzWh9x4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j32fO7uPSXaI/3lR8Om+Qpkcl6tulcqH
	rsDUl3yEwDXxR/MMZKfQVnm2KMaPlo7pq3OsiDOYbklHt6pv2hwa+Rwb6dAs26RG
	6zGVx0H1BjuwfD+wZE3knHiFyJCZlymr+By5Jf30xFn74RusrOuMVOGiTjjn7s9f
	VJAnHPCb+2A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A2C6138DB;
	Fri, 21 Aug 2009 17:04:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F803138DA; Fri, 21 Aug
 2009 17:04:49 -0400 (EDT)
In-Reply-To: <40aa078e0908210641m660b003do6f637535293672ae@mail.gmail.com>
 (Erik Faye-Lund's message of "Fri\, 21 Aug 2009 15\:41\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 47A3F81C-8E96-11DE-913E-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126754>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> How about using alloca instead?

I tend to avoid it; historically, alloca has been a worse portability
nightmare.
