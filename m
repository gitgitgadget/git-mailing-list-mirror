From: Junio C Hamano <gitster@pobox.com>
Subject: Re: verify signature hook
Date: Mon, 29 Apr 2013 09:42:03 -0700
Message-ID: <7vy5c1jnl0.fsf@alter.siamese.dyndns.org>
References: <CAH_OBieXyHuQBpG7Ge1wA4Q+MKBEy7MD-TpZmMLZjEF0jAzLwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 18:42:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWr9d-0004al-SA
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 18:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758510Ab3D2QmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 12:42:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63851 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757025Ab3D2QmG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 12:42:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB0F51A260;
	Mon, 29 Apr 2013 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rEXS+qjxwOSC8c6JTu606IdEWk0=; b=LSTf21
	5+MI/tAlpTSNH/FQPQiwvKXSc89NdM/Z9Gmi6XZu1h0KtH+qdLuHeqtGHGG0vkRx
	luA4lmmjB85Dt7EOHxf01dZYUr0pVMxOwAjShiT9d8S2gzGK3Qkh3aVe6qyZG1sm
	Fcf2xbRljSEqqkuv2oFGkpMuwoKGockG1qTbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KjIZp1l7UEDkjJ9PuTtSCy/5q3vkIX1+
	Ll264kaZagS9tUXKMX48yJn5LS6go1I1TOe86wMOgQAXruOfciQquvqElhCrBQBy
	cB8/qEMhPNKtnL74/l+GqgU9hjisVkyUpsvcQ5erjDz/vnvMXSNp8GQZ4L4hCBdb
	bizGbqEMHlg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BED991A25F;
	Mon, 29 Apr 2013 16:42:05 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 482AF1A25E;
	Mon, 29 Apr 2013 16:42:05 +0000 (UTC)
In-Reply-To: <CAH_OBieXyHuQBpG7Ge1wA4Q+MKBEy7MD-TpZmMLZjEF0jAzLwg@mail.gmail.com>
	(shawn wilson's message of "Mon, 29 Apr 2013 12:32:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9A66CC6-B0EB-11E2-A826-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222813>

shawn wilson <ag4ve.us@gmail.com> writes:

> How do I complain when a commit/merge/tag/etc aren't signed?

At which point?  A natural place would be to detect this just before
accepting a suspicious history being pushed in pre-receive hook, I
think.
