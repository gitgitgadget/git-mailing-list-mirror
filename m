From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry picking and merge
Date: Fri, 01 Aug 2014 14:44:00 -0700
Message-ID: <xmqq4mxvvqan.fsf@gitster.dls.corp.google.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
	<20140801200201.GS12427@google.com>
	<20140801205040.GT12427@google.com>
	<CAK3OfOhbJJqLB4yPbuJyufytxNUSBLzKF6axc4jeU7eAjvXtgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 23:44:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDKcY-0001pp-Uf
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 23:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251AbaHAVoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 17:44:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56032 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755715AbaHAVoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 17:44:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A0B2C2E02E;
	Fri,  1 Aug 2014 17:44:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lO0aUdjK7oA2FjYaR4qlCSrbLbg=; b=SPSnmv
	T9fYjUSAgYb0qYNT2jePnNHpVGrDH5mamHzdmMJ347bB2lwtdKMAZcsQoL6wFH4j
	hlaOK0OuJ9yluCpXKrHXgRe/xuwUgLRaDLMWIo9W8CWWbVJkYToy8kUKL1gmsbbN
	RVXeHEOhKDf1fzdQzEWPImpey0RtcBv8lO9Xc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gNW2XOePEaRq5nI2lAtJOfGNomHWn+UK
	MhWiHYbzedslNE48SD0ufGyCzFAqG8SjgcZo7p3fHGJNqRWf5NS+1TCCawGOquPD
	6urkz7ZaiECiUVaE8o4NXPhDwVfYLM99EZA96uGv+ruzq+3q8y3NYpYRvnTtNtKG
	Jh+D+yffK8A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 97ACB2E02D;
	Fri,  1 Aug 2014 17:44:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 289F12E026;
	Fri,  1 Aug 2014 17:44:02 -0400 (EDT)
In-Reply-To: <CAK3OfOhbJJqLB4yPbuJyufytxNUSBLzKF6axc4jeU7eAjvXtgA@mail.gmail.com>
	(Nico Williams's message of "Fri, 1 Aug 2014 15:55:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F3C15996-19C4-11E4-AC7D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254667>

Nico Williams <nico@cryptonector.com> writes:

> Cherry-picks should record two parents, like merges.

No.

It is OK to record where it came from, and we let you do so with the
"-x" option.

But the "where it came from" commit is very different from being
parent, which implies "all the history behind it".  The whole point
of a cherry-pick is that you do not want to grab the changes behind
the commit you are cherry-picking and you want the _change_ the
cherry-picked commit (and that commit alone) brings in.  It should
never record "two parents, like merges."
