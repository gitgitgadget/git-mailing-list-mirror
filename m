From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is it by design you can create a branch called 'HEAD'?
Date: Mon, 21 May 2012 15:13:03 -0700
Message-ID: <7vr4ud6v4g.fsf@alter.siamese.dyndns.org>
References: <CANgJU+UAbpFvROFynZ-MHzfhEYksM-Mhf5rVjcA6GUhk6BX-NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 00:13:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWaqn-0002Xi-7a
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 00:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404Ab2EUWNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 18:13:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932283Ab2EUWNG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 18:13:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AEFC8D68;
	Mon, 21 May 2012 18:13:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PYSCcBOrIfBe75svI35+A3wX/CE=; b=taMqWy
	cJMQxNHqGRHKTJ7WvSsT1+iNS2m42k9V9qwLr1tzAo1rAX/8eMnzgYxhv2SlbHAm
	mXtzO+tLuX9leFbZWjI8+2RX5AQJQt8vmFYPrn6BxQ13qT10++PRBtnuUyf4zfsb
	HcjlgRyIRRlSktMEy9inNtxDjqT1hXmH2rbiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eZZzBrPm+lvVoi1hGSWl4yf7CFXSPhqp
	v2RuQl8czlZ7rov8F8UP8omYbV3MWdGaciGfSCfcI0IZXYuitV/+P3cP6zZgkc2k
	aZm4oBgd+Qb2G37+mYEwMU0aS4J9hQy321MNFbBYohQ5d7vTQxEhCSyv8R1Nq/Ot
	ogr5Rq+bKxY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22B078D66;
	Mon, 21 May 2012 18:13:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9C758D65; Mon, 21 May 2012
 18:13:04 -0400 (EDT)
In-Reply-To: <CANgJU+UAbpFvROFynZ-MHzfhEYksM-Mhf5rVjcA6GUhk6BX-NQ@mail.gmail.com>
 (demerphq@gmail.com's message of "Mon, 21 May 2012 11:14:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2320A0C6-A392-11E1-8566-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198132>

As you can see from the "warnings", we by design strongly discourage it,
but just have been (and still are) lazy to think of a reason not to allow
people who really want to do so, so the code is lenient if the user asks.

The plan behind these "warnings" obviously is that in future versions of
git we would make them even stronger and eventually forbid perhaps all-caps
names from anywhere inside refs/ hierarchy.
