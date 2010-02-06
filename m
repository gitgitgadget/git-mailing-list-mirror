From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] rebase: add -x option to record original commit name
Date: Fri, 05 Feb 2010 17:35:47 -0800
Message-ID: <7vzl3ngn7w.fsf@alter.siamese.dyndns.org>
References: <1265419166-21388-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 02:36:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdZab-0004Wz-0k
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 02:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933817Ab0BFBfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 20:35:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933202Ab0BFBfy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 20:35:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1950997AA1;
	Fri,  5 Feb 2010 20:35:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zE07401EKqWQBVOZVNDk5juMR9g=; b=TYbmDs
	N6tvP0e1dek5zlet0yVZCBLVNpuZf8zZ45JEgw+KTu9MA5ewohGqaTafamZM7nVx
	EPp5Unk5vlKgyZi8fIetVovQ3H+/qXR5nQUc/X8RQzWRCRu2BtOIZJslaJ04LH1+
	g86tUswWHJ3b3/hkeUz00w1Wk19nBUKDpGmfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hbl4zyp/+ayoy2pg6dFSLed7ToB1adac
	WBcBBLz1b4SAXrmZ7AC/MbXDJLE46BHXa6AjsBS/R6+Xa6mxx/tgIu4sVQ4DxbWu
	GKXjESr5fcF0KpbjeAsUTUrabtyOOnxeP1QsEzLdWlEMPKlHE/kA+rv1+0rA1qJj
	jgeAHk4tTCU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB7A597A9F;
	Fri,  5 Feb 2010 20:35:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5658497A9D; Fri,  5 Feb
 2010 20:35:49 -0500 (EST)
In-Reply-To: <1265419166-21388-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Fri\,  5 Feb 2010 20\:19\:26 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F5FB93B8-12BF-11DF-9C81-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139136>

Jay Soffian <jaysoffian@gmail.com> writes:

> Thoughts?

In the longer term, we would rather deprecate -x from cherry-pick, so that
we won't contaminate the commit log message.  So in that sense, I would
give a mildly negative response to this patch.

We might instead want to add a hook that is called from cherry-pick (and
rebase will get a similar one) immediately after the command creates a new
commit out of another commit, so that people can record the correspondence
in notes namespace if they choose to.
