From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] build: "make clean" should not remove
 configure-generated files
Date: Thu, 19 Jul 2012 10:27:28 -0700
Message-ID: <7vbojbveyn.fsf@alter.siamese.dyndns.org>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
 <cover.1342649928.git.stefano.lattarini@gmail.com>
 <e763e7f466efa34f48589f8353a7316fff469145.1342649928.git.stefano.lattarini@gmail.com> <vpqy5mgdyro.fsf@bauges.imag.fr> <5007B780.7010500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 19:27:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SruVu-0008Qv-0w
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 19:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab2GSR1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 13:27:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462Ab2GSR1b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 13:27:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCB8079C8;
	Thu, 19 Jul 2012 13:27:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JNl7G2AYmgETtu/8u4IIIBMafDo=; b=tNCglm
	q+2HiU7LPdAMQo7Cmv4qH+DCvtPDVN3+Bz4k5qw5pO0/O9DbGI2l22wUHEO3KeZb
	w9A+1Z7nZJbxx38aS3Ww5jmubYDiHyatmuT14zU/59rmvNq0B4rmquygWlYwy//9
	hndRffTd66PwjiVsBWKmIH9FWrQi+kegYeW2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QGAuh4GmrdkvzAyZonuBLZFoHq8E+GWy
	QJl7cIc9pzxYSAi4bFUKTl++NnoGh8alRyIfCxJw1w7+IcdyuR2+9lYNPLO5Lvnm
	gcH3E6KXMFQFteJcv+feltPMGMCp4apSAh1JNfAQjzVIK5grcmWmuqG6QAJs5EGw
	GCBwb1+bnsA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A812079C6;
	Thu, 19 Jul 2012 13:27:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1397F79C3; Thu, 19 Jul 2012
 13:27:29 -0400 (EDT)
In-Reply-To: <5007B780.7010500@gmail.com> (Stefano Lattarini's message of
 "Thu, 19 Jul 2012 09:30:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 046EADFE-D1C7-11E1-B93F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201745>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> On 07/19/2012 08:56 AM, Matthieu Moy wrote:
>> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
>> 
>>> for example, an autotools old-timer that has run:
>>>
>>>     ./configure --prefix /opt/git
>>>
>>> in the past, without running "make distclean" afterwards, would
>>> expect a "make install" issued after a "make clean" to rebuild and
>>> install git in '/opt/git';
>> 
>> I've been hit by that behavior once. Thanks for fixing it. The patch
>> looks good.
>> 
> Should I add "Acked-by: Matthieu Moy" then?

Given that we see nothing in the ouptut from

 $ git shortlog --no-merges --author='Matthieu Moy' -- Makefile configure.ac

that remotely relates to the current state of affairs in this area,
I do not think we can say Matthieu _owns_ autoconf-related part of
the code in any way, so I do not think it is needed.

Thanks.
