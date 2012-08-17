From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make 'git submodule update --force' always check out
 submodules.
Date: Thu, 16 Aug 2012 20:23:57 -0700
Message-ID: <7v7gsyxktu.fsf@alter.siamese.dyndns.org>
References: <1343239412-26780-1-git-send-email-szager@google.com>
 <7vipdbbs0b.fsf@alter.siamese.dyndns.org> <50105C60.4050303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 05:24:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2DAN-0000Wj-7k
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 05:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933688Ab2HQDYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 23:24:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933650Ab2HQDX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 23:23:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B09C8115;
	Thu, 16 Aug 2012 23:23:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+g9fg82mKreEgSN00y8dIKkl8pE=; b=NB3ILm
	7nRlnnEFvG/DUvBFA9Y5KTfrJkmMquuHPZs1946H8hr9MeiN6kI8MN3lwia3GMhv
	oYWcojq0jMq2D+xE+o5E4auebrnyGVCFWv3pgYzQpPJmv9s5Rp3hII1yIq4A0tyZ
	x+eJNOh8dy7tGsoYTj/OyRaHg+AaBkZ9EP3Hg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H3BjBLlHie3I2fdGMBa2IMzet8DUvcIm
	AypVzpicS8xi83Pqpqy9DZxaexfPokN/QGNPuvxfKEm0PsvCBBBbyRgG/0w64Ngq
	G37kebk0GfRAKTq7En72drTFT0X2R/Tn01ArcoRLyfwf2VWoLJekmL9xREyQP7is
	6XMdiwvop54=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 184A18114;
	Thu, 16 Aug 2012 23:23:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C4118113; Thu, 16 Aug 2012
 23:23:58 -0400 (EDT)
In-Reply-To: <50105C60.4050303@web.de> (Jens Lehmann's message of "Wed, 25
 Jul 2012 22:51:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB9A8AB2-E81A-11E1-A69F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 25.07.2012 20:44, schrieb Junio C Hamano:
>> Stefan Zager <szager@google.com> writes:
>> 
>>> Currently, it will only do a checkout if the sha1 registered in the containing
>>> repository doesn't match the HEAD of the submodule, regardless of whether the
>>> submodule is dirty.  As discussed on the mailing list, the '--force' flag is a
>>> strong indicator that the state of the submodule is suspect, and should be reset
>>> to HEAD.
>>>
>>> Signed-off-by: Stefan Zager <szager@google.com>
>>> ---
>> 
>> Looks sensible (again -- see http://thread.gmane.org/gmane.comp.version-control.git/197532
>> for the original discussion).  Can submodule folks Ack it?
>
> I like it. Still I'd vote for amending the documentation like the
> original thread proposed and would appreciate to have a test or two,
> but apart from that I have no objections.

Mind ping on missing follow-ups.
