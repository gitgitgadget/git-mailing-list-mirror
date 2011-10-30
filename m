From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] define the way new representation types are encoded
 in the pack
Date: Sun, 30 Oct 2011 00:13:51 -0700
Message-ID: <7vzkgjq7dc.fsf@alter.siamese.dyndns.org>
References: <7v62j9veh3.fsf@alter.siamese.dyndns.org>
 <7vwrbptzjm.fsf@alter.siamese.dyndns.org>
 <CACsJy8Cz0R_s+VYRd+1wTTfbt_vH5dd3ALgZip0xn7rfYf6gpw@mail.gmail.com>
 <7v4nyrrm1w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 30 08:14:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKPah-0006P7-32
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 08:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408Ab1J3HNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 03:13:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279Ab1J3HNx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 03:13:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E7324DD8;
	Sun, 30 Oct 2011 03:13:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xSgy4q3hsmQQtZQtNmYez4GDB1g=; b=rIhxH3
	4f+MVWkYL+fnTj9/FkJmZl0LBGmD413eShld0KS0UuogWmnzyszuno+DwnU4QDvP
	c4ldo5e9yRlOnymxJyvNCzbn9zZOsC/VhRloUBfqY9tn6O4n2frcWfETtTvMgh4y
	M+Q+g6AqqCGpmAQxOMse+Thnc/qUeQcsvTQds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mjElGN9RrHfd84h4ydF0BBU/piquvkCW
	wQyGfePK+wOg/N+d5vPR8P0FA8BPjfZDkwBmAIP44gNMI+o4qpRO8AftKj/T+lCz
	+irJcI2vYakADdFo5XIXWkvfE/4SeI0KJLSHbFkydhbCTtQqn3ShtZBuuBFsoN9w
	ta1KVuANSVI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 367904DD7;
	Sun, 30 Oct 2011 03:13:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1F584DD6; Sun, 30 Oct 2011
 03:13:52 -0400 (EDT)
In-Reply-To: <7v4nyrrm1w.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 30 Oct 2011 00:11:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8FAEE3E-02C6-11E1-A1F6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184466>

Junio C Hamano <gitster@pobox.com> writes:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> Because all blobs in this tree object must be in a fixed order, and
>> they won't likely have meaningful names nor permission, should
>> CAT_TREE payload is a SHA-1 sequence of all blobs (or cat-trees if we
>> want nested trees) instead? IOW the tree is integrated into cat-tree
>> object, not as a separate tree object.
>
> I have no problem with that (I am not worried about minor details of the
> actual implementation of cat-tree yet).

Side note. It should be renamed "split-object" or something if we go the
route you suggest, as "tree"-ness of the actual representation is not
essential.
