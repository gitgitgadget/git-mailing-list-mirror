From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] test-lib: '--run' to run only specific tests
Date: Wed, 30 Apr 2014 07:17:30 -0700
Message-ID: <xmqqtx9ahpfp.fsf@gitster.dls.corp.google.com>
References: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
	<1398154767-1276-4-git-send-email-ilya.bobyr@gmail.com>
	<xmqqlhuvzy6r.fsf@gitster.dls.corp.google.com>
	<5360C50F.7070505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 16:17:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfVKP-0002Hr-8s
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 16:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbaD3ORg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 10:17:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48609 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422650AbaD3ORf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 10:17:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09A5E7FF7C;
	Wed, 30 Apr 2014 10:17:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g3T+D5olhmQP9e0nScLZYSfW3KY=; b=o+FlNm
	2TiozcwxwhNw95shij2td7JmVsG6480brdEcujUXac/wXqAxBeJ7HDtJiGnR8cL1
	zuTcCSsDyM1n3tYxN2inZjkyBIf9K7Icu+b5aUgmuhwKeKSQi+T5ZzG2AmSloMi5
	4GvLkkkCOK4feLOKoV8t1lyHYXeXlJCC9TGvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j9lNgV8TZUykBBctbYaHQpKBpkysbHSl
	NqTDBNnHnw4TUw/D/XOzaayIgr0/JYknatH0y6qfmHBuzspUyV9KAnCd+THPBLtI
	hSKmI7yeItt5lO1Ep1uVf1CZ/wYyJIMYPD5ZNbQt9wHo2sHmPXTtfuWa4hi0KfjV
	O1Fb4nKqjfU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3CE27FF7B;
	Wed, 30 Apr 2014 10:17:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9B5C7FF76;
	Wed, 30 Apr 2014 10:17:31 -0400 (EDT)
In-Reply-To: <5360C50F.7070505@gmail.com> (Ilya Bobyr's message of "Wed, 30
	Apr 2014 02:40:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2AFE688C-D072-11E3-9CEE-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247714>

Ilya Bobyr <ilya.bobyr@gmail.com> writes:

>> The above two illustrate the reason rather well why I said it would
>> be better to avoid negation because it would complicate the mental
>> model the user needs to form when using the feature.
>
> I think that you do not have to use it if you do not need it.
> It adds some expressiveness, is rather easy to implement and is already
> there :)
> I can remove it, of cause, but is it really necessary?

An extra "expressiveness" that needs explanation and careful
thinking on the part of the user to pick the same world model you
picked among multiple valid world models is not necessarily a good
addition, so none of "you do not have to use it", "it's already
there", "it is easy to implement" is a valid argument.

If it weren't there, I wouldn't have had to wonder what the notation
meant, you wouldn't have had to explain it to me, and the most
importantly, nobody has to learn there is a subtle distinction
between "!7 -11", "!7-11" and "!7- 11".
