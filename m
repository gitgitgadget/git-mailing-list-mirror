From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rev-parse --show-cdup in .git
Date: Fri, 04 Dec 2009 09:32:49 -0800
Message-ID: <7vhbs6skzi.fsf@alter.siamese.dyndns.org>
References: <4B192EAE.8000806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Dec 04 18:33:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGc1d-0003UN-Hy
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbZLDRcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbZLDRcu
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:32:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbZLDRct (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:32:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E995B85CF8;
	Fri,  4 Dec 2009 12:32:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kK40rSv2MmnwTBmdQPhxrcUWfIw=; b=bUU1ol
	lcAhhD/tHkh7qqC9II95MjyZ6yl6O7z182HwZMweseVaodhoUnvRQb9lTJY6nnRc
	K/FHo432mJTbL5AjdhNwe2Vl46GMCUfoD3729d93xOXLsrq9tit6Dk4ccfni7gAT
	ngy0nHdWhYdrI6/TaEGTe9gS7nc5Wr7778SPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NsjUk8lVmsPrD9YEhZDgVtCd6ijV/mtf
	ue1v1/jWDfPrroIFZ8doqpsCzZSn/nn5+aZrBknqzwgsMaxCcgLOJl5jQMteBEtt
	AIORDJI/y47Xp1bGjSJz4spfLOvtegnv2wnQGLA7A1Xu74cd/57SsMv8d4y2U0dV
	lrSkW3S5mgQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C835F85CF7;
	Fri,  4 Dec 2009 12:32:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3421A85CF6; Fri,  4 Dec
 2009 12:32:51 -0500 (EST)
In-Reply-To: <4B192EAE.8000806@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri\, 04 Dec 2009 16\:45\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0DA2BDF8-E0FB-11DE-BCCB-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134552>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I'm sure this was discussed somewhere, but I can't find it:
>
> When called from within .git, git rev-parse --show-cdup returns nothing
> rather than "..", not even an error code. Is this intended?

I do not think --show-cdup should be linked to --is-inside-work-tree in
any way, if that is what you are getting at by mentioning "error code".

> This is all the more disturbing since the cwd of hooks seems to be
> GIT_DIR. Is that something one can rely upon? In that case one can
> simply use ".." for cdup.

I think you will see something that is different from and is more sensible
than ".." when you use GIT_WORK_TREE environment variable (or its
corresponding configuration variable).
