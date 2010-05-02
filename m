From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/5] pretty: make %H/%h/etc respect --abbrev[-commit]
Date: Sat, 01 May 2010 20:13:00 -0700
Message-ID: <7vocgzyp1f.fsf@alter.siamese.dyndns.org>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
 <1272656128-2002-3-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, raa.lkml@gmail.com,
	jrnieder@gmail.com
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 05:13:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Pcq-0004mW-Os
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 05:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484Ab0EBDNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 23:13:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370Ab0EBDNN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 23:13:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07264AFFC8;
	Sat,  1 May 2010 23:13:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=uxzhz+qRsfjJDhLyLlwaj2bF1RE=; b=GmBf6ehZ4OCQsR6uz4snJnL
	ox4NZCk5sX70caEVJ2kXtLP7AL8jrUCwGvr5T0mD7YldFUbSy6iJ+Sk5a9W5gwoo
	Fv0QfHZvwgZMDPQdS7HVvvfaBXaS1ZrAF45iVeP9n4t4uYXbeNxmzSlBGdwgxAlQ
	tsnaA6b6O3P2Mg199fgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=vMJH0dgydLDkp/JvoVY1CSpUIbIf/l6N2A39gusQlWENH5obg
	dA1QwXzeA1BPmD2WQFDMbo+dHKExAHEpMWppnUlM4KhUoTfC05/LHwO2rWz5ePmm
	ee/b0wvSteWvxv5tUXguk0VmaChzWYpRSTFama5wbuvIpYPV/+tUqWJNvk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A8F51AFFC6;
	Sat,  1 May 2010 23:13:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DACCCAFFC4; Sat,  1 May
 2010 23:13:01 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A175BB36-5598-11DF-9E8C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146127>

Will Palmer <wmpalmer@gmail.com> writes:

> Prior to this, the output of %H was always 40 characters long, and the
> output of %h always DEFAULT_ABBREV characters long, without regard to
> whether --abbrev-commit or --abbrev had been passed.
>
> Here we make "git log --pretty=%H --abbrev-commit" synonymous with
> "git log --pretty=%h", and make %h/abbreviated-%H respect the length
> specified for --abbrev.

I think it is a good change to make %h follow --abbrev, but %H should stay
the full length no matter what (otherwise why would anybody use %H not %h?).
