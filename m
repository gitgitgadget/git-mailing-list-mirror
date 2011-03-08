From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git cat-file does not terminate
Date: Tue, 08 Mar 2011 14:52:44 -0800
Message-ID: <7vwrk9cjib.fsf@alter.siamese.dyndns.org>
References: <4D70E340.3050309@tweerlei.de>
 <20110304154014.GE24660@m62s10.vlinux.de>
 <20110304160047.GA9662@sigill.intra.peff.net>
 <7vzkpa7qmp.fsf@alter.siamese.dyndns.org>
 <20110308211423.GB4594@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <waste.manager@gmx.de>,
	Robert Wruck <wruck@tweerlei.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 23:53:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px5m7-0005bs-7w
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 23:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961Ab1CHWxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 17:53:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46364 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab1CHWxA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 17:53:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C728D4C16;
	Tue,  8 Mar 2011 17:54:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+pUTLbQI6KobgZf2KzXeGVnE9R8=; b=GQhQJV
	SxaMKzdEdQPl5yCsUMHDs4ks4JzeFeaJ7zZzBec1efoN5zQYdQKJWR8w5zWywzAW
	3iNfrMubxlNm55RrbYQU9LtBc8MDYwyyytABgusNunFnn1hmn8XBYWwlY5W1rbtu
	nxiVtWh0NmXQLQvcVX4K2+5/mE/+2/kErIxms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hbI+HzYgK70KiEijqYfh/i38XPYe663Z
	KfArZ0lUX59LbV+eNugzxegh8rx9Cp/0ELTpn5dCSvx1gHLiEVVHiuam3/xJNDyG
	WikniWACsRgU6NvaSfrK2AxDJatuVeQnTUCeB+NM1seRqDEWT5ehjK3oSttNuY19
	SWnQvtwbADo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 858BF4C15;
	Tue,  8 Mar 2011 17:54:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4139F4C13; Tue,  8 Mar 2011
 17:54:13 -0500 (EST)
In-Reply-To: <20110308211423.GB4594@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 8 Mar 2011 16:14:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00670CFC-49D7-11E0-A0C3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168714>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 04, 2011 at 09:16:30AM -0800, Junio C Hamano wrote:
>
>> How prevalent is the problematic cygwin1.dll 1.7.8?  Also for how long did
>> this bug exist, in other words, if we were to make a table of problematic
>> versions, would we have only just a handful entries in it?  Also can we at
>> runtime find out what version we are running?
>> 
>> The reason I am asking these questions is because I think, assuming that
>> ...
> How are we doing the runtime test for platform max write?

I asked (1) if we can find out at runtime if we are on which version of
cygwin1.dll, and (2) if we can have a small list of "bad" versions of
cygwin1.dll.  If both are true, the runtime test should be trivial, no?

> So I think the test needs to be "is our version of cygwin in the broken
> list" and not "let's try a few different writes and see what works".

Yes, that is exactly what I had in mind.
