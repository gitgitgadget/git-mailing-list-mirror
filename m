From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-w 101/105] t6300 (for-each-ref): modernize style
Date: Wed, 29 Feb 2012 19:26:10 -0800
Message-ID: <7vty29ovcd.fsf@alter.siamese.dyndns.org>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
 <1330566326-26075-7-git-send-email-tmgrennan@gmail.com>
 <7v62epqd9a.fsf@alter.siamese.dyndns.org>
 <20120301032053.GD2572@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 04:26:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2weo-00043U-86
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 04:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195Ab2CAD0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 22:26:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757186Ab2CAD0M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 22:26:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E78E781B;
	Wed, 29 Feb 2012 22:26:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5wrDtZ8l/Jy2ClVDBA78clP7LTk=; b=bSlLYx
	gMJS09O4mP5wa/S28gc3/k44urvdtT2VwlmngIhR1TkPUSLQ4ASWMlY9AhC18qSR
	kx6sS+4HWM3m1+/gePK29pnV6T9SkBwo+a3z3xoET5IPhcaait1iqapA3kbaDZCW
	FiQ1IaMSaLlkyPENxwTEZdx374EdJ+fuX5W6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bsmMP+83VG/jmtWzIMh8EXhz51QOXNVo
	gM2MoH48cCKFi72PKO5728zeKgs8fsTS4qSO1tr3xw08lmsprfcgsM5lmn0lch2h
	sEdnQEzhFIC+srESDkIR7cljv5PqHJ770PdFEsG7L0b+4nuaI1vNNR2i5skCab7I
	zVFo6f/ClwA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05A9A781A;
	Wed, 29 Feb 2012 22:26:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 802D87814; Wed, 29 Feb 2012
 22:26:11 -0500 (EST)
In-Reply-To: <20120301032053.GD2572@tgrennan-laptop> (Tom Grennan's message
 of "Wed, 29 Feb 2012 19:20:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B110D7A-634E-11E1-A2AC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191891>

Tom Grennan <tmgrennan@gmail.com> writes:

> It's trivial to remove these "quiet" and "silent", but to me that's the
> only value added by these patches.  More seriously, the remaining
> modernization still seems much larger than its value.

Don't do that, then ;-).

Some older scripts do redirect the output from the commands to /dev/null
but that dates back before we made the default reasonably silent, and in
"modern" style we tend to keep them sent to their standard output to help
debuggability. These quiet/silent takes us to the prehistoric times.
