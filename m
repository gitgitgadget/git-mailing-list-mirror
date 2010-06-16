From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] am: use get_author_ident_from_commit instead of
 mailinfo when rebasing
Date: Wed, 16 Jun 2010 12:06:24 -0700
Message-ID: <7vzkyuer0v.fsf@alter.siamese.dyndns.org>
References: <4C186F9D.1060608@viscovery.net>
 <1276672360-15816-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 21:06:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOxwe-0006kf-J8
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 21:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758910Ab0FPTGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 15:06:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758407Ab0FPTGc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 15:06:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 87E14BCB32;
	Wed, 16 Jun 2010 15:06:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=RiqOYBMgILZONVxNkVUsswwktf8=; b=tg0cDNKbG2wZU/rPSiGdOqm
	CRUaoo1rDOHsUonUNLEFtEpXb9B2Do997STl1nq7pgSxJ+S2tggt8+z1Cav2awSM
	CnEADzMDTfZFNgHMSbeSAKBQ/e5nM9M80Af+UsaI6UIOZwYSo7pNPLppO3q3doBB
	9022WSgpKadzi2FkRB2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=tSxSrxe32fYPB0Gq2fyxxP91bF2iCuwXKVCVQwv5v2sw7Raeg
	9g12Tdu5rt8zV/WO9JOhIYpgqHGdcOmVSkiy+tZLMQZXveoVtCRgJUrBUWL5bNUb
	GlEPJWsMnXxr7NzMbbli5jHhGfCXH/Kos9PwKtQy47v7zdxx7PCGniTIQ0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E935BCB31;
	Wed, 16 Jun 2010 15:06:29 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E3FDBCB30; Wed, 16 Jun
 2010 15:06:25 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 44DFD50E-797A-11DF-B13E-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149270>

Jay Soffian <jaysoffian@gmail.com> writes:

> In certain situations, commit authorship can consist of an invalid
> e-mail address. For example, this is the case when working with git svn
> repos where the author email has had the svn repo UUID appended such as:
>
>  author@example.com <author@example.com@deadbeef-dead-beef-dead-beefdeadbeef>
>
> Given such an address, mailinfo extracts the authorship incorrectly as
> it assumes a valid domain. However, when rebasing the original
> authorship should be preserved irrespective of its validity as an email
> address.

This justifies the motivation very well.  Thanks.
