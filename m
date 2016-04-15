From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fsck_commit_buffer(): do not special case the last validation
Date: Fri, 15 Apr 2016 08:06:30 -0700
Message-ID: <xmqqy48edi89.fsf@gitster.mtv.corp.google.com>
References: <20160414180709.28968-1-gitster@pobox.com>
	<alpine.DEB.2.20.1604151538230.2967@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 15 17:06:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar5KQ-0002nu-PL
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 17:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbcDOPGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 11:06:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750755AbcDOPGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 11:06:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D66DD11981;
	Fri, 15 Apr 2016 11:06:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R7Tb7WeKxw6XZ090DIW7DIczAqM=; b=nrLAaP
	lk+IURQLL1FRHwQ2hXqFWZB32PgPdW8hEEza6L9OwpXxjQ8HvZcqQJIEiYmdcOez
	Wqph/n9o8yCvS0xsI9qqlM5sp41dr1A6qZkzjJXATSGnIDFZqEJXanlAwBjjfu2i
	83aZCEbLzcIJKe57X9J+xBsJXAWg7ktJxku/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ngLaHBPVJgyBvh5Ojou8ccSojl01yenk
	bKRuKewf+dCaMLm8FRFIWPSgFLNUlCH0iXP+LbRuxIpKRS//7SwCc1xymbyWbDd4
	Na/2MJBPFDLGMAq/LHhC4BawMQjGeS9h73U1papfv8M/i2eNZJ7LXRMX+DSUKcmV
	vM7hQyMbgVw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CEB4611980;
	Fri, 15 Apr 2016 11:06:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3AA1A1197F;
	Fri, 15 Apr 2016 11:06:31 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1604151538230.2967@virtualbox> (Johannes
	Schindelin's message of "Fri, 15 Apr 2016 15:41:16 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A2D96ED2-031B-11E6-BED7-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291608>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> But that is a selfish code that declares it is the ultimate and
>> final form of the function, never to be enhanced later.  To allow
>> and invite future enhancements, make the last test follow the same
>> pattern.
>
> FWIW I agree with this reasoning. Sorry for leaving this to you to clean
> up.

Thanks. I often fall into the same trap, and I suspect everybody
does. After doing a large-ish change, it is easy to think that what
was just finished is the final one for quite some time to come,
without even realizing that I am being selfish.
