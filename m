From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to fork a file (git cp ?)
Date: Sun, 08 May 2011 13:03:03 -0700
Message-ID: <7vd3jtrmdk.fsf@alter.siamese.dyndns.org>
References: <4DC1934D.6070608@aldan.algebra.com> <4DC19955.7040503@kdbg.org>
 <7viptqdvrf.fsf@alter.siamese.dyndns.org>
 <4DC20461.4090703@aldan.algebra.com>
 <7v1v0ddhbz.fsf@alter.siamese.dyndns.org>
 <4DC2FB0A.2090100@aldan.algebra.com>
 <BANLkTikE8aMh6RUDzrh=SuOxvKxuPShQhQ@mail.gmail.com>
 <4DC6F1C8.8040007@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	"Mikhail T." <mi+thun@aldan.algebra.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Sun May 08 22:03:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJACa-0005fn-KR
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 22:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab1EHUDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 16:03:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45987 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab1EHUDS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 16:03:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 121245808;
	Sun,  8 May 2011 16:05:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OxU2Ggz+KHxn3XfphKLybCH5M8I=; b=iGc3yF
	pILdB4UpcxkvRRzaR67WlvEHMOEuObE78UG27G3b5i2gQe+oEyqS9oX6osXKdUrf
	zMy667yewSdkUXdQjVyqj6OPaWV9vmeVr7J4DV08URcwzx/9KZ1xKZdv25sOy4dc
	xRvHtGqkkOlinVY5qabM4m2GeV/ozRceWAHCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IZXM/N9Fx0O0IRNUqspa4lUhFDFZ64EG
	HSxoavmfsNoOr5nppFnkBwePfooPoy0yGnuRxYjo2x2EVuvMPShRx2fyBZrWBw4m
	qAZ0RiplLnK+3zx2VHvFPeR8VaInW48JsR1bhWfcHlX4ZjqTsR1LmQGkMfrnLCGm
	G09ugGwLc+E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B4EB45805;
	Sun,  8 May 2011 16:05:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4D37D5801; Sun,  8 May 2011
 16:05:10 -0400 (EDT)
In-Reply-To: <4DC6F1C8.8040007@pcharlan.com> (Pete Harlan's message of "Sun,
 08 May 2011 12:40:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E0472CE-79AE-11E0-979A-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173175>

Pete Harlan <pgit@pcharlan.com> writes:

> Rename detection compares new files against deleted files.  Copy
> detection compares new files against every file in the tree, which is
> usually much more costly.

Almost correct.  Copy detection usually compares new paths with paths
modified in the same commit.  "Every file in the tree" is done only when
you ask to find copies harder.
