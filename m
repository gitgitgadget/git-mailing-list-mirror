From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Case insensitive URL rewrite
Date: Fri, 11 Dec 2015 10:56:38 -0800
Message-ID: <xmqqzixgervd.fsf@gitster.mtv.corp.google.com>
References: <B207EFC1-48DF-4B8F-8373-28A0CB5660B0@gmail.com>
	<xmqq7fkkg7tq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZbxFT6_rZUAfUW7Qof8n7mjU53VZb24uGru4LfTfFr=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 19:57:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7SsN-0006yN-8h
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 19:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbbLKS4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 13:56:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751271AbbLKS4q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 13:56:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 132D8305A0;
	Fri, 11 Dec 2015 13:56:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kXl/RoWCOzk9rXs3zvEegpUO3v4=; b=Hj43Up
	nKbGxWzjVyngJm8E1SompcEYF1AVOs7fU7sx1mbyz4/kXONzfVUjM9YkF2z3WptV
	8qL9p1SpX5zt3bWjyOENFBZrMS6JqPzjmO/abUWx4IssNWZWBBdqa9SJ7B1WubO5
	XFf92m874vxUJTsk5SZxOaxPFSQziAyTfOHwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D0HqUU+LhRBUmLWI4JaAYf/y8XUQfaz4
	c/EYJ8SCr98E5p5E68Pe5T6ts2ABeGHOOLfyR4TxouZKBnhaJKN9P6ty7lWllow9
	6yCG2uS9ihRX4+Uj0wM5GuOgeGZToG0iK3mkKCRF5MsHaBIYQx0+L4sk4TVeM8ZP
	tApoWUFfS40=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 09C503059F;
	Fri, 11 Dec 2015 13:56:40 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6E16F3059E;
	Fri, 11 Dec 2015 13:56:39 -0500 (EST)
In-Reply-To: <CAGZ79kZbxFT6_rZUAfUW7Qof8n7mjU53VZb24uGru4LfTfFr=w@mail.gmail.com>
	(Stefan Beller's message of "Fri, 11 Dec 2015 10:51:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E9229936-A038-11E5-9D48-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282269>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Dec 11, 2015 at 10:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> On the other hand, these two MUST be treated as different by
>> default:
>>
>>     git clone https://github.com/GIT/GIT (differences outside host part)
>>     git clone git@github.com:GIT/GIT     (differences outside host part)
>
> This is one of the more obvious examples I would think as the protocol is
> different.

Oh, I should have been more careful; I did not think Lars meant
git@GitHub.com should somehow match https://github.com but a more
obvious "git@github.com:GIT/GIT and git@GitHub.com:git/git behave
the same", and I thought everybody who read it understood the
example as such.

> What about:
>
>      git clone git@example.com:git/git     (differences outside host part)
>      git clone git@example.com:GIT/GIT     (differences outside host part)
>
> If the host has a filesystem which respects capitalization, these may be
> two different repositories.

That is what I meant.  Thanks for clarification.
