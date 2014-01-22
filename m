From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Makefile: Fix compilation of windows resource file
Date: Wed, 22 Jan 2014 12:14:56 -0800
Message-ID: <xmqqeh3zydrz.fsf@gitster.dls.corp.google.com>
References: <52DD857C.6060005@ramsay1.demon.co.uk>
	<xmqqy529t5bb.fsf@gitster.dls.corp.google.com>
	<xmqqppnlt3u3.fsf@gitster.dls.corp.google.com>
	<52DEF9F2.1000905@ramsay1.demon.co.uk>
	<xmqqk3dssxpb.fsf@gitster.dls.corp.google.com>
	<52DF6B6C.4020708@viscovery.net>
	<xmqq38kgyozt.fsf@gitster.dls.corp.google.com>
	<52DFF4E8.8060605@viscovery.net>
	<xmqqppnjyl10.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 22 21:15:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W64Cq-0005wk-Hh
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 21:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbaAVUPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 15:15:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39114 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbaAVUPI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 15:15:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00C8A649FA;
	Wed, 22 Jan 2014 15:15:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mqlnUpCYjODZHWe8XPBOd23D1N8=; b=nbeS9r
	8vp+NbxIaS1Lu45QSztxc2SBj4GqK6INgDXVZPFZ2otuFGqDKnOWHZGeSFQs2Cdm
	hy/9IH/y//q7BEDV4hwfdmULoMjPA0Xw+e1FGs71aK7bLKi8o6PXSl5Qucp7YIfI
	a1fZeaR+ATXf/3CdzzWNk6QbaIVFU7IoGRACc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x7QklDMqIHUh0tY/3C3T8ptcvKH0S340
	Hcjp8cvGesX83iY1whsPSHEzTDyxTn3HfQmDpc+Iud0XnUjyF25aQYN04hnSv2ro
	TYwJbyHj0ix5fGlsGxv0nEfqEI2up9YD++v55QvCM7FFfR2MuwA0TfIxRqSos1Vp
	zAN8I01jWUE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC60F649F8;
	Wed, 22 Jan 2014 15:15:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2A6E649F0;
	Wed, 22 Jan 2014 15:14:58 -0500 (EST)
In-Reply-To: <xmqqppnjyl10.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 22 Jan 2014 09:38:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DE13932A-83A1-11E3-B8F7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240851>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j.sixt@viscovery.net> writes:
> ...
>> ..., I suggest that we just punt (as per
>> my patch). That should work out nicely because we can fairly safely assume
>> that there are no installers around that look at these particular version
>> numbers.

OK.  I do not think we care too deeply about how a "forced to be
four dewey-decimal numbers" looks compared to 2 or 3 numbers in the
$(GIT_VERSION), as I think we always had that (non-)issue, but not
being able to compile is not very nice.

So can you, Pat or Ramsay send a tested patch with a proposed log
message?   Preferrably by -rc1 but I think the change is low impact
that it can be in -rc2, leaving -rc1 broken.

Thanks.
