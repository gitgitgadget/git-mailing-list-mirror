From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Fri, 08 Feb 2013 11:18:29 -0800
Message-ID: <7vhalm1unu.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <5113E849.8000602@elegosoft.com>
 <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
 <20130207233017.GD19397@google.com>
 <CALkWK0kR-KWJbG_kWSf7+JMJEQc7vO0Emx=_yogCB0jMBfccAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 20:18:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3tTN-0007h6-1q
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 20:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946860Ab3BHTSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 14:18:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48185 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946814Ab3BHTSd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 14:18:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EC46C2AF;
	Fri,  8 Feb 2013 14:18:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XiD+JApAsMs7NKLGkx6eSfsxCK0=; b=OrHD8n
	uf7E5pzBIl3/TAj/4drSadX7vS0FwJd4zdPM1smZza1MXBTRcdMYZ8cNclol8LCU
	FxZogF8Q5JvfEaB3EEXvC3yaKzobn1s5soetdcJpX0kRJpzaxDDT5w3RPkEFkd0l
	h9H5BtzFfK+dPyTzxVteUOYwtM7UrIBnEtupU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qi8fSUW3pKVGiOzLviFul0L0GR1Vnp/u
	iwTXw+0oCDaunDE208YYVa8phdTPQxPBD/hO7QAlBK7nUv7y1t61AG17icxRh9hW
	hK31tE8OmJZU6K01PfO/vwJ7YuhZqKJaH5G24jpMY0pn3bGktSy6IWds8Wi2b+Ne
	6xn7eVRuLDo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4288BC2AE;
	Fri,  8 Feb 2013 14:18:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B50A4C2AB; Fri,  8 Feb 2013
 14:18:31 -0500 (EST)
In-Reply-To: <CALkWK0kR-KWJbG_kWSf7+JMJEQc7vO0Emx=_yogCB0jMBfccAg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sat, 9 Feb 2013 00:12:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 535C5706-7224-11E2-B840-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215804>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Jonathan Nieder wrote:
>> Ramkumar Ramachandra wrote:
>>
>>> And yes, a regular `git push origin refs/for/master` is just retarded.
>>
>> The usual incantation is "git push gerrit HEAD:refs/for/master".  Is
>> the code review creation push that uses a different branchname from
>> the branch the integrator pulls what seems backward, or is it the need
>> to specify a refname at all on the command line?
>
> How else would you design a system to differentiate between a
> push-for-review, and push-to-update-ref?

You don't have to.

If the reviewed result is merged on the server side and appear on
'master', nobody has to push to update refs/heads/master.
