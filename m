From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test failures in today's pu: 0025, 4046, 4203, 9300, 9301
Date: Wed, 20 Oct 2010 09:40:29 -0700
Message-ID: <7vvd4wvmv6.fsf@alter.siamese.dyndns.org>
References: <201010201148.51551.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 20 18:40:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8bib-0008OX-Fb
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 18:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074Ab0JTQkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 12:40:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab0JTQkl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 12:40:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E7A4E0A27;
	Wed, 20 Oct 2010 12:40:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hFSlUSSHZr60biHKMfeYvGwkwyQ=; b=JE+73D
	p+dUPLlIZ1FNtsxBpiYMbfIhXYJV68RpdYIF0bltl6r0xBVo333ABa/324Il5+aV
	IGsizPENlWnONWJTmaLKS/7bnF3sILziqtJ/Oelfi4tsZGfh5yWKp7BinLS5Cnu5
	8d1tUwbSWRSz8eLv8TK9J4kChUW5XudKHzQl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PFvwhBDdnrDwjl2D512/0IfVPm0EOnzP
	jUNMXAWVFRQcE9mtf1EyPvuC3gg41bAeRD/D/QnyNGKk06rT1/7xNy8CrZ96i00e
	HoZCPByAbg/HYqQPvxRw90u/bUOc4NguarM4LxhEwcgvEMpQoAdTvwffkfsN0Qrn
	iilGoyGjlq8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B0E4E0A24;
	Wed, 20 Oct 2010 12:40:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 188DDE0A1B; Wed, 20 Oct
 2010 12:40:30 -0400 (EDT)
In-Reply-To: <201010201148.51551.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed\, 20 Oct 2010 11\:48\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C4EA3D1A-DC68-11DF-960C-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159415>

Thomas Rast <trast@student.ethz.ch> writes:

> * t4203-mailmap: bisected to d8d2eb7d (mailmap: fix use of freed
>   memory).  I saw some list traffic possibly related to this, is it
>   fixed already?

I found one issue that will trigger if you do not run this test with its
standard input corrected to a terminal and pushed out a fix last night.
Did you have 3e3e1ef (t4203: do not let "git shortlog" DWIM based on tty,
2010-10-19) when your automated test ran?

> * t9300-fast-import: bisected to a544a23c (t9300 (fast-import):
>   another test for the "replace root" feature).

Jonathan noticed breakage caused while I was applying his patch; should be
corrected as of last night with 971728c (t9300 (fast-import): another test
for the "replace root" feature, 2010-10-17).

> * t9301-fast-import-notes: bisected to 5edde51 (fast-import:
>   filemodify after M 040000 <tree> "" crashes).

I saw this one too; it seems to happen with jn/fast-import-fix topic.
