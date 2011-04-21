From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/9] sparse: Fix errors due to missing target-specific
 variables
Date: Thu, 21 Apr 2011 13:35:17 -0700
Message-ID: <7vliz3xrzu.fsf@alter.siamese.dyndns.org>
References: <4DADC729.5060705@ramsay1.demon.co.uk>
 <7vbp025clq.fsf@alter.siamese.dyndns.org>
 <4DB0804C.10908@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Apr 21 22:35:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QD0bB-0007iv-Qu
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 22:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737Ab1DUUfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 16:35:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab1DUUfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 16:35:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 842D33EA6;
	Thu, 21 Apr 2011 16:37:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4gVMTID+/6xyji+FpOvHk4pGE90=; b=QmC7SF
	5Yg2hjYKT4/UuPxwW+Y+meSL+H5c6ZWG/1Kij4YPmIG8zHiyUdhbymuoCSiXw8nU
	trafk2AQ9yANUHi1JkerO0ELz80iTMtbcAl8tYoDgAR7jQo/D0yCBSsqUvgNOSWk
	RdDWzT8PReXe7TULFHkgTpHJP8md5+UbOrhJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qjEnZ7yMYjQz3kuq2oWH9YSic3Hb1VOn
	kZir2fJjnTrlssKljSMMzwBwBMFV2K7jy6wkuWiynzj+SBhdzuDuwPnjkLx5jBjF
	XHyzSRxn1M7VSeO9vq8eOLe03ICZxRvRZvRZImtwW7T+K8wuT2qfBsNZp8lpeftW
	fwhObhmqfoI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 518743EA5;
	Thu, 21 Apr 2011 16:37:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F3D9F3EA4; Thu, 21 Apr 2011
 16:37:18 -0400 (EDT)
In-Reply-To: <4DB0804C.10908@ramsay1.demon.co.uk> (Ramsay Jones's message of
 "Thu, 21 Apr 2011 20:06:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29EBE262-6C57-11E0-9998-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171917>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

>>> -help.o: common-cmds.h
>>> +help.sp help.o: common-cmds.h
>> 
>> I am not sure if you even want any dependency listed for any %.sp target
>> to begin with. 
>
> without these common-cmds.h dependencies, I get something like:

Ahh, of course.  I failed to spot that you are depending on a file that we
build ourselves.  Silly me.
