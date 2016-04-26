From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/4] Add --base option to git-format-patch to record base tree info
Date: Tue, 26 Apr 2016 11:05:23 -0700
Message-ID: <xmqqlh40gs9o.fsf@gitster.mtv.corp.google.com>
References: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
	<CAGZ79kajpAtbHaKLaLHN5+qUOvBofFs-q-vUYWua49GWK7FO9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Xiaolong Ye <xiaolong.ye@intel.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Fengguang Wu <fengguang.wu@intel.com>, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 20:05:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av7MZ-0003M8-P4
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 20:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbcDZSF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 14:05:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751815AbcDZSF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 14:05:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 58DEF14A8C;
	Tue, 26 Apr 2016 14:05:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6BxJ9LqMltv9paW0RCVWVOVE09M=; b=np4Tln
	QriMC4awvqTz33i1twTJn6OqfTXjz8+1iKRDQraEkP5il0hELSzTvglbEW2Qm35O
	wR4SPW3yt5qLOpHL9krC747PVp35FRKC1ORoII32xBzMY/fwTtWq8/86uSRY5PCv
	3OxNKpcpaa4STBUVMnQplU77c5ays5DNfdz04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ncQ6GNpoLFANnq/IL5Vmgu4eWPxmC8pm
	rENULJQAGuTCUJmBBFqrdQOsb25xYbQxUqgk9hNkP8hZHxN0S5fJPHcoLZP36ZZu
	o8tNf4Rp6lL5xJwmsMdvAEQAFt6X5dCuqAkJClVBvpl4hm57SHfbQEiwSdiMKuTE
	uWcWdmVjdEc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F33B14A8B;
	Tue, 26 Apr 2016 14:05:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5A1E14A8A;
	Tue, 26 Apr 2016 14:05:24 -0400 (EDT)
In-Reply-To: <CAGZ79kajpAtbHaKLaLHN5+qUOvBofFs-q-vUYWua49GWK7FO9Q@mail.gmail.com>
	(Stefan Beller's message of "Tue, 26 Apr 2016 10:21:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 730A2766-0BD9-11E6-9BFB-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292633>

Stefan Beller <sbeller@google.com> writes:

>     git checkout origin/master
>     # toy around, do stuff
>     git checkout -b new-shiny-feature
>     git format-patch origin-master..
>
> Now I have set the format.useautobase option and then the `git format-patch`
> fails with
>
>     fatal: Failed to get upstream, if you want to record base commit
> automatically,
>     please use git branch --set-upstream-to to track a remote branch.
>     Or you could specify base commit by --base=<base-commit-id> manually.
>
> but as I indicated I want patches from origin/master onwards,
> Could we make use of that information?

As you indicated where other than in this e-mail?  

I think the way for you to indicate that desire expected by this
series is to use "git branch" to set upstream of new-shiny-feature
branch to origin/master.  Shouldn't that work, or is that too much
work?
