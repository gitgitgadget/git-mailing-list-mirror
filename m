From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] Add --unannotate
Date: Tue, 01 Jan 2013 13:30:47 -0800
Message-ID: <7v623ga8vs.fsf@alter.siamese.dyndns.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-3-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, James Nylen <jnylen@gmail.com>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 01 22:31:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq9QT-000433-6i
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461Ab3AAVav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 16:30:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45060 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439Ab3AAVat (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 16:30:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 536F596E1;
	Tue,  1 Jan 2013 16:30:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Indi5rj6wXDsLvbZKCO/UnusLws=; b=ZEZ1TE
	YXxIBxKc7bAKxyUOsv/szl9FbtmzdaR4P6ZzqVI7oUOqf7vua6VoJyHHPA33m4FP
	SBGhaIyUmme7+uOsjjHPENXNvBGEebmsRMaxaRHMY4K+HQiyrylnn+zaipRyVRBN
	JnTwMBoWjV/FNqzZEzAAlW7qP4dfjhhYREwnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dMkwsNTDkDaFWyk5QuBKv1jMs+CskpkE
	xCPTuSltTZzNjoi/tP8rBjX9htIWgMIVfz6J1ak4FWPKA/WMt8aHnWFMKJpL1GIA
	H03I72/C6pMB2BeWn20F8qvGtNwhkJN91DckQuOHFWnSX1d3zjPnjrDiWAH2p5kU
	nFHKnuwkONg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4420B96E0;
	Tue,  1 Jan 2013 16:30:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B871296DF; Tue,  1 Jan 2013
 16:30:48 -0500 (EST)
In-Reply-To: <1357012655-24974-3-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Mon, 31 Dec 2012 21:57:29 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 827E3B54-545A-11E2-82CE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212444>

"David A. Greene" <greened@obbligato.org> writes:

> From: James Nylen <jnylen@gmail.com>
>
> Teach git-subtree about --unannotate.  This option strips a prefix
> from a commit message when doing a subtree split.

Hrm.  This looks like a workaround for a short-sighted misdesign of
the annotate option that only allowed prefixing a fixed string.  I
have to wonder if it is better to deprecate --annotate and replace
it with a more general "commit log rewriting" facility that can
cover both use cases?
