From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git & patterns
Date: Wed, 18 May 2011 23:47:19 -0700
Message-ID: <7v62p79og8.fsf@alter.siamese.dyndns.org>
References: <4DD3A402.3040802@hupie.com>
 <7vsjsbbx7h.fsf@alter.siamese.dyndns.org> <4DD4B772.2050404@hupie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ferry Huberts <mailings@hupie.com>
X-From: git-owner@vger.kernel.org Thu May 19 08:47:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMx1C-0002O1-CB
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 08:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633Ab1ESGr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 02:47:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932304Ab1ESGr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 02:47:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1685A3158;
	Thu, 19 May 2011 02:49:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5L5b0lTzjkCae7UMFe7hw3gTBYA=; b=Tu1gHW
	92DyVITMMq2bP2CIdkR3uCTcEvjAoTC4o9RRGn00li6Ffos7xyIcrbLOz6UY4d+a
	eytv91c92eKeiGXD5oHSqdLUvojzMXi6jnThlpdMnblCe6ThbxX4IW3MdExEa6fw
	Akkkkbd0qyTc5YJN4RqNfIzSqSACzg8XLfrPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M8SjYhnioJ/QnRqld1rmVm9T6UFP5L5m
	hhR7juTX9J0DQg0FXAfI3HxGK9JZYXqDV1cOOZzjyvM3EuQvOxIRE6EtePzBEslo
	0mrYzXevd0EOlW+qwAJYEQZaobLg4PK6pYzPIkQOGh46+LAWahvHTWcqzKLKiNrc
	kwOyP+Vyqxs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E7DC83156;
	Thu, 19 May 2011 02:49:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 117243155; Thu, 19 May 2011
 02:49:28 -0400 (EDT)
In-Reply-To: <4DD4B772.2050404@hupie.com> (Ferry Huberts's message of "Thu,
 19 May 2011 08:23:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 266F38B2-81E4-11E0-9080-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173937>

Ferry Huberts <mailings@hupie.com> writes:

> - usually patterns are just patterns, without specifying what kind

> - when a pattern type is specified it most of the time is a glob pattern
> - but sometimes it is called a shell pattern
> - and  a few cases speak of a wildcard pattern (I think)

All these three are the same thing. I do not personally feel any strong
need to change a lot of documentation to use only one of the terms, if
that is what you are getting at.

What I was wondering was perhaps we may need to document the general
principle of using globs when matching names that are hierarchically
grouped with slash-delimited components.

The branch and tag namespaces are examples of such hiearchically grouped
namespaces, and it is not a mere implementation detail as you seem to
think. For jk/blame-line-porcelain and jk/diffstat-binary are both branch
names, grouped by name initials of the author, and the globbing jk/* is a
way to get to the group. With that grouping present, you cannot have a
branch called "jk".
