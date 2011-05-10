From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] sparse checkout: do not eagerly decide the fate for
 whole directory
Date: Tue, 10 May 2011 16:37:55 -0700
Message-ID: <7vliyegm98.fsf@alter.siamese.dyndns.org>
References: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
 <1304340464-14829-3-git-send-email-pclouds@gmail.com>
 <BANLkTikgNR1G5_TO3rmMZy3fN2PNF2Pqjg@mail.gmail.com>
 <BANLkTimDO7yRyiBt7xS5Hy7-iT5SUDwJtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	skillzero@gmail.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 01:38:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJwVK-0006RO-39
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 01:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab1EJXiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 19:38:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980Ab1EJXiH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 19:38:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1399B4E01;
	Tue, 10 May 2011 19:40:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Kt1gaZ9TQJj2DOCAqaofZ4WKe84=; b=R8SEqiJK6RrgoFy8RJoG
	3w5DFyr71f3k4zMEzQx9C0fZO0ReCIYLndymGDzS1dBI1LRRA/APIJefV5CNGQFj
	HscVTulayFhPA5T1fb61rrBdFULDVD925WRR0fF4rfZfouCImRP7q3tFGl6g80AH
	NDkLPQDdckpZ+JFbtCC0NsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=IP9NWDcj0//VE/TGxyNJgWBqTWLJSEsrx+3p9ks5462b6T
	2KSs94yjc/XDpQQYOwWaoPep+RQbFk0Rd5cktVIGC3tOKJWEPD/onWMEMSPK9Ck7
	DPtH31eoQW0WZ/kEFDNmrDZXBrN5+3cIyffS8rDrJpFHJJ6hWYGaE83LfbZ94=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C77494E00;
	Tue, 10 May 2011 19:40:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 732114DFF; Tue, 10 May 2011
 19:40:02 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6848D06-7B5E-11E0-A01E-B44DF9BAD297-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173383>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>>> +       /* If undecided, use parent directory's decision in defval */
>> What means "use parent directory's decision"? Could you make this
>> comment more clearer?
>
> Take the example patterns in commit message, we know that we match
> directory "t" (pattern 1). When we check t/0001-init.sh, no patterns
> match it. But because it's under "t", so we consider it matched. On
> the other hand, t/t0000-basic.sh will match pattern 2 and override
> parent directory's decision.

Somebody ask about the comment you wrote, and you had to explain it.
Doesn't it tell us something about the readability of the comment?

After all the request was "Could you make it clearer?"
