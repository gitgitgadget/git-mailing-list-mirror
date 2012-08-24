From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Ignore trailing slash in mkdir() on platforms that
 can't deal with this
Date: Fri, 24 Aug 2012 10:43:40 -0700
Message-ID: <7vr4qwyylv.fsf@alter.siamese.dyndns.org>
References: <003101cd81e3$90574490$b105cdb0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Aug 24 19:43:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4xvC-0005g6-MU
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 19:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759957Ab2HXRnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 13:43:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45560 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758637Ab2HXRnn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 13:43:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D29082D1;
	Fri, 24 Aug 2012 13:43:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5I/JjIWamXzA2R1ms+E1TZHhJGo=; b=xV6InF
	tskD4kIu32K61tSTrIlVIITBM5xf8EtlXaKfHuQYs776xbE6UqJE/Lheg+BoXdhv
	rJ8zFsAHHe5ShhJNsoFT5JniTOgt2v0iEL18gVATK2N1j8+IAlXGMtgXiWS1Rna1
	vZOMTm0GyFu2wZGFe+vtJZWsm79Pv9nMiesLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rz6CaniDFodi2fDWmoQPyELzyYwiPbpu
	iDPSMeZwzX+x3jkZb9ppodmWfgm1Pb6ZW1YKuTNo7HzOIlrxuChrvxcLulkenb3A
	pNculKjpd6ztYIG3hdbwCKuSwbGwlMmBwANqXEwEt5RcC0OISlt2MWLEW5fkmqnF
	pnGmfvJQiuY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF4DE82D0;
	Fri, 24 Aug 2012 13:43:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6623A82CF; Fri, 24 Aug 2012
 13:43:42 -0400 (EDT)
In-Reply-To: <003101cd81e3$90574490$b105cdb0$@schmitz-digital.de> (Joachim
 Schmitz's message of "Fri, 24 Aug 2012 12:31:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3EDC88D6-EE13-11E1-957E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204223>

As the compat/mkdir.c file includes git-compat-util.h and expects
the declaration of the new function to be found in it, it does not
make any sense to have this as two patches.  I'll squash them into
one for now, but it would have been even more complete to have an
update to the Makefile to actually compile these files in the same
change.  These things go together.

The other itimer set shares the same issue.  I've queued mkdir and
itimer series as one patch each; please check the result in 'pu'
after I push it out.

Thanks.
