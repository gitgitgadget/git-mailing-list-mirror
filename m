From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] pathspec labels [WAS: submodule groups]
Date: Mon, 16 May 2016 10:39:28 -0700
Message-ID: <xmqqh9dx3nsf.fsf@gitster.mtv.corp.google.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
	<CAGZ79kacKnBjzVFSShRido4rKa3-Zg465d2320M6w1qXEkOZqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 16 19:40:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2MV1-0006Pr-3j
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 19:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbcEPRkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 13:40:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753919AbcEPRkA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 13:40:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 10BB31C647;
	Mon, 16 May 2016 13:39:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=86D1GOSxw+c75b5iMJAEc7ZwwBI=; b=fnC1YY
	dCjczZhvtIWZpc1o4ipiztJmKno5ePlDrmznGe0ULImW6kUwpJyL9B7hIjchWWwN
	L9NiFIl+hzuqkA7LDTINv4osFdoYnBafhhvsmf3OXJFTc84UTFiFjDy4/WDYUmvE
	paTefjPAgS7AEioSxDgquJZpg1/YyJaZM28hU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cp3397qLyDjSMil/b5npCoUuAISErm6z
	XAh8FwLK2dlcxKNiPKRhrnMZgurY8/QpXy7WpD8wOtbTTbuVkR0W/B1xqR6cwf4n
	JBmAKtqyttLeiP8yQ2nroDc4s2OwPji5y7eCZlS4/lB0QbWlOwcjZHtgsLxePEjy
	BuG/vEQ1GWo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 083E11C646;
	Mon, 16 May 2016 13:39:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B8F41C645;
	Mon, 16 May 2016 13:39:30 -0400 (EDT)
In-Reply-To: <CAGZ79kacKnBjzVFSShRido4rKa3-Zg465d2320M6w1qXEkOZqw@mail.gmail.com>
	(Stefan Beller's message of "Mon, 16 May 2016 10:20:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 24EC645E-1B8D-11E6-BE77-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294761>

Stefan Beller <sbeller@google.com> writes:

> On Sun, May 15, 2016 at 3:06 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> Instead of putting everything in under the same attribute name
>> "label", make one attribute per label? Would this work?
>>
>> *.[ch] c-group code-group
>>
>> And the pathspec magic name can be simply "attr", any git attribute
>> can be used with it, e.g. :(attr:c-group)
>
> So you want to be able to query something like:
>
>     git ls-files ":(crlf=auto)"
>
> as well?

It would be more like

	git ls-files ":(attr:crlf=auto)"

It certainly sounds tempting, even though I do not want to keep what
this initial chunk of the series needs to do to the minimum.
