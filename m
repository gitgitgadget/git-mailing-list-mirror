From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A better git log --graph?
Date: Wed, 07 Jan 2015 08:35:03 -0800
Message-ID: <xmqq61cilfbc.fsf@gitster.dls.corp.google.com>
References: <m8jfg5$dsp$1@ger.gmane.org>
	<CALKQrgdrS0RkKe-5UN_HabkLYsZ+GGL=3SNqb_ij3W5z1R6ZTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Yuri D'Elia" <wavexx@thregr.org>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jan 07 17:36:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8taX-0005k7-JV
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 17:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbbAGQf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 11:35:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60327 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752713AbbAGQf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 11:35:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20421298C0;
	Wed,  7 Jan 2015 11:35:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rltC05fizCn3TG94gG929IPXos4=; b=KSDrLU
	p0Mzl0b+PNsfzZvE2YBSNw2W+Il8ZjO3HvSMNoqEWtiA3refLrTZuT001eZJqQbi
	7OHUx4R5v4/z0EpczWd/xR4FBzoBNeVL+V54WOo0/ovaVUQ/Quv/ZdfgQddhykcV
	gMquqIuWjpzudD0FmjJMKVuNHNtzdhtE3MqxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vKEVjr3M3car7l+r4zn8Kf1SXAXh7dyp
	c1Q4eppLDlMjWRYzjCckWXBIi+xx+FesP/tK9nSCn9OziYTuPDMnb6CXwcb0V5yr
	rXjsinzYUF8fmnhvYl8BrEvMKA6wx+pFzRQlw/LEDc9xPlZ8/vsRW5xxhTZ7Kip3
	rXjvRtwSUrw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 14A2F298BF;
	Wed,  7 Jan 2015 11:35:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C30E72988B;
	Wed,  7 Jan 2015 11:35:04 -0500 (EST)
In-Reply-To: <CALKQrgdrS0RkKe-5UN_HabkLYsZ+GGL=3SNqb_ij3W5z1R6ZTg@mail.gmail.com>
	(Johan Herland's message of "Wed, 7 Jan 2015 16:47:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 224DEA34-968B-11E4-AB6E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262138>

Johan Herland <johan@herland.net> writes:

> Have you looked at git show-branch --all?
>
> ...Johan

Yeah, sounds vaguely like it.  Its display certainly is easier to
read while the set of branches you have is minimum and everything
fits in a window; that is exactly why I wrote it back when the
branches I was handling were toy-sized (I am not saying Git itself
was toy-sized---the work-in-progress on top of Git I was doing was).

>
> On Wed, Jan 7, 2015 at 3:23 PM, Yuri D'Elia <wavexx@thregr.org> wrote:
>> Hi everyone,
>>
>> git log --graph is hard for me to parse mentally when developing a
>> project which has a lot of branches.
>>
>> All the tools I've been using seem to just parse log --graph's output,
>> and thus are no better at showing history.
>>
>> I would love to have a graph mode where each branch is assigned a
>> column, and stays there. If my log section shows the history of 3
>> branches, column 1 should always refer to master, 2 to the hypothetical
>> "development" branch and 3 to "feature".
>>
>> Of course the mode will waste more horizontal space, but it would be
>> immediately more apparent which branch is merging into which.
>>
>> I saw this idea proposed a couple of times in the mailing list, but I
>> saw no "action" behind the proposal. Since I don't have time to work on
>> it, has anyone already started some work that he would like to share as
>> a starting point? Even just to have a felling if it's worth the effort.
>>
>> Does anybody know of another tool to graph the history using something
>> that is not based on git log --graph?
>>
>> I've seen a couple of graphviz-based ones, but both failed to work out
>> of the box for me.
>>
>> Thanks a lot for any pointer.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
