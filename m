From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin/commit.c: memoize git-path for COMMIT_EDITMSG
Date: Thu, 09 Jun 2016 10:04:39 -0700
Message-ID: <xmqqinxii994.fsf@gitster.mtv.corp.google.com>
References: <1464027390-1512-1-git-send-email-pranit.bauva@gmail.com>
	<20160524191950.21889-1-pranit.bauva@gmail.com>
	<CAFZEwPOZSU315oCJSdawtacPmgZobCnkkguTnSy1_V7x_n09kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:05:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB3O8-0004PG-OH
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 19:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbcFIREn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 13:04:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932570AbcFIREm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 13:04:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 68C0522748;
	Thu,  9 Jun 2016 13:04:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C+MbkPmGWb0gbcVXErnWT8wRca4=; b=n/dBnI
	/JNQd8lXOWmwzhDYXGjuu0c/968XNoLGV3oQWvYtfiGL0EPeOuYm4kaPrHyK/x78
	LBn9fargs3XEWd+wHt6NCcQNflMoOQPzczJNdBFqUxcRVyIG1mugJwIDfqEkzRWo
	dtIoivt/1MFdHg9sY+9bHj8I1nXqxFCH+R+4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FfmqJMpVLsfJwCYNdkhyJQE48E0ZUNzL
	ne4j5ebBD3o1oQnQd0UgkPCjjG5EgQb5L1BWJ52WBgcqBnM1CB5tt5vXa6ENmP4k
	TKWskEXjWHR9sLFcmuLRlZSk8SUBEH4kyy8/fZjjXqyMxO43fPNP7jOcsUgVsSVz
	5GkDwhFqaoo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6114C22747;
	Thu,  9 Jun 2016 13:04:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DAFDA22746;
	Thu,  9 Jun 2016 13:04:40 -0400 (EDT)
In-Reply-To: <CAFZEwPOZSU315oCJSdawtacPmgZobCnkkguTnSy1_V7x_n09kw@mail.gmail.com>
	(Pranit Bauva's message of "Tue, 7 Jun 2016 20:25:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 415F2AC4-2E64-11E6-A141-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296903>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> On Wed, May 25, 2016 at 12:49 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> This is a follow up commit for f932729c (memoize common git-path
>> "constant" files, 10-Aug-2015).
>>
>> The many function calls to git_path() are replaced by
>> git_path_commit_editmsg() and which thus eliminates the need to repeatedly
>> compute the location of "COMMIT_EDITMSG".
>>
>> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
>> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> Link for v1[1].
>> ...
>
> Anyone any comments?

It seems that nobody saw anything that needs further polishing?
Thanks for pinging.  Will queue.
