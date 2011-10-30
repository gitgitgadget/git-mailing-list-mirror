From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] define the way new representation types are encoded
 in the pack
Date: Sun, 30 Oct 2011 00:11:23 -0700
Message-ID: <7v4nyrrm1w.fsf@alter.siamese.dyndns.org>
References: <7v62j9veh3.fsf@alter.siamese.dyndns.org>
 <7vwrbptzjm.fsf@alter.siamese.dyndns.org>
 <CACsJy8Cz0R_s+VYRd+1wTTfbt_vH5dd3ALgZip0xn7rfYf6gpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 30 08:11:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKPYJ-0005oK-7Y
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 08:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab1J3HL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 03:11:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51474 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548Ab1J3HL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 03:11:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B91E24D4C;
	Sun, 30 Oct 2011 03:11:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kSyKfQimQValkZtYJt8b/bDQ53o=; b=GmFATV
	nJiuir6izK+UxLpmB+FWTkYVpQeUJuiA8TKA+qf05THaa+QYFGTIVK5/pMsSET8h
	wI8Gys2hfEvS6jqfaWuEWmfrok+3va4+BXMW6c7YqcHVoiUHIWnXzOnRI+eVgl3/
	8krGb1Vnz0u1jx9saV5mcBadGU0u6nSkh44SU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AXbzyD5CQQT5ieq2HWmx7C/u+sl/6lSG
	8hDzQP4XVUGvMiMJTvNc8nV64aoQ/3nyvqK709gmkKLuf6PI0mFu8sZvJYsmQiog
	lC2MPkLF5xd0baT74hBLarh9h9R0sstbojDG83SX9gCNeJvEEiQirxkQYk63Svqs
	SCy2ndGUXYg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0FB94D4B;
	Sun, 30 Oct 2011 03:11:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F1494D4A; Sun, 30 Oct 2011
 03:11:25 -0400 (EDT)
In-Reply-To: <CACsJy8Cz0R_s+VYRd+1wTTfbt_vH5dd3ALgZip0xn7rfYf6gpw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 30 Oct 2011 12:40:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 610AAB10-02C6-11E1-BAC0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184465>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Because all blobs in this tree object must be in a fixed order, and
> they won't likely have meaningful names nor permission, should
> CAT_TREE payload is a SHA-1 sequence of all blobs (or cat-trees if we
> want nested trees) instead? IOW the tree is integrated into cat-tree
> object, not as a separate tree object.

I have no problem with that (I am not worried about minor details of the
actual implementation of cat-tree yet).

> Not sure if it's related to representation types, but is there any way
> (perhaps FLAT_BLOB type?) we can mark an object uncompressed, so we
> can mmap() and access it directly?

In pack? Loose? Both?

What kind of payload and use case do you have in mind?
