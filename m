From: Junio C Hamano <gitster@pobox.com>
Subject: Re: strange behaviour, default branch on clone not as expected
Date: Mon, 03 Oct 2011 10:35:20 -0700
Message-ID: <7vbotygeqv.fsf@alter.siamese.dyndns.org>
References: <4E89E7E1.4000907@genband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Friesen <chris.friesen@genband.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 19:35:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAmQM-0007E6-EN
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 19:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061Ab1JCRfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 13:35:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60187 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755743Ab1JCRfY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 13:35:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C080E58DE;
	Mon,  3 Oct 2011 13:35:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cZvqNOziHu4ocaQB+GXzfvVNe1Q=; b=oSkOGI
	vFPyV++89lJ7GwD3nksFnRep4W8q6EaHNoZwJAP1eJ2Bz3EfmAImbffFclJQiMYN
	YBpZfg54BKMMIYQ0JvCjdTRnuRpak735ZkRPKo4j2Z2MVe5TnWqJb7YR54AXA6Ct
	9BTTRKvVZfvsmxUurkBQaoUnxL/HTCWD4tBWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KDt6Wi6+DIC1vojvW13cxn3Kr9rDgyoc
	AOo+V3rK38pxs7tN5KbOZhGCor2VptUMkLpm7nchbz3x48IxVzDBpaYqCfMa2K7w
	O+vNlUOhriVZStk1wNrgrUJJEFvxBqBBV6p4sSJGWZVINM6LvFyGVaX3Zv6CrNxM
	ZK6hQIiVWwI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7BA658DD;
	Mon,  3 Oct 2011 13:35:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31D9158DB; Mon,  3 Oct 2011
 13:35:23 -0400 (EDT)
In-Reply-To: <4E89E7E1.4000907@genband.com> (Chris Friesen's message of "Mon,
 03 Oct 2011 10:50:41 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12A481FC-EDE6-11E0-8B25-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182678>

Chris Friesen <chris.friesen@genband.com> writes:

> I have a bare repository on a server with (among others) branches
> "atca6900-ecgl" and "ncgl".  The "HEAD" file in the bare repository
> contains "ref: refs/heads/ncgl" and "git branch" in the bare
> repository shows an asterisk beside "ncgl".
>
> However, if I clone the bare repository I get "atca-6900-ecgl" as the
> default branch.  ".git/HEAD" contains "ref: refs/heads/atca6900-ecgl".

If ncgl is at the same commit as the acta one, this is expected. The
protocol does not carry enough information to tell which branch HEAD
points at.
