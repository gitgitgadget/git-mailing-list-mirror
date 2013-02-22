From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: allow users to silence Git 2.0 warnings about "add
 -u"
Date: Thu, 21 Feb 2013 22:23:13 -0800
Message-ID: <7vtxp4sw8e.fsf@alter.siamese.dyndns.org>
References: <1361513224-34550-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 07:23:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8m2n-0003NR-BO
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 07:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696Ab3BVGXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 01:23:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43794 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753193Ab3BVGXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 01:23:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3635BA621;
	Fri, 22 Feb 2013 01:23:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N9JqAWbMNBhGskXuHu3+mPz06lw=; b=EJAUpE
	1VuGf0vlqvThIm1sp5Hd8FW9xjW3xuwJNYqxGqZ4OyZrplXjUatv9hhr09jVBWGQ
	6A8xIsw4wNTMPJqmLAWax9wqP893s+Rd4ZWJZf8ej0ttYUJKokNm1UiVyCEvoFgC
	H6rSwmiaYK4hpoOhHbrzXt/9rhag6g+dERZ2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gUtXhfrTH2QfgO5IGr7g9X+toqj5QZS8
	QEMciWK+KzGLpaWgQLDWUB0hqRn2U3f05PpAMRoLgwegui0dzeO8AT00nywTgQzC
	aCpVRPMGfvDkTh/zOBu+atVy5ZLixzVZvXRXMrM/0ux4Wq/gNP3rRnNHRdd83fia
	hg8CsMU/w6E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B021A620;
	Fri, 22 Feb 2013 01:23:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DC6EA61F; Fri, 22 Feb 2013
 01:23:14 -0500 (EST)
In-Reply-To: <1361513224-34550-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Thu, 21 Feb 2013 22:07:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56CB7E46-7CB8-11E2-B066-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216819>

David Aguilar <davvid@gmail.com> writes:

> When "git add -u" is invoked from a subdirectory it prints a
> loud warning message about an upcoming Git 2.0 behavior change.
> Some users do not care to be warned.  Accomodate them.

I do not think this is what we discussed to do.

It was very much deliberate to make the way to "squelch the warning"
not a "set once and *forget*", aka configuration variable, but a
simple-to-type extra command line argument i.e. "git add -u .", that
you will *always* type to train your fingers to explicitly say what
you mean, so that the default switch will not matter to existing
users.
