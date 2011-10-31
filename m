From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Out of memory error with git rebase
Date: Mon, 31 Oct 2011 13:21:41 -0700
Message-ID: <7vlis0q5d6.fsf@alter.siamese.dyndns.org>
References: <83vcrc9kh7.fsf@kalahari.s2.org> <4EA7E710.1020006@kdbg.org>
 <83r51ta1rq.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Mon Oct 31 21:21:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKyMe-0006E5-KG
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 21:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402Ab1JaUVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 16:21:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60296 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338Ab1JaUVo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 16:21:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91ED26E29;
	Mon, 31 Oct 2011 16:21:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aK7BtNTLOYn4Rj+ZK8CWioA8bQ8=; b=ecCZVf
	R3wCEpbjLMPhrb0y1cmOMqUoQ3nxPw4PQdEI68uwqQmf+EJhxk3BwnUmbDYsylbA
	1QrmJSWn3fgwv8WS039/uujBPrb1ijVMUXwkgGWv2W0qYZmFfzp0nf6DLQIgIMm9
	gpAZTUeIB59qK+w05tlo61Sq4nZPcNsRHDCCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AlYKfx+nXREZLpZ+iRgaAszYKvRI5VYg
	uCLFcRbciOi87hG7MjLfXfkPwyzIhhlU1hO4fq2iS8xNbPTO+FeL06ZpI+vEy4+e
	PWPqEH8NdoglzTmg+79tl6VDiOpTZHyUL0e4EliOVkqX9LjgSNQ7Si4JpA/wSyMA
	4utqaxIKQHc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70B286E28;
	Mon, 31 Oct 2011 16:21:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D30286E24; Mon, 31 Oct 2011
 16:21:42 -0400 (EDT)
In-Reply-To: <83r51ta1rq.fsf@kalahari.s2.org> (Hannu Koivisto's message of
 "Mon, 31 Oct 2011 12:33:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F28CF9B6-03FD-11E1-947E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184520>

Hannu Koivisto <azure@iki.fi> writes:

> From the documentation I can't figure out any reason why one
> wouldn't always want to use -m.  Why is it not the default?  I
> think it's pretty much impossible for ordinary users to figure out
> that they need -m in a situation like this.

Because most people do not have too large binary blobs in the history, and
at least when "rebase" was originally written, merge-based rebasing was
way slower than patch-based one.
