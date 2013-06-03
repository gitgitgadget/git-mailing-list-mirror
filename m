From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] completion: add common options for blame
Date: Mon, 03 Jun 2013 10:24:56 -0700
Message-ID: <7vmwr7gl93.fsf@alter.siamese.dyndns.org>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
	<1370181822-23450-4-git-send-email-artagnon@gmail.com>
	<87mwr7zhv5.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:25:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYVE-0003C0-Cg
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759286Ab3FCRZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:25:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48638 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753795Ab3FCRY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 13:24:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ED1824CB2;
	Mon,  3 Jun 2013 17:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=os6iGlMcTjptU/QiYFaAfsdHuj8=; b=CXXTzm
	MQR8XP8LQvSo9B4JFAcCnKT17XrJrtrARNuUF8K8tNpTGbR/anr2DfetvyH8fl1s
	r6kwF02CwuSq5itvSzjpigiEZpJ6xv2ri18fYv80MgA9HkV5X1/JVOH91i1jQQM3
	AOXsnSMSnuqqUsya/wEt9+JHEnpvFozMHYb5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xqjQuIDfqZzpRZ7wGhJDI3QnU9VqFwdP
	He6t64NQppiBppPgZ1PwoXhye3//iSc+AjgSqfGklT8pR7Bse//x2mTxTwpofxww
	YyJJRx9pi68p5DVl5By4CXupnb2HlCTSp554G7oRauwsxDiEdyWlHBwMdvMip9PM
	mKEGX9Z+QQA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92CD424CB1;
	Mon,  3 Jun 2013 17:24:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02FD724CAD;
	Mon,  3 Jun 2013 17:24:57 +0000 (UTC)
In-Reply-To: <87mwr7zhv5.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Mon, 3 Jun 2013 11:03:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83918E20-CC72-11E2-B90A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226242>

Thomas Rast <trast@inf.ethz.ch> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Add support for completing 'git blame'.  List only the common short
>> options.
> [...]
>> +_git_blame ()
>> +{
>> +	__git_has_doubledash && return
>> +
>> +	case "$cur" in
>> +	-*)
>> +		__gitcomp "-M -C -L -s -w"
>> +	esac
>> +	__git_complete_revlist_file
>> +}
>
> Is this the first time we introduce completion (I guess you could call
> it "help") for short options?  I only did a quick search for /-. -/ but
> it certainly seems that way.

Yeah, I do not think this is a good idea.
