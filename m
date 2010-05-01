From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fast-import crashes importing commits with more than one 
 author
Date: Sat, 01 May 2010 10:19:04 -0700
Message-ID: <7vbpcz5ylz.fsf@alter.siamese.dyndns.org>
References: <1272728636.27562.12.camel@localhost.localdomain>
 <m2ocgztw7z.fsf@igel.home>
 <g2x86ecb3c71005010947x662aad8bn1fc2950d741b07e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Giedrius Slavinskas <giedrius.slavinskas@gmail.com>,
	git@vger.kernel.org
To: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
X-From: git-owner@vger.kernel.org Sat May 01 19:19:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8GLd-0002Mi-A7
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 19:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693Ab0EARTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 13:19:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295Ab0EARTP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 13:19:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 29329AFC17;
	Sat,  1 May 2010 13:19:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=EF3kJ+5ZRa/UsudxY9NE3xrUVwo=; b=JPN3+v9jlwv/tAVvQNijxa9
	ZzJc4bSvcQJakTdpCngQjegC+ynxzjS3DPP+yQJulJhfmdszCJxqXXCpHlFwFpo7
	dywrrBwt3dxxQ1miWdoVkc2WPCCHTgxkpJyP463ooptut1EWQTFNrslLj1enxQdI
	csxiYW7fQrRJrmJiurDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=J59itdWTsxM611ZhE7GXomdzdu/7zNdjPBYwYfgTdw3kD74Z4
	u7teaAhuJ/omQD8jxEer5UmNig5Cx93RPXiryKbE2gXyCGaVgcyUMWrZauVnB04G
	SsbCCyq9WGN1g3giEX68rPWkr4m4hu07XSmDt7+/8IhW6cZUEZnHeb8JLk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D94C5AFC12;
	Sat,  1 May 2010 13:19:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20EC0AFC0E; Sat,  1 May
 2010 13:19:05 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A8450BB8-5545-11DF-A1D5-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146099>

Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com> writes:

> On 1 May 2010 17:36, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> Giedrius Slavinskas <giedrius.slavinskas@gmail.com> writes:
>>
>>> git fast-import does not support commits with more than one author. I
>>> try to import bzr repository and it crashes.
>>
>> You can find a patch here:
>> <http://bazaar.launchpad.net/~schwab-linux-m68k/bzr-fastimport/fastimport.dev/revision/262>
>>
>> Andreas.
>
> Although this is fine shouldn't we put the additional authors to the
> signed-off: lines in the git commit message?

If an author didn't sign-off in the log message, a tool shouldn't add it
automatically.  Doing so makes S-o-b meaningless.
