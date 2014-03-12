From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][GSoC] parse-options: Add OPT_SET_INT_NONEG.
Date: Wed, 12 Mar 2014 12:02:10 -0700
Message-ID: <xmqq61njmea5.fsf@gitster.dls.corp.google.com>
References: <1394535016-9424-1-git-send-email-yshuiv7@gmail.com>
	<CACsJy8Dq5QyZdzCtew0qF37qThH8+05iTrD-ZOeBgbEukmCY5Q@mail.gmail.com>
	<xmqqr467mfrg.fsf@gitster.dls.corp.google.com>
	<CAGqt0zyPOGY18EhWPMTGdtU54NDYS0ppRHhemhDArX7oE-0LGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Yuxuan Shui <yshuiv7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:02:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNoPy-00004z-DH
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 20:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbaCLTCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 15:02:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbaCLTCN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 15:02:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44B3C73A9E;
	Wed, 12 Mar 2014 15:02:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lLkfGwHE7YH8qZ6PZXa+47Bdyc8=; b=wcQMm0
	gboQm6ig3Gw43b23Q/lfXW4rp7WFQxEQBGg3H7q+u/h7VJytloLeQIHREqs5JUxs
	UceBEEdQLA7EsiozOU5LOYDgZOiHNp0V9QA5qtpgfDqOaWIPILKXed5brXY5gW4q
	ijzcJehAYPVK1MKJvw+KNUYDKw1L2ebjqlNoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pNiendQgF9EIqDFBwVUzzY3C9okkWbUn
	YiXSg7UVz/9WkFGcXnUzBbQ83WA6ROVATN7UWWOFhK2Bl5fF/7CzZlj2caV6zGqo
	X6sp5KFU68A9RyTbwmAiNk8HoNZlp7bN/45HPQK0+tezUgCNEVQCEjp1yNUbEGzj
	wmLDXSl+wlU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30DC573A9B;
	Wed, 12 Mar 2014 15:02:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EE5673A98;
	Wed, 12 Mar 2014 15:02:12 -0400 (EDT)
In-Reply-To: <CAGqt0zyPOGY18EhWPMTGdtU54NDYS0ppRHhemhDArX7oE-0LGw@mail.gmail.com>
	(Yuxuan Shui's message of "Thu, 13 Mar 2014 02:33:02 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D1A7E3E6-AA18-11E3-8911-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243964>

Yuxuan Shui <yshuiv7@gmail.com> writes:

> On Thu, Mar 13, 2014 at 2:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> By convention, no full stop in the subject line. The subject should
>>> summarize your changes and "add ..NONEG" is just one part of it. The
>>> other is "convert to use ...NONEG". So I suggest "parse-options:
>>> convert to use new macro OPT_SET_INT_NONEG()" or something like that.
>>>
>>> You should also explain in the message body (before Signed-off-by:)
>>> why this is a good thing to do. My guess is better readability and
>>> harder to make mistakes in the future when you have to declare new
>>> options with noneg.
>>
>> As I said elsewhere, I am not sure if doubling the number of
>> OPT_<type> macros as your micro suggestion proposes is the right
>> solution to the problem.
>>
>> What are we trying to solve?
>
> OK, I'll switch to another micro project.

That is fine, but note that it was not an objection but was a pure
question. I was asking you to explain why this is a good change.
