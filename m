From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug/request: the empty string should be a valid git note
Date: Mon, 22 Sep 2014 10:39:00 -0700
Message-ID: <xmqqoau7lfm3.fsf@gitster.dls.corp.google.com>
References: <F9750CC0-3FAC-4B50-AB6A-BFD6A7D0BE97@trifork.com>
	<CALKQrgd9BPUTrgZvFCj_fznRG6RmfiGzW68XF++yykMguypTig@mail.gmail.com>
	<1A2394C0-50A4-40F4-B0B9-B2EC38109083@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>,
	"James H. Fisher" <jhf@trifork.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 19:39:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW7Zt-0003Iw-Rn
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 19:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbaIVRjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 13:39:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55361 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753958AbaIVRjD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 13:39:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 596D83C268;
	Mon, 22 Sep 2014 13:39:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9hLTNpArahuisYElJQ59Rkxkf1A=; b=DH4SE3
	sFvwfJw+mKcmGlA8XLBOKGpPLQ8CZv72IRrGJerOdUCb2pgVhG8+5OPxgmXnOzXV
	SyWlMDJ7VteevTc/weUktxXP3muqQZm0f0JKQ3FgYZPVcKDusjAvoKItJzlHEcC+
	1k/5gwNHQycASCDM/l/D+rQi71F8RNN8lfft8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RrQtPcmvhntU6T7P1Gk+ARg07T2OuZ9U
	GYTajl1fi7DOkJw7v2PLLfO8dqiHos3ZPPCFPlQyc6f3mcPRfNF9ZQMAa8HzC6gn
	6XSanuN6oFnQ/3YtaxN6B4EdkHDCwWzsvxQvPl0voZrIHoooGmjOICauLNqJZbTX
	hk6JMNUuB28=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4CFE93C267;
	Mon, 22 Sep 2014 13:39:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A80A63C264;
	Mon, 22 Sep 2014 13:39:02 -0400 (EDT)
In-Reply-To: <1A2394C0-50A4-40F4-B0B9-B2EC38109083@gmail.com> (Kyle J. McKay's
	message of "Sun, 21 Sep 2014 16:32:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 57A9F962-427F-11E4-95EF-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257370>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> On Sep 20, 2014, at 18:44, Johan Herland wrote:
>
>> At least, we should fix
>>
>>    git notes add -C e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
>>
>> Whether we should also change
>>
>>    git notes add -m ''
>>
>> to create an empty note, or leave it as-is, (i.e. similar in spirit to
>> "git commit -m ''"), I'll leave up to further discussion.
>
> The help for git commit has this:
>
>   --allow-empty-message
>     Like --allow-empty this command is primarily for use by
>     foreign SCM interface scripts. It allows you to create
>     a commit with an empty commit message without using
>     plumbing commands like git-commit-tree(1).
>
> Why not add the same/similar option to git notes add?

Sounds like a good direction to go.
