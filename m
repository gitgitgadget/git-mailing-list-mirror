From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git ate my home directory :-(
Date: Mon, 25 Mar 2013 15:06:37 -0700
Message-ID: <7vboa7w2vm.fsf@alter.siamese.dyndns.org>
References: <5150C3EC.6010608@nod.at> <20130325214343.GF1414@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Weinberger <richard@nod.at>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 23:07:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKFXp-00080I-W6
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 23:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758997Ab3CYWGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 18:06:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758978Ab3CYWGl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 18:06:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C1DDB799;
	Mon, 25 Mar 2013 18:06:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eBypseYkcJ+fYO9sgJOxxajI36Q=; b=ZowSGa
	3OR2PKurv46nxUtsqPu1JFD8JiWHEO/ZI2xA3NnISpFRw1FT95tDK7AtNlwByisu
	f0oqEdL/yJ3m4a6auenam534Xux8mxk3l+p0gDMXhl4DEAUByDG7q7IShH7tp19C
	tGFNDyFxo04qy6lTJhUiJduc0aMNHnxYhqRDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v9M9oqLAARxomO6zFxpbEIZnxbd4jgDe
	Yy6s7hYqv2RBgxpwV04iTU9Frww8feigulRNlga+8/i9TNK2W6YoIlX1DUxIuN0i
	LcktA//oFpGamKKorksVWcvU6eroFvivTNPkDhF2CNIw09ZG1BLc1ebgVIK+VKvP
	ikWCgQRUDnc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEE9DB798;
	Mon, 25 Mar 2013 18:06:40 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AF70B790; Mon, 25 Mar 2013
 18:06:39 -0400 (EDT)
In-Reply-To: <20130325214343.GF1414@google.com> (Jonathan Nieder's message of
 "Mon, 25 Mar 2013 14:43:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44AFA978-9598-11E2-BADC-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219105>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Richard Weinberger wrote:
>
>> In my scripts I'm setting GIT_DIR to use git-fetch and git-reset without changing the
>> current working directory all the time.
>
> Yeah, for historical reasons GIT_WORK_TREE defaults to $(pwd) when
> GIT_DIR is explicitly set.

And it *WILL* be that way til the end of time.  Unless you are at
the top level of your working tree, you are supposed to tell where
the top level is with GIT_WORK_TREE when you use GIT_DIR.  Always.

And that is the answer you should be giving here, not implicit
stuff, which is an implementation detail to help aliases.  I do not
know how things will break when the end user sets and exports it to
the environment, and I do not think we would want to make any
promise on how it works.
