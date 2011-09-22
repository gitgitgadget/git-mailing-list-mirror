From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Thu, 22 Sep 2011 12:22:51 -0700
Message-ID: <7vk490xtys.fsf@alter.siamese.dyndns.org>
References: <4E7A3BDE.3040301@alum.mit.edu>
 <7vy5xh1whq.fsf@alter.siamese.dyndns.org> <4E7AF1AE.5030005@alum.mit.edu>
 <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com>
 <20110922171340.GA2934@sigill.intra.peff.net>
 <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 21:23:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6orM-0003S3-2C
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 21:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab1IVTWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 15:22:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49626 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753600Ab1IVTWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 15:22:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4408D6675;
	Thu, 22 Sep 2011 15:22:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mNmXvW/5UoyWZaGl7ahICE7ri3s=; b=lxXiG1
	GbOJPMhdPlFgKvWtGHlmr4fplA1RH/J7D+fauDVESjGFVTCLYC/eieixG860I6CC
	IrQCpFokWbGzUHc1L0FVR/YyX9yEw7ruiwEJKvIT8jpOOBYuMzVwSB4RFWXoV+8Q
	N0RWGV3HzdZZh3fgXrQk4d5nqp3+3Elrbswk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ne92Jze5Zy2JJaKW44omqc6hYAkW69KZ
	oB1rdUO5jrn4fqnIDukrcZ68ZPJNCWNHui3e0+/8TZ3rsBVF4bVQ1WoDIh1P1Cwl
	ZOg8hzvvowe3N7uOXxEjoNbrHTlFFV7I/O4XP/EZxcYyFWgcXCb/pvc5dxhYfXhd
	qcoEQUzFa1g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C55D6674;
	Thu, 22 Sep 2011 15:22:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C94946673; Thu, 22 Sep 2011
 15:22:52 -0400 (EDT)
In-Reply-To: <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com> (Jay
 Soffian's message of "Thu, 22 Sep 2011 14:41:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 445F64C6-E550-11E0-82C3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181912>

Jay Soffian <jaysoffian@gmail.com> writes:

> Consistent with that, when comparing two commits (diff-tree), I think
> you look at the .gitattributes in the second commit.

That would make "diff A B" and "diff -R B A" behave differently.
