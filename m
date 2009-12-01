From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git open calls fail on NFS-mounted NTFS volume
Date: Mon, 30 Nov 2009 16:38:59 -0800
Message-ID: <7vhbsba5p8.fsf@alter.siamese.dyndns.org>
References: <F7CE7D3D-9237-494C-B6C8-6B6D7AB7CE45@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kai Lanz <lanz@stanford.edu>
X-From: git-owner@vger.kernel.org Tue Dec 01 01:39:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFGlv-0003zE-Cz
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 01:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874AbZLAAjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 19:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbZLAAjC
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 19:39:02 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbZLAAjB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 19:39:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D32684604;
	Mon, 30 Nov 2009 19:39:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N+ljeCvyepnYUBQ1pkB12m5CHG8=; b=Ty9MmN
	S6VnItXsrWtt9gLApxLEN1pWoXuyik6gEGrdzJW7WYesgbzOZPBJba0ghFWfNNmE
	rnjkdEH3DRSG5S8mLwZbDJ9HuSPLRd8fuoV60S1OkI5YcrlBOkhDEQc6rrU5vwCT
	L+9U0T5JjdLTNQIvZ/HCxErzZp0Dr0bDBTTTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qDSJyljEg4IsI0V0iPb1JbdlQUz9vyRf
	SiksoDA/1FKC4hIvIh/FGkXjvSeQorMHVwfSdtCxYF079YWYDrrCNRRbse5LHWvD
	K+7K7VxrIBDe+QtcffdwJDI4IOh/0GAUfN9BEaSwVej5IATM8anjZ3UqPWur7Ie7
	ueYoJgvBE/c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 46CE484602;
	Mon, 30 Nov 2009 19:39:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A59DE84601; Mon, 30 Nov
 2009 19:39:01 -0500 (EST)
In-Reply-To: <F7CE7D3D-9237-494C-B6C8-6B6D7AB7CE45@stanford.edu> (Kai Lanz's
 message of "Mon\, 30 Nov 2009 15\:09\:28 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ED2B55D0-DE11-11DE-9F2F-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134160>

Kai Lanz <lanz@stanford.edu> writes:

> There are several places in the code where git calls open() with the
> flag
> O_EXCL. This causes a problem for us when the current directory is on an
> NFS-mounted NTFS volume shared by an NAS fileserver.
> ...
> Git version is 1.6.5.3, running on x86_64 RHEL-4, kernel 2.6.9-89.

I do not use nor have access to RHEL, but does this ring a bell?

    https://bugzilla.redhat.com/show_bug.cgi?id=524520
