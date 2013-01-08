From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Enabling scissors by default?
Date: Tue, 08 Jan 2013 14:42:07 -0800
Message-ID: <7vvcb7b8lc.fsf@alter.siamese.dyndns.org>
References: <50EC92C6.7090509@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 23:42:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TshsM-0001UM-JA
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 23:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402Ab3AHWmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 17:42:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753026Ab3AHWmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 17:42:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E411B232;
	Tue,  8 Jan 2013 17:42:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CM/tHAXMUXjv9RRixcDkFOWXZ1A=; b=NFAHmP
	kik/YSyVDdKf3Me9chCev+CCU3D5NnSGLZBa1GXg5ISGvDHjXSKnxOzR037+9yyq
	mG5RtMBSVkq140GD4zyxgPKDAgBzRLDgf5n9f6WNimb+k3CG3yUaj13Zw2L0+ovl
	JrEA5TdSZtN3o1oo2pXmWLAGCpnMSRjjsG+yA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GCwd5pxHBYtC9wjqbQyGTI815GBig3ow
	a4erHKpL/8gal+swgdvDF9mkGKNgG64sCywag3YVKWgCG8ru+BDbz+lXm9c/SfkN
	QuMeLAXEb5mBVlFNeiPCbAvKX6paXFYCCpCu+cYr8aGTouOwrT5Wo+CJIH5Fsxmb
	b7hYJJQtFp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74194B231;
	Tue,  8 Jan 2013 17:42:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8B2DB22E; Tue,  8 Jan 2013
 17:42:08 -0500 (EST)
In-Reply-To: <50EC92C6.7090509@ubuntu.com> (Phillip Susi's message of "Tue,
 08 Jan 2013 16:42:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A294BCE4-59E4-11E2-800A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213010>

Phillip Susi <psusi@ubuntu.com> writes:

> I was wondering why am's scissors option is not enabled by default.

It is very easy to miss misidentification of scissors line; as a
dangerous, potentially information losing option, I do not think it
should be on by default.

Another reason (and this is the original one) why it is not enabled
is to discourage the contributors from overusing scissors -- >8 --
line.  If you always have to write too much stuff before the proper
explanation of your patch, so that the integrator has to use -c
option all the time, you are explaining your patches wrong.
