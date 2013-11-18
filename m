From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: fix --verbose output column alignment
Date: Mon, 18 Nov 2013 11:27:15 -0800
Message-ID: <xmqqeh6dbje4.fsf@gitster.dls.corp.google.com>
References: <1384453081-7679-1-git-send-email-hegge@resisty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Torstein Hegge <hegge@resisty.net>
X-From: git-owner@vger.kernel.org Mon Nov 18 20:27:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViUTj-0000Lr-NR
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 20:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659Ab3KRT1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 14:27:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37969 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976Ab3KRT1S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 14:27:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 245B5524A8;
	Mon, 18 Nov 2013 14:27:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z5xmmGv1iIQqLZu7hLLT1yYErzo=; b=vp1jjj
	PmGV4ghOEqnXGr775puAWNEodnUw/kFXIgwBU3ZrDy9bIdJ22OzRVWL1vNR54GQ7
	DkzxyAi7Om5JgufhHhhg5VHPwR04H5nfPAa3crK3T6NSPwE72Fm+F8LyHr3YjMrp
	rw2cmlbz1NIHJbF/+k+2kUdYvHPyQWnUOuaZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SyosRjls0g9cnOvsjHQiVzQo6vhFsOgD
	VpgSL5KAn+ZN6kQ17kBRsNsVzAp3W+70rxJvHqQ8Sfb7WEZESHVBjQPpzMP45TrS
	mjuHRsivgrWbZiDrB3JV5TJADjTUGsapu1RKEfjDd/rTCSR6N/TnoqwMtKBL3OJt
	xcTZ6SOHuBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14263524A7;
	Mon, 18 Nov 2013 14:27:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5518D524A6;
	Mon, 18 Nov 2013 14:27:17 -0500 (EST)
In-Reply-To: <1384453081-7679-1-git-send-email-hegge@resisty.net> (Torstein
	Hegge's message of "Thu, 14 Nov 2013 19:18:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6F8D51F4-5087-11E3-98E2-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238008>

Torstein Hegge <hegge@resisty.net> writes:

> Commit f2e0873 (branch: report invalid tracking branch as gone) removed
> an early return from fill_tracking_info() in the path taken when 'git
> branch -v' lists a branch in sync with its upstream. This resulted in an
> unconditionally added space in front of the subject line:
>
>     $ git branch -v
>     * master f5eb3da  commit pushed to upstream
>       topic  f935eb6 unpublished topic
>
> Instead, only add the trailing space if a decoration have been added.
>
> To catch this kind of whitespace breakage in the tests, be a bit less
> smart when filtering the output through sed.
>
> Signed-off-by: Torstein Hegge <hegge@resisty.net>
> ---

Thanks.
