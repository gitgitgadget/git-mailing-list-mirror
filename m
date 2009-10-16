From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Introduction and Wikipedia and Git Blame
Date: Fri, 16 Oct 2009 12:00:20 -0700
Message-ID: <7v7huvuptn.fsf@alter.siamese.dyndns.org>
References: <ee9cc730910160207x49feb40ej692188abb0a57473@mail.gmail.com>
 <alpine.DEB.1.00.0910161321550.4985@pacific.mpi-cbg.de>
 <ee9cc730910160443k7e5f718bs964923a796cf38d1@mail.gmail.com>
 <alpine.DEB.1.00.0910161548550.4985@pacific.mpi-cbg.de>
 <7vbpk7w9qx.fsf@alter.siamese.dyndns.org>
 <ee9cc730910161100r71818303v343f555151db4dcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "jamesmikedupont\@googlemail.com" <jamesmikedupont@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 21:00:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mys2W-0000hp-9Q
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 21:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbZJPTA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 15:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbZJPTAZ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 15:00:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbZJPTAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 15:00:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 613755BC99;
	Fri, 16 Oct 2009 15:00:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9oWOLTR1tBhpSRpSZbhRPbJEtpU=; b=kc7ATn
	ttw0eU02drWgh4wWVOQ37gPH/XmNKSRPylKVXucW+IfReOt7cw9h4dKeXSOqIMte
	ZW1NFLDegf6KqUFNob/s+ozsnwZg5RMz9ECCxvn0PkVwTuSDTUSJwGOchjq+XMO+
	MWpUrXTMpNU9hM4e4n28vqsXUT+NYgtOz/xUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dZPHbhuUmEFInaxO87sJqetbMFoSDlde
	vVYfRqFssaRdda6P1hzBbUZSAtuuf//ACJubA38bWSuUTs68AEwHWr323eXxeYbe
	OpBRsXtTWacYlA0P5YPyQlyUWGxbNfwdGA8LyqH1G35QVZvS20+Zbm5pjur1upZT
	HuXj4sE1uNU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 24CC75BC95;
	Fri, 16 Oct 2009 15:00:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A82D5BC93; Fri, 16 Oct
 2009 15:00:22 -0400 (EDT)
In-Reply-To: <ee9cc730910161100r71818303v343f555151db4dcc@mail.gmail.com>
 (jamesmikedupont@googlemail.com's message of "Fri\, 16 Oct 2009 20\:00\:17
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 29FC171A-BA86-11DE-B5AB-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130520>

"jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com> writes:

>> You would need to postprocess the computed result (either by diff or
>> blame) to lay out the final text output in either case anyway, and making
>> the existing blame engine do the work for you would be a better approach,
>> I think.
>
> Please can you tell me what is the basic algorithm of the blame engine?

I think this is one of the most conprehensive write-up on the algorithm:

  http://thread.gmane.org/gmane.comp.version-control.git/28826/focus=28895

The whole thread (at least what I wrote in it) is worth reading if you
want to understand what the current code does.  The first message in the
thread talks about "NEEDSWORK" label on an unimplemented part of the code,
and says "we could", but these gaps were since filled.
