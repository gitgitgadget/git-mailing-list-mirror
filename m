From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9] Documentation/remote-helpers: Add invocation section
Date: Wed, 07 Apr 2010 22:14:53 -0700
Message-ID: <7vk4si8r02.fsf@alter.siamese.dyndns.org>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com>
 <7vsk77e20r.fsf@alter.siamese.dyndns.org>
 <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com>
 <20100407224942.GA20239@progeny.tock>
 <7vzl1eamss.fsf@alter.siamese.dyndns.org>
 <x2of3271551004072154r62d10023r32e74064d38aff75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 07:15:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzk5K-00079H-9m
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 07:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab0DHFPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 01:15:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab0DHFPP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 01:15:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9C8EA92D9;
	Thu,  8 Apr 2010 01:15:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QcXwloCLuKMtKrulmlrofJW0yFs=; b=AGdjXb
	qFl5pjY2rGZAYvHNCp5AqTSfCeVdR/0DMhV99YwY/18P09Qja3T28QiwUJkRoPAX
	W4Mdxw9CTkqJ3il7KiD94HZjJRj1B/WkTqUMb9sbvi/FB3uU6OtkPk6zEa1aj0re
	QV1rGNSWJxJW/DMzA6tJhXJL5RfUgjahq2DtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KcFRbseYNTRv2eSD9OBDRpW/6TPBOp5n
	CcTVHbLkGHFQxsXg6oXJKW9Nxdk5+bFsiNTuriB2xvF3OV41h6kqIvQ1h9hccazX
	IBnOUwE8Rx44cGNbi0ManOYap8RsqMUcWfbFcZJvgyXri8+XJOqlDqU8zY2AfTr8
	UKbQ6o/Kycs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E3E7DA92D4;
	Thu,  8 Apr 2010 01:15:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67B29A92CF; Thu,  8 Apr
 2010 01:14:55 -0400 (EDT)
In-Reply-To: <x2of3271551004072154r62d10023r32e74064d38aff75@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Thu\, 8 Apr 2010 10\:24\:34 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B1664B1A-42CD-11DF-B401-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144316>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Can I see the topic branch corresponding to my patches? If this is
> possible, I can avoid the more painful procedure of extracting it from
> the latest pu using git-resurrect.sh.

Run:

    $ git log --first-parent --oneline origin/master..origin/pu

and find "Merge branch 'rr/remote-helper-doc'" in the output.  The second
parent of that merge commit (e.g. 6144af5^2 == ad466d1) is the tip of your
topic.  You can verify it with:

    $ git log -p origin/master..ad466d1
    $ git checkout -b remote-helper-doc ad466d1
    ... build further on it ...
