From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Documentation: git log: --exit-code undocumented?
Date: Mon, 01 Dec 2014 08:37:32 -0800
Message-ID: <xmqqa937qqb7.fsf@gitster.dls.corp.google.com>
References: <87zjb78u7g.fsf@osv.gnss.ru>
	<xmqqegsjqqox.fsf@gitster.dls.corp.google.com>
	<87wq6bgwl6.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 17:37:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvTym-0007fo-Ti
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 17:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbaLAQhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 11:37:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752710AbaLAQhf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 11:37:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09EC11F0ED;
	Mon,  1 Dec 2014 11:37:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PPPTEUnfzW7NEWYUeSYBpXb9Rhc=; b=dpeFSa
	VTIW/t7Zdj9aHcLhc0afy0pPdjkBV9ys4jAN1dCKDfgb8DM3JIFmgmmug9dWBrQM
	XMMxHrTFUIsOBjQnge/vTQvapJz8H5cjW2BSPiwrOVMjdYD9QGPkLCSQY3HUVm1O
	9dy0TFiBd7+0ASbAnXCfvL0YlFZnNlduAfO8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LwOBU8mCWVETa+SrZMfcHnWWidBYKE8I
	t1z9aQVNSX2IgHSxAZKJ8YtQVtQQ2kYCNyuzmOv6Uw3SpumYAl7D597EAFQWUipX
	ycsIsyCTOM8m34PSV2a87zPI4992njJgXC6mDlRHDCaDuDZg7g3bXt60PyIl5Sit
	+pKvLaZ9P+4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F42371F0EB;
	Mon,  1 Dec 2014 11:37:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E5071F0EA;
	Mon,  1 Dec 2014 11:37:33 -0500 (EST)
In-Reply-To: <87wq6bgwl6.fsf@osv.gnss.ru> (Sergey Organov's message of "Mon,
	01 Dec 2014 19:32:05 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 599F778A-7978-11E4-9A9C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260492>

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> Hello,
>>>
>>> $ git help log | grep exit-code
>>>            problems are found. Not compatible with --exit-code.
>>> $
>>>
>>> What --exit-code does in "git log"?
>>
>> It doesn't.  That is why it is not listed.
>
> Then, how can --check possibly interfer with it?

The description is shared with "git diff" and friends, which is
invoked via "git log -p".  As "log" does not give the exit code
of individual "diff-tree" invocation for each commit, --exit-code
option is irrelevant.
