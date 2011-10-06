From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH WIP 0/3] git log --exclude
Date: Thu, 06 Oct 2011 10:22:07 -0700
Message-ID: <7vpqia11ds.fsf@alter.siamese.dyndns.org>
References: <1317799088-26626-1-git-send-email-pclouds@gmail.com>
 <7vhb3n8ie9.fsf@alter.siamese.dyndns.org>
 <20111006143441.GA21558@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:22:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBreE-0002vF-IU
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758668Ab1JFRWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 13:22:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60638 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758413Ab1JFRWL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:22:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55409637E;
	Thu,  6 Oct 2011 13:22:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WPWOgAJjGbntfPeXIfS63wKRsU4=; b=osTlW3
	ylhPqiIwVHlxpO0BEAB40a4WdM5bZbNWACJy7R1H5UqtrlQkp/lFZuUAVrSnjWTi
	BdWwICxVLhLKXeTezdk5CyXsWgd3Rnl/ueJaA8CmXDE+7Iuak4N02CgTppkW9mJr
	ZhMNUWiA6yNkA09hn6vyO74/VhDrJ9z4r+WIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d4ijLoRDA5ZS1CRrd6dyp8PwkjB1oGv8
	wlDisdtvWjurQJ6dFnwHmYwhk422ggr6UZomiTbmGklmMEiioLJmiC3NMch6vL/X
	3pHuUfYVBQ1V0Nu9Ic7a8nnlZuYe3dYllskGo4ZsR48YOdIEwSge2l8pxTvLe49l
	QCPfzXoOcsc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A177636F;
	Thu,  6 Oct 2011 13:22:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D464C633D; Thu,  6 Oct 2011
 13:22:09 -0400 (EDT)
In-Reply-To: <20111006143441.GA21558@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 6 Oct 2011 10:34:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B90503C2-F03F-11E0-91A0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182988>

Jeff King <peff@peff.net> writes:

> The current protocol relies on certain repository properties on the
> remote end that narrow clone will violate. I don't see a way around that
> without a protocol extension to communicate the narrowness. What will
> that extension look like?

It would have to involve exchanging "I have/am interested in the paths
that match these pathspecs". I do not mind if our initial implementation
did not support anything other than fetching into a narrow from full and
pushing from a narrow to full. The second iteration could add fetching and
pushing between two narrows with the same set of narrowing pathspecs.

As to widening the area after a clone is made, I do not mind and if our
initial impementation only supported widening the area in a stupid way
(e.g. semi-equivalent of initial clone with the widened set of narrowing
pathspecs).
