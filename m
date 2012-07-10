From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Tue, 10 Jul 2012 12:49:01 -0700
Message-ID: <7v1ukjiehe.fsf@alter.siamese.dyndns.org>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-2-git-send-email-cmn@elego.de>
 <20120710191354.GE8439@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 21:49:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SogQq-0004Q8-K2
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 21:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab2GJTtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 15:49:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49793 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072Ab2GJTtF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 15:49:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B506D8A20;
	Tue, 10 Jul 2012 15:49:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gH9dPNoSkVq0erX+puT2vw+qFss=; b=kyP74e
	1Uqm4dlSweZrhd1C0qBd7tXM8f2i8ZA76m3jG5LTDykq1E1+I0CWKFUTwqNQPcZh
	El8LADYYCNRu7pNjTZu1M4k0lvT96w0+lvT22QgOEkZ3Degg4Do1Yfz2AsiPuDJh
	8CG71vBTebEBeZu8FO1WaUcNvKtvhVyn5YUxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A6zvVTlVFsBDIG5b6CzndrVBykMhEIpV
	CdRvBggshS0TmDf0Z0X07PM9c1whZY6W18jDzKXBV/1bsQNlBhrFxCBdA/sbhqm6
	FsQjoHVqdl9oxBI0EXiXj9ZUSorPE4l2PI5QNO4NJD4cyoIDxkzXHs3cBbgf0RVk
	dhjMH4ueGOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC2F78A1F;
	Tue, 10 Jul 2012 15:49:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDC4D8A1C; Tue, 10 Jul 2012
 15:49:02 -0400 (EDT)
In-Reply-To: <20120710191354.GE8439@burratino> (Jonathan Nieder's message of
 "Tue, 10 Jul 2012 14:13:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CC20C28-CAC8-11E1-8DD5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201272>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> The existing --set-uptream option can cause confusion, as it uses the
>> usual branch convention of assuming a starting point of HEAD if none
>> is specified, causing
>>
>>     git branch --set-upstream origin/master
>>
>> to create a new local branch 'origin/master' that tracks the current
>> branch. As --set-upstream already exists, we can't simply change its
>> behaviour. To work around this, introduce --set-upstream-to which
>> accepts a compulsory argument
>
> Thanks.  A part of me really dislikes this --set-upstream-to which
> is named more awkwardly than the deprecated mistake it replaces,
> though.

I am not super excited about it either, but at least it is a vast
improvement compared to the older one, with which it was entirely
unclear if we are setting the value of upstream *to* what is given
as an option, or setting the upstream *for* what is given on the
command line.
