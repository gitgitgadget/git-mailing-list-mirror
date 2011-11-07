From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: fix remote set-url usage
Date: Sun, 06 Nov 2011 21:44:08 -0800
Message-ID: <7v7h3c4hcn.fsf@alter.siamese.dyndns.org>
References: <1320637017-30863-1-git-send-email-felipe.contreras@gmail.com>
 <7vfwi04itx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 06:44:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNI0F-0006E2-T2
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 06:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560Ab1KGFoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 00:44:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46522 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227Ab1KGFoL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 00:44:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA7871A1C;
	Mon,  7 Nov 2011 00:44:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NQPgNnI+Qj96ishbk10nPzdS+HI=; b=nXALTN
	fmSRF/NTc4aocriAyyoqc3stRoAYWz1Al7Uap0o/mauCPFkJsr/ufARMaBbK6bRh
	IQh8/JnZ2yikG+YN9LxHxLkFKC5S+EHGFsm+naz64fHFJz0bWY3aaI94WtTRrke/
	dRdYrTtS1wBCy1nlDqrM/K59SCMzhyoOLVXmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v0LXupVY6aF5JNmwZyD24tE+tGazop7t
	buzYVzUxWqsxqDdeAD7JdqtHdVmMoJZb0zZd7yqyvTvOZ6fZ5th9vyA4B2NnAJEw
	fsqDnXAP+0gf/ij4tjHWHxgG3dja8T+oT5zY2RSgdrTnC0tKfZq8E0XtuitYJ/bW
	WM0sz36Em04=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2B021A1B;
	Mon,  7 Nov 2011 00:44:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C8BD1A1A; Mon,  7 Nov 2011
 00:44:10 -0500 (EST)
In-Reply-To: <7vfwi04itx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 06 Nov 2011 21:12:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84138AC6-0903-11E1-97BB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184950>

By the way, these two are low-impact fixes to relatively ancient problems,
so while it is not urgent enough to include them to the upcoming 1.7.8
(the users lived with the bug long enough and survived), I do not see much
problem to include them in it, either.
