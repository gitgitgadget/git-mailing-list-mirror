From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tr/pty-all (Re: What's cooking in git.git (Dec 2011, #04; Tue,
 13))
Date: Thu, 15 Dec 2011 10:19:33 -0800
Message-ID: <7vr505ofyi.fsf@alter.siamese.dyndns.org>
References: <7vobvcrlve.fsf@alter.siamese.dyndns.org>
 <20111214070916.GA14954@elie.hsd1.il.comcast.net>
 <201112141717.15021.trast@student.ethz.ch>
 <20111214230713.GA13128@sigill.intra.peff.net>
 <20111214232151.GB13128@sigill.intra.peff.net> <20111214233119.GA2354@elie>
 <20111215002530.GA2566@sigill.intra.peff.net>
 <20111215005057.GB2566@sigill.intra.peff.net>
 <7vfwgmplgd.fsf@alter.siamese.dyndns.org>
 <20111215065529.GA1327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 19:19:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbFu9-0001E2-NB
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 19:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109Ab1LOSTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 13:19:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503Ab1LOSTg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 13:19:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3E677E38;
	Thu, 15 Dec 2011 13:19:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gjWhm8LjNH6wXa5B3xwp23uZYRM=; b=sYExj/
	YzCt4vr0BOhtnpixa8zOo+MCaVRoXTg5+7TLf3xZlH3WtiaOGwPuh5F3P3gCl3bL
	P3R2GHTnGee+9KL5zi2JhobdyLV9hm7ZDQCspJw0RLjzuBnWpN4Pc80jHHlukHvG
	LTXGahK7+AdUPJUWekiX5N2aWlHuenTX0Jmpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sjQAizNjKhxbvlDDMgAWeHZT46ITEs9p
	W7aS6jOy3pQCf3M+YBLTte/fKu/NRgf+DxceFCEonk8vssEy6PcqDHBd8zBr8v9W
	qoaVf2xS2l5eGiy3NQhovxwtHzAPcOQgAyczySZfcyjyg+sX1JKvjBceKUjcCFDh
	SruqOPFecz4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAC227E37;
	Thu, 15 Dec 2011 13:19:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27C327E36; Thu, 15 Dec 2011
 13:19:35 -0500 (EST)
In-Reply-To: <20111215065529.GA1327@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 15 Dec 2011 01:55:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 577D5E42-2749-11E1-8697-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187218>

Jeff King <peff@peff.net> writes:

> On Wed, Dec 14, 2011 at 07:23:14PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > This correctly detects the bug in t7006. I can't decide if it's clever
>> > or ugly.
>> 
>> I would say it falls on the latter side of the line by small margin. Let's
>> do the /dev/null thing and be done with it.
>
> Darn, I wanted to post it on my fridge with an "A+".

Heh.

If it were without the perl "tell" bits, it would have been "clever and
clean", perhaps like

	arrange the following to read from t/random-stdin file
         - run the test script
         - "read x"
        compare the $x you just read with t/random-stdin file

But I think it is good enough to be stupid and clean.

> Here's a cleaned-up version of the /dev/null one.

Thanks.
