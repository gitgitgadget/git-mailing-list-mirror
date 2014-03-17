From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Mon, 17 Mar 2014 14:35:03 -0700
Message-ID: <xmqq61nccxvc.fsf@gitster.dls.corp.google.com>
References: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
	<1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
	<1394919750-28432-3-git-send-email-benoit.pierre@gmail.com>
	<xmqqmwgoejwq.fsf@gitster.dls.corp.google.com>
	<CA+SSzV2qpQ+O0Ee7hrv+TM-j03BAvC1s_qJqOnyoBtVbCgxjtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 22:35:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPfBk-0001cq-H2
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 22:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbaCQVfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 17:35:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33515 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbaCQVfH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 17:35:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEBDC76136;
	Mon, 17 Mar 2014 17:35:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RaAB9Z7bGnzPYpBnjHLZGecttO4=; b=iC6rdn
	vuALc6kCpWckb1tqmOKwzIqtxPVnnLL30NDBFjTBe2YFOYAJ+OgzH5ChYCsO4yAz
	MhKE+wsaTWhp/SMoc31RLyrUi1F5IIViZ+kLKvscetFOqin+BvI86YYEOrk2xpYJ
	hg1TOgKWDLxbGJzjgpvNHIONX4qN69o5YjIf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vcfARfsrrSMaQwsXkdC/+6aMKNDFXFrh
	8ERXqXO/sd3n7Su6gg0K/Szpb/OcGPnz1WU8st5Z5FQUuHFCtYhymZv3msWPLw5f
	FQPJTAnXx3CYq1rAPgydWoD7/SyiQbBvThd17UrKmtOqtIFWZK9zgSYubl1T1SYJ
	dJuqJNEwVWs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D94A76135;
	Mon, 17 Mar 2014 17:35:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA9FC76132;
	Mon, 17 Mar 2014 17:35:05 -0400 (EDT)
In-Reply-To: <CA+SSzV2qpQ+O0Ee7hrv+TM-j03BAvC1s_qJqOnyoBtVbCgxjtw@mail.gmail.com>
	(Benoit Pierre's message of "Mon, 17 Mar 2014 20:52:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 018EC366-AE1C-11E3-86C3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244290>

Benoit Pierre <benoit.pierre@gmail.com> writes:

> Isn't the point of using "when finished" to have each test leave the
> tree clean after execution, to avoid "bleeding" onto the next test(s)?

But you cannot anticipate what other people will do in the future
before you have a chance to run this piece.  Your using when-finished
is courtesy for others.  Your explicitly making sure what you do not
want to be stray behind is protecting yourself from others.

They serve different purposes, and you need both.
