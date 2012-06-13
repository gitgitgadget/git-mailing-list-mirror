From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to know this commit is merged by whic commit
Date: Wed, 13 Jun 2012 15:22:48 -0700
Message-ID: <7vzk86g8cn.fsf@alter.siamese.dyndns.org>
References: <CAHsH0E9HooVsAq8NhWm-OSk7gSPFMmoYHsArtYqhwTmE0ngwjA@mail.gmail.com>
 <20120613213435.GA25301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: lei yang <yanglei.fage@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 14 00:23:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SevyB-0007Bx-RP
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 00:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023Ab2FMWXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 18:23:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755058Ab2FMWWx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 18:22:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 360198A61;
	Wed, 13 Jun 2012 18:22:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3kIkUY3d6jJDDK+pbyRF6ED7a2A=; b=n1o7nk
	RYUKnilfk1zQ2p5LbBHQ1kupt+6ojWZ8F1kf0eaNKnb1Yxyl8IOxZ76+K5ur1Dnk
	Ja0ixGwdxqRoXLU/9h4q4VaDlt1BbrUziIUvyliupKONtKXOc94cdpW2+BJ3XQwD
	b1MA9PEkvBnyPtqe4xKa+3etwbyNDAs7rETTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NQQodettPyL6AgWqwjoaabnoDCn2Pw0H
	K0ddSiIdAIskCqbm7j1nZopws/fc+cRu7y2EYknHilwemwXVEVFasynW94jxUypE
	FDK6ulB+8OVWu2QUeelQQshscb3XzDMeoMecCo019/+vRJFtiIOt4e7qBL9e+MQi
	WhaeR8Bb8RQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C65B8A5F;
	Wed, 13 Jun 2012 18:22:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C0728A5E; Wed, 13 Jun 2012
 18:22:49 -0400 (EDT)
In-Reply-To: <20120613213435.GA25301@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 13 Jun 2012 17:34:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F3E25F4-B5A6-11E1-9444-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199951>

Jeff King <peff@peff.net> writes:

> On Thu, Jun 14, 2012 at 12:50:59AM +0800, lei yang wrote:
>
>> I have a question as the title indicate. assume the commmit id is
>> ee5r3343. how to know this commit is merged by  which commit?
>
> There is not one answer to "which commit"; there may be an infinite
> number of commits which merge it into something else. The best you can
> do is start at some point (e.g., the tip of "master") and walk backwards
> looking for commits which merge it (and you still may find multiple, if
> the commit was merged into two other lines of development, each of which
> was merged into your starting point). There is not an option to do this
> search automatically, so you would have to use grep, like:

Or you can use "git bisect" ;-).
