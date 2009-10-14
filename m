From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodule-summary
Date: Wed, 14 Oct 2009 15:42:08 -0700
Message-ID: <7vskdla98f.fsf@alter.siamese.dyndns.org>
References: <7vfx9pmhae.fsf@alter.siamese.dyndns.org>
 <4AD61880.4040600@web.de> <7vfx9lbtpf.fsf_-_@alter.siamese.dyndns.org>
 <4AD6423D.10307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 15 00:48:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyCdo-0003sC-1L
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 00:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762092AbZJNWm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 18:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762089AbZJNWm5
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 18:42:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761499AbZJNWm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 18:42:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B4CF17784A;
	Wed, 14 Oct 2009 18:42:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aQAxg6m1ZlilUyNICEtHKQGsjzs=; b=SSeJvj
	TxWcSPWl7kN6iixtk6jMCP5LRC9Ms1Yc1cBSOiwcd3xn7jwCzidvvEgDtIOzucUS
	3odj0F9IwI4gnELlhGiDW91yIgGoy9KPNfZ1OaVXtWsMvrHS2tpAG6i21dGPSolK
	boQlMzfdVe3lfgJRAnCMSY0q+2+dkx6+++i8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pkNt2eH87ahtvlay2XkRWyalcOLHVVOQ
	1w8QnyPM260qGcQlvnCjBsFk0EmT/k9IqZ79M8Zsp1cSNPUmtuy/o0S/BxcAcfD5
	BdM6oXeS2t5EIeq47M3b9Y18wCgrJxJCHHRrsvRUz7V0x+4/x+ZmxecmuohPrJn2
	WeG0oWgQNrw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9785C77848;
	Wed, 14 Oct 2009 18:42:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ADBFB77843; Wed, 14 Oct 2009
 18:42:09 -0400 (EDT)
In-Reply-To: <4AD6423D.10307@web.de> (Jens Lehmann's message of "Wed\, 14 Oct
 2009 23\:27\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D07848EA-B912-11DE-BECD-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130347>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Good point. (Personally i like the options --submodule=shortlog and
> --submodule=twoline. Because IMHO --submodule=summary could make
> people expect similar output to git submodule summary, no?).

Well, _that_ is something we could fix in "git submodule", isn't it?

Right now, the only way "git submodule" command can summarize the changes
is by showing a left-right shortlog, but it wouldn't be so inconceivable
that somebody may come up with different and equally useful way to show
them, e.g. diffstat, and at that point, we would probably want to have
"git submodule summary --stat" or "git submodule summary --shortlog" (and
the default being --shortlog).

I am _not_ married to the naming "shortlog", by the way, and shortlog is
rather a bad name for it.  Sorry for suggesting it; it is quite different
from the actual "git shortlog" command output (and no I am not suggesting
to make the output similar to shortlog), but rather is more similar to
"log --left-right --oneline".  But I think you got the point.
