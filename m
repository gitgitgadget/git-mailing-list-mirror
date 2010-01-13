From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] Documentation: warn prominently against merging
 with dirty trees
Date: Tue, 12 Jan 2010 22:55:35 -0800
Message-ID: <7vtyuqtrx4.fsf@alter.siamese.dyndns.org>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <e330d8ca1a9ec38ce40b0f67123b1dd893f0b31c.1263081032.git.trast@student.ethz.ch> <20100110044949.GA8974@progeny.tock> <7vskaefp2v.fsf@alter.siamese.dyndns.org> <20100111021322.GA8480@progeny.tock> <7vzl4lbcfl.fsf@alter.siamese.dyndns.org> <20100111041318.GA9806@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:55:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUx8v-0000l4-3E
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 07:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab0AMGzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 01:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753277Ab0AMGzp
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 01:55:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab0AMGzp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 01:55:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EB6C90008;
	Wed, 13 Jan 2010 01:55:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=zcoa2zezt90Lh77aTUDy5iUNzmM=; b=VNeiwlaVkzVsDmwF0mjUREI
	b97TbCKBUBmrS0NtHa8JT2jxW+r8P/R5UtSgW6aC8liFBKZyV8yaib95MQIIX+De
	Oa3WWZ62vIacpasSLEM9IYnCm+gwHnodsNpK64peilJxrgnUkioc2nbACiQRGAio
	1CwSQ8IUwl/pEOgecYDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Q6loLyj4Ou0rNGkUvvD4fbJffP85ZkyqhLRLO+vdjixGdt1ZW
	r3Omu0+fP6YNIi23fAbWgsPqr2O4GRLclpuiQofP/9bowsGHoijLOE+d0B0OU92w
	KsOfZ0LeJi0VeC3faFv6UgfyrGIM5M8n8XTAJq8R4XXK2PFvFwf1D5p0+g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CCA290005;
	Wed, 13 Jan 2010 01:55:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CEBF91000; Wed, 13 Jan
 2010 01:55:36 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9CFF216-0010-11DF-8AAF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136773>

Jonathan Nieder <jrnieder@gmail.com> writes:

> | A merge is always between the current HEAD and one or more commits
> | (usually, branch head or tag), and the index file must match the tree of
> | HEAD commit (i.e. the contents of the last commit) when it starts out. In
> | other words, git diff --cached HEAD must report no changes. (One exception
> | is when the changed index entries are already in the same state that would
> | result from the merge anyway.)
>
> The potentially problematic scenario for "git reset --merge" is this
> last one, where a changed index entry is already in the same state
> that would result from the merge.  Would a "git reset --merge" reset
> the changed contents away?

It will discard the change, the one you independently picked up, but the
change agreed with what was done by the the trash history that you are
cancelling merge with.  You wouldn't miss losing the same change as in
that trash history.
