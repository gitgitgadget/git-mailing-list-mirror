From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to fork a file (git cp ?)
Date: Thu, 05 May 2011 11:50:57 -0700
Message-ID: <7vk4e56kxa.fsf@alter.siamese.dyndns.org>
References: <4DC1934D.6070608@aldan.algebra.com> <4DC19955.7040503@kdbg.org>
 <7viptqdvrf.fsf@alter.siamese.dyndns.org>
 <4DC20461.4090703@aldan.algebra.com>
 <7v1v0ddhbz.fsf@alter.siamese.dyndns.org>
 <BANLkTimD7byL=rgy79BWFT3vqKpzv9aNOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Mikhail T." <mi+thun@aldan.algebra.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 20:51:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3dv-0006cj-SN
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159Ab1EESvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 14:51:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab1EESvO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 14:51:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 33DEE43ED;
	Thu,  5 May 2011 14:53:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9fZwMEciJ3OP4JZm+8k3yqil7u8=; b=eszp0o
	iHKiyt2D2CzYkGppp0iIOkMWxRvrNRi1jDO5lApWNa+1WM0+D8RxwlmjN1nD7FoA
	wLW3gIH7FOTagFddD2uc62FSe8rB6ql9rJFZrygawvqfAV85LOPUvm1Xv0GGTT8J
	sY+jk6/Fv0hvK2fpk9JlPk6mYrp3Yv3Cmqemg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G4CBAXyYLv5IxXi5H1abS3+DCxyxjz0D
	yHOsvZYwAqkn7VsuitBNc7ui0e2GPXbD+P/7dzJtSB4VC4OPfShfXsJmR3RgkBlk
	YjuKTza17PIsLHx1ZDDNhvnIcknxUhbE0m9no5YhVWnkL5jvW6tLCbujZGCKC+y2
	UVjqEHZ9h8g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E6B2C43E7;
	Thu,  5 May 2011 14:53:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4740E43E5; Thu,  5 May 2011
 14:53:03 -0400 (EDT)
In-Reply-To: <BANLkTimD7byL=rgy79BWFT3vqKpzv9aNOQ@mail.gmail.com> (Piotr
 Krukowiecki's message of "Thu, 5 May 2011 20:02:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECFF853C-7748-11E0-82B5-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172875>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Maybe Mikhail wanted to say that if there's a git-mv as a shortcut for
>   "cp old new ; rm old; add new"
> then there should be a git-cp as a shortcut for
>   "cp old new; add new"

Copying and then futzing with a copy is a bad discipline to begin with.
git already has a reputation of having too many commands.  I am not
thrilled about the idea of making things worse by adding an unnecessary
command, and especially one that encourages a bad workflow.
