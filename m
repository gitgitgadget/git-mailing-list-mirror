From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Use case (was Re: Should branches be objects?)
Date: Wed, 25 Jun 2014 10:42:49 -0700
Message-ID: <xmqqegycans6.fsf@gitster.dls.corp.google.com>
References: <CAK3OfOgskVKs=eUT+EM+GZOjh0p6gxKeDWH-iTt29P1i1d1iZA@mail.gmail.com>
	<20140624110932.GI14887@thunk.org>
	<CAK3OfOgb3zt0HKkeQKfMR9u7sKRzjCZAeOQh=qSyt9cVordG4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 19:43:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzrDo-0004I7-70
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 19:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757847AbaFYRm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 13:42:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51341 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757769AbaFYRm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 13:42:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1847420947;
	Wed, 25 Jun 2014 13:42:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GoHIGAzby7ZwVYkuHlQgHoJdPfQ=; b=ZXxSTA
	QWLz7JIxLZ3uftpAHuZHWOvFE/NFz4pjGf+GVfcj4nFoJK30+LwEO9ltmEkoVR7/
	0fCXfqxpcE41hkWJGuatsCb4ARDp3NsDieueiERZWR3/wUgsy7jcDG3pdqZPhg36
	gVAZeG8LlzBFLrxLsO+vKkyV3kQ15lej21wf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Un6mJHPy7r6at12PYynpdLF7u7qU0cEh
	jfxFLUhPd0A9LkMpbVTtSas3OY+2t2nI4HcD10WfDCibkQUqOAJ+LzsleYWSGjbw
	QvpCeqOseYB0fyg6xs/8flhpMtnLfyWjyrraAX5Bv2M9Br6YN54dp/pOXaRDFbmN
	yhLs7yJW9iQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0CB8420945;
	Wed, 25 Jun 2014 13:42:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 37A8E20935;
	Wed, 25 Jun 2014 13:42:44 -0400 (EDT)
In-Reply-To: <CAK3OfOgb3zt0HKkeQKfMR9u7sKRzjCZAeOQh=qSyt9cVordG4A@mail.gmail.com>
	(Nico Williams's message of "Wed, 25 Jun 2014 00:29:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1CF333CC-FC90-11E3-BE8B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252452>

Nico Williams <nico@cryptonector.com> writes:

> On Tue, Jun 24, 2014 at 6:09 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> ...
>> This seems pretty close to what we have with signed tags.  When I send
>> a pull request to Linus, I create a signed tag which createscontains a
>> message about a set of commits, and this message is automatically
>> included in the pull request message generated with "git
>> request-pull", and when Linus merges my pull request, the
>> cryptographically signed tag, along with the message, date of the
>> signature, etc., is preserved for all posterity.
>
> Thanks for pointing this out.  Signed tags are objects -- that's a
> clear and strong precedent..

Sounds as if you are interpreting what Ted said as a supporting
argument for having branches as separate type of objects, but the
way I read it was "signed tags are sufficient for what you want to
do; adding a new "branch" type does not make much sense at this
point".
