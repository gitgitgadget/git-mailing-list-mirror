From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Tue, 02 Dec 2014 15:50:44 -0800
Message-ID: <xmqqmw75ligb.fsf@gitster.dls.corp.google.com>
References: <6997784.RuzRO1AFsK@al> <283403992.8FOSVk7RPR@al>
	<D7697DE2C591421E8588920BD4FE0455@PhilipOakley>
	<4081616.27DjsMG0kb@al>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Wed Dec 03 00:50:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvxDY-0006c5-BM
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 00:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933405AbaLBXus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 18:50:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932722AbaLBXur (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 18:50:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E0C0239F8;
	Tue,  2 Dec 2014 18:50:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y/bsj8HwH8qB4LQH0ckBRI8fYhs=; b=F+Zw4M
	byJSg0pUTMlxYCyHaNNkzJgwGTJV7k6tnK9LOCETiQe2y6xOiJPXWrpPTvs0SpEb
	X6/f4cD8foEYixsMU8ycA6eTtOYvKlSRXSpHHY2YbIEKr23y9iy6rrtXSLJL2uk4
	ukO1dvEU3GYH6IQeMSalxq+Qg0HDFd7I5Eg+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FGuDZm9ZPTSAwnuL2XrMpBrwyUoQa1X4
	1Cpu56L5l1tAnhyoMzQcwGQMw6T/U9d+Y/zdFZsYiwDNJ4OjrRPYXzt9Ws73dTq9
	n9wInS54eE0TJX0sBcZLRrrAoWenBAejL3Y9+2FuJx2ztgX6hvl4BgYAG9BZRBpG
	ypL6+qwdIGM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46CAB239F7;
	Tue,  2 Dec 2014 18:50:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3FEB239F6;
	Tue,  2 Dec 2014 18:50:45 -0500 (EST)
In-Reply-To: <4081616.27DjsMG0kb@al> (Peter Wu's message of "Tue, 02 Dec 2014
	18:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 089B781E-7A7E-11E4-B22F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260600>

Peter Wu <peter@lekensteyn.nl> writes:

> On Saturday 29 November 2014 13:31:18 Philip Oakley wrote:
>> From: "Peter Wu" <peter@lekensteyn.nl>
>> > Ok, I will make a clear note about the default (without --only) 
>> > behavior
>> > having weird behavior for historical reasons. Are you really OK with
>> > --only=both? It sounds a bit odd (mathematically speaking it is 
>> > correct
>> > as fetch and push are both partitions that form the whole set if you
>> > ignore the historical behavior).
>> >
>> How about :
>> 
>> s/--only/--direction/
>> 
>> or some suitable abbreviation (--dirn ?)
>
> In the next version of the patch I went for three separate options,
> --fetch, --push and --both:
> http://article.gmane.org/gmane.comp.version-control.git/260213
> (Juno, Jeff: ping?)
>
> The option --direction=<fetch|push|both> is a bit longer and --dirn can
> be mistaken for "directory N".

If we have to have three variants, --{fetch,push,both} would be the
easiest to understand among the possibilities listed above, I would
think.
