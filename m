From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce --current option to git-branch builtin
 command.
Date: Thu, 07 Jun 2012 10:11:47 -0700
Message-ID: <7v4nqnjbcc.fsf@alter.siamese.dyndns.org>
References: <CAECJ0BmcxeS1q8bw4hN9jDja2g8GGzNyN_v7jC3ehOW70x6CRA@mail.gmail.com>
 <4FD069A5.1040905@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-2022-jp?B?S2VudGEgTXVyYXRhICgbJEJCPEVEGyhCIBskQjgtQkAbKEIp?= 
	<mrkn@cookpad.com>, git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 19:11:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScgFW-0003Ke-Oq
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 19:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760679Ab2FGRLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 13:11:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43250 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754204Ab2FGRLt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 13:11:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C95287D6;
	Thu,  7 Jun 2012 13:11:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9pCTLHRDUE5r8axBI1Y/4hTORh4=; b=YhDrt0
	On/7dwX1rPK9lraMtlAdlzybPvs1sL6Ms78n7gJ7oGG+yPswObi1XmIMAb88Vj2C
	inCyCbsg/JcFmxotD9Plz1i4TwCR6fP/9C5yfpOFlXk1xmgQBtPDs25kDonyKTCF
	a6VewzKhuvoXQq2hqSkE45greROLBmUDrxvj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h0/b/ILwP6LCqlGJxkKKCVVOXhMU1UgQ
	y/QIV3BYzkro2VXL27n0+QD5CLRph4jpDwj0Z/86/I3dQiY8KT+fkNoFa5NHdg0O
	a3tYj3NRgTWDM7hsKd5cfzOHocTSxnZT6qQzUUTcrew3VfwWyi7RfKaq42u1/Ikp
	pBp6vvCj0cQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 330B487D5;
	Thu,  7 Jun 2012 13:11:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C08C587D4; Thu,  7 Jun 2012
 13:11:48 -0400 (EDT)
In-Reply-To: <4FD069A5.1040905@lyx.org> (Vincent van Ravesteijn's message of
 "Thu, 07 Jun 2012 10:43:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE07BDAA-B0C3-11E1-A5ED-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199421>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> git-branch has four modes: 'list', 'create', 'delete', and
> rename'. Isn't --current then just another option to the 'list'-mode?

That is how I would look at it.  We can think of various ways that
"list" can be filtered, and matching by name is one that we have an
implementation for.  "Current-only" could be another one.

> If '--current' implies the 'list'-mode, it would use
> print_ref_list'. There already is code in print_ref_list to detect
> whether a branch is the current one, it outputs the branch list in a
> formatted way, it takes care of 'columns', so wouldn't it be better to
> modify that code to only print the current branch ?

Exactly.
