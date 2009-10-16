From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git describe without refs distinguishes dirty
 working tree
Date: Fri, 16 Oct 2009 13:37:17 -0700
Message-ID: <7veip3t6rm.fsf@alter.siamese.dyndns.org>
References: <dffdbd190910160812h6d6a876el8261a622b5439b30@mail.gmail.com>
 <20091016173902.GT10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean Privat <jean@pryen.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 16 22:37:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MytYM-0005lE-Fm
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 22:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbZJPUhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 16:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbZJPUhY
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 16:37:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbZJPUhX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 16:37:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 879FD7ADEF;
	Fri, 16 Oct 2009 16:37:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NNd1W0sxlfe5qQolEMpYdHK6pA0=; b=Mzo6qM
	fw6kFV7k2SXMWeE/IP28GDQkFO0JeSLTvP71CS9kKgw/exYvMYozHWyUs99CakbF
	qZG9F1e62K/DOPsnjplyzO/yPtg2cbYZtaXCMg0ggJJZC5pSSU6uIIZf3APHVwIc
	ewglXOErD7e+/7jPbiCEdw3TcMHwQEBgSD2wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qeJn/sTOIueV+TPKK/rHLSfOHAOdjI8h
	A50x5o5C1HQqyUEjUgJIQMxJ9MSXbDNb0YsMMX2lUuL8zqRis6t1pt9yvg+Ycfk6
	5gD48pPywaB5nonEbznAgC2NG6RxTVkCUDSSVwq+hTkWUe+VkCUC+/UbTBTDRZ/J
	YhQlt4PCLJg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 599887ADEB;
	Fri, 16 Oct 2009 16:37:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E9F247ADE6; Fri, 16 Oct 2009
 16:37:19 -0400 (EDT)
In-Reply-To: <20091016173902.GT10505@spearce.org> (Shawn O. Pearce's message
 of "Fri\, 16 Oct 2009 10\:39\:02 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B5F01CA0-BA93-11DE-B30A-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130526>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Yea, 1.7 may be safer for this, but also many scripts are based
> on the GIT-VERSION-GEN in git.git which uses HEAD as an explicit
> argument.  So they might actually be OK with this change.

Well, from my cursory look of its scripts/setlocalversion, even the Linux
kernel is not safe X-<.

I still haven't heard anything that helps me to decide which way the
default should be.  The only concrete thing I have heard against the
change of the default is that it will break existing setup, but I haven't
heard anything concrete for the change yet.
