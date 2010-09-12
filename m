From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 3/3] t/gitweb-lib.sh: Add support for
 GITWEB_TEST_INSTALLED
Date: Sun, 12 Sep 2010 10:37:47 -0700
Message-ID: <7vtylueuc4.fsf@alter.siamese.dyndns.org>
References: <1284284466-14506-1-git-send-email-jnareb@gmail.com>
 <1284284466-14506-4-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 19:38:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuqVA-000710-QK
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 19:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523Ab0ILRh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 13:37:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab0ILRh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 13:37:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 640D2D5F6E;
	Sun, 12 Sep 2010 13:37:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UcBWTZ0FHNNdl8CIv+dJ3mNidPI=; b=BhtIbc
	5YVJ7nfiMO0z4LD3CVC1a362HgHuaR4RUS48zZemrMsY9pQovsltPcA+Xii+CL88
	67qp+DPMWNlZBzvBfMh3tmITzn7+nqVtx18rjI2Cd29rwp54Z9aEfM2edV1AQKRC
	OJoPFaDKOiaOjmqyqCnoWcwStnklTb3oHsDxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Im+Sb8No2aL5pH2N2cVkpkuVp4HUzSUq
	ab8IVrp2fG+iCQilRzJiBrO1CcvHg+jkyWK7+PCSfQkPkr3F5qyvihYbXdAjBeyQ
	7gJUpH6E+ddjokkqhVj6u5Hce+MFjOjmudTpSlgwZY2F14TxK3zP8ECbVjlOU6sa
	7R/lYL77ibU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 411FBD5F6D;
	Sun, 12 Sep 2010 13:37:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EDFDD5F6C; Sun, 12 Sep
 2010 13:37:49 -0400 (EDT)
In-Reply-To: <1284284466-14506-4-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Sun\, 12 Sep 2010 11\:41\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7804764C-BE94-11DF-9405-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156039>

Jakub Narebski <jnareb@gmail.com> writes:

> It is an RFC because I am not sure where to put documentation,
> i.e. description of GITWEB_TEST_INSTALLED.  Should it be put in
> t/README, in gitweb/README, or in gitweb/INSTALL, or in
> t/gitweb-lib.sh header?

I think the comment in this file is fine.

> +	# You can set the GITWEB_TEST_INSTALLED environment variable to
> +	# the gitwebdir (the directory where gitweb is installed / deployed to)
> +	# of an existing gitweb instalation to test that installation.
> +	if test -n "$GITWEB_TEST_INSTALLED" ; then
> +		SCRIPT_NAME="$GITWEB_TEST_INSTALLED/gitweb.cgi"
> +		test -f "$SCRIPT_NAME" ||
> +		error "Cannot find gitweb.cgi at $GITWEB_TEST_INSTALLED."

I don't know if GIT_WEB_TEST_INSTALLED=/path/to/some/directory (naming the
directory that houses the script which must be named gitweb.cgi) is easier
to use than GIT_WEB_TEST_INSTALLED=/path/to/some/gitweb.perl (naming the
script that is allowed to be renamed).
