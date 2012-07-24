From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: Recursive submodules fail when the repo path contains
 spaces
Date: Tue, 24 Jul 2012 13:37:54 -0700
Message-ID: <7v629cgajh.fsf@alter.siamese.dyndns.org>
References: <1CE02EC2D88646D48EE7B7D71AD36234@gmail.com>
 <500F00C7.4040209@web.de> <7va9yogb37.fsf@alter.siamese.dyndns.org>
 <9ADC1C4EF43A4237BC7971884C50C0EB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Justin Spahr-Summers <justin.spahrsummers@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 22:38:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stlrn-0001uN-7q
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 22:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911Ab2GXUh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 16:37:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755294Ab2GXUh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 16:37:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D986D6D75;
	Tue, 24 Jul 2012 16:37:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+A+MwTyQWNL4VMVgR2PeLZ2ZgmE=; b=DO2t7Q
	38cmfmPUzK1FEml8FDRvQllvHaXS+SVPB9NCi8tUW/jbWlm++qKplRlqUC+n+LJ2
	Wukr+bdzehvW/BFiW/TlP6JcdTggIzOUQDr4BnBDTdUD0ec3eXI9SM4Y/zIbxa2F
	B36rGyyAnRLsmAbAVemwW8K8z71mAMPU2khmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n+kM/JbxBJZscEGcnnvHFirXZDSFgVWk
	7kitRTYxRGgQRm4duuPMql4YGBB3dzSohD9KGajqGuQc9cgw2zHTuNN2NlhbpZOQ
	Vx3LKA0NH8NF+eV/FzWtaPQu6EJcqLV8g6JTxc1pQilHyX9chnLvWaBmHOeGw25+
	S2sceObAR3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C704E6D74;
	Tue, 24 Jul 2012 16:37:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 489216D73; Tue, 24 Jul 2012
 16:37:56 -0400 (EDT)
In-Reply-To: <9ADC1C4EF43A4237BC7971884C50C0EB@gmail.com> (Justin
 Spahr-Summers's message of "Tue, 24 Jul 2012 13:33:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 730DBABE-D5CF-11E1-A7E0-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202068>

Justin Spahr-Summers <justin.spahrsummers@gmail.com> writes:

> On Tuesday, 24. July 2012 at 13:26, Junio C Hamano wrote:
> ...
>> I can see one codepath that would behave incorrectly,...
>> ...
>> My recommendation at this point (i.e. not a long term) for people
>> with problems Justin saw is "Don't do it then".
>
> I appreciate the debugging work.

That was not a debug, and I didn't mean to say that was the only
place that is problematic.  In fact I think I said the script is not
prepared to work with paths with paths-unsafe characters because it
has many problematic constructs, and ended the message with "Don't
do it then".
