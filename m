From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pack.packSizeLimit, safety checks
Date: Wed, 03 Feb 2010 18:34:47 -0800
Message-ID: <7vzl3pwwxk.fsf@alter.siamese.dyndns.org>
References: <loom.20100201T101056-232@post.gmane.org>
 <alpine.LFD.2.00.1002011100550.1681@xanadu.home>
 <7vvdeg50x4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002011240510.1681@xanadu.home>
 <7v1vh1zr10.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002032130270.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 03:35:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcrYd-0006Zi-Jg
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 03:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab0BDCe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 21:34:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab0BDCe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 21:34:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 165859695C;
	Wed,  3 Feb 2010 21:34:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XqUJAxx/rmUJa6Z6I26J6ieMvGw=; b=tjcAD5
	zUQq5DiR4/k4gtWbqmiu1JTdQ4cxAWGkukpewBYvvXE3pRCA5a/sNgysWbc9T83Z
	8SCpaPEcAt6FFHbivnExgivIgaY+9ixqElPn4TKr3Ds6e+ea/Zf06e5TLNwa0blM
	GZQmSG4dV2h+i4/xUdiyvWCvyd6Bzf8L9jKaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NoeeI8hHAiB7gKjXIVFINfmtfwEhxd3O
	SZY5/+I6TgUVhpJ2VzD2Wz/nlazRTiDmmrnH2srj8wiCK8kSYZ6W6+0drlqaJMw7
	JxSPxFREl+48WEhPy85CIql1CuK390vhl+a7/g83leyhyNVVMaUQgAK1lkXcwPGk
	bw6OEr0di6g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D7B0496956;
	Wed,  3 Feb 2010 21:34:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED95896952; Wed,  3 Feb
 2010 21:34:48 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002032130270.1681@xanadu.home> (Nicolas
 Pitre's message of "Wed\, 03 Feb 2010 21\:31\:15 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E0485F32-1135-11DF-BF7B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138940>

Nicolas Pitre <nico@fluxnic.net> writes:

>> I suspect one of us need to be careful not to forget this thing...
>
> Please hold on.  I think I have a better patch.

Ok, I dropped both fast-import.c mismerge fix and the one you are
responding to.
