From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/4] Providing mechanism to list available
 repositories
Date: Wed, 14 Jul 2010 12:11:15 -0700
Message-ID: <7viq4hyj3g.fsf@alter.siamese.dyndns.org>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jul 14 21:11:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ7Mn-0002V9-VO
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 21:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757444Ab0GNTLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 15:11:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757427Ab0GNTLW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 15:11:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6630C4DE2;
	Wed, 14 Jul 2010 15:11:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=xH5eIOaPLeAIKkWA/h93PgITaMI=; b=qTCJk6f1SpV5mtiYiDHG4So
	68OmReRWnxFy6uDDLoQ02OrcXYq49wSEmG9cY6kVGDVY1yvba0fGYGokodAGw6NR
	NzBwwkKTLgqyYa3AMqelGt5bjJCMtSihjlUo6cUUHYeBAdBqYo6sOPFueDy/st2r
	KA8xctMgHLYpu0tM3Vzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=NM/qDD6lCGIGcDBbvxiS0g0IucZk98Lq2bhBqhQzqsH1CuNvl
	kXiTDBrvFSy83/C8RxwPy0T2mbbAb+R+l0iDPnuQ79wh7PuvUADuCWFiNbgQECo6
	W2okG3w/YqXiUggcBzALKJJug+9wKcU9E4cJWVmUyN/UPCd5J1T0aH8plw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC860C4DDD;
	Wed, 14 Jul 2010 15:11:19 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C532C4DDC; Wed, 14 Jul
 2010 15:11:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 958FAA3A-8F7B-11DF-9542-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151028>

Greg Brockman <gdb@MIT.EDU> writes:

> We find this mechanism useful in that it requires no extra
> infrastructure on either our end or the user's end.  Our
> implementation is extensible, allowing the system administrator to
> place arbitrary commands in ~/git-shell-commands (if the directory is
> omitted, no extra functionality is exposed), and also supports an
> interactive mode.
>
> What do people think of this approach?  I'd love to get this
> functionality merged in some form.

It seems to me that any time you need to add a new helper command, the
administrator needs to make sure that appears in ~$user/git-shell-commands
of all the users who need it.  When adding a new user, a similar
management action needs to happen.  Perhaps that is done by making a
symlink from all the users' home directories to one shared place.  Is that
the general idea?

In any case, I'd prefer that the sample command implementations like list
and help to live in contrib/ somewhere.  They are not part of what the
main Makefile needs to know about, right?
