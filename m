From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2012, #09; Thu, 27)
Date: Fri, 28 Sep 2012 10:29:19 -0700
Message-ID: <7vvceym4y8.fsf@alter.siamese.dyndns.org>
References: <7v3922om03.fsf@alter.siamese.dyndns.org>
 <5065ACCE.3060302@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 19:29:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THeNY-0005AK-SX
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 19:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758602Ab2I1R3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 13:29:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46839 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758424Ab2I1R3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 13:29:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8B8B85BF;
	Fri, 28 Sep 2012 13:29:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GLCkLW2jJflt2or+fCt7/ZbgZRQ=; b=jW1NnL
	gokRBiU6gUeEnXAlKeK2t5+ScAM0pUbkaQk1B/L+iVChWPT7eiiCL7M7RvDdNYaL
	/QaDL762yB7k3pPN5ZUpgDVa8jlWO9dlXqEDaSMREZ0hum2NL91/VETM8xZUhTcl
	QLKTg/npJWL97D2CqP4KpuGO/Di8r5xD2W/FM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H0CwIitXUyHy7+U7g4bLcL94CxK5pMOA
	OEfoA7eZRqsyxoLYUbDTs8Cw3+oj4BKgucxEQ/lZbnyjINOjYcSgHJEMqCFXwWHf
	riSf4/vQ5qRosKothI2VCZ6jgjtR57zRnE0Zt2TT2/hP1oR/PzTu/JSmkYP48JD4
	qR20Vu75JQs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5CE785BE;
	Fri, 28 Sep 2012 13:29:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 458DA85BD; Fri, 28 Sep 2012
 13:29:21 -0400 (EDT)
In-Reply-To: <5065ACCE.3060302@xiplink.com> (Marc Branchaud's message of
 "Fri, 28 Sep 2012 09:57:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A0B4DFA-0992-11E2-9FAF-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206587>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 12-09-27 11:38 PM, Junio C Hamano wrote:
>>
>> * mb/remote-default-nn-origin (2012-07-11) 6 commits
>>   - Teach get_default_remote to respect remote.default.
>>   - Test that plain "git fetch" uses remote.default when on a detached HEAD.
>>   - Teach clone to set remote.default.
>>   - Teach "git remote" about remote.default.
>>   - Teach remote.c about the remote.default configuration setting.
>>   - Rename remote.c's default_remote_name static variables.
>>
>>   When the user does not specify what remote to interact with, we
>>   often attempt to use 'origin'.  This can now be customized via a
>>   configuration variable.
>>
>>   Expecting a reroll.
>>
>>   "The first remote becomes the default" bit is better done as a
>>   separate step.
>
> Unfortunately my days have been too full to progress this.  I'm still
> planning to get to it when there's an opportunity.  The next iteration
> would add the settings required to enable the migration plan that
> Junio outlined here:
> 	http://article.gmane.org/gmane.comp.version-control.git/201332
>
> In the meantime, anyone else who feels like taking this up is more
> than welcome.  The relevant threads are:
> 	http://thread.gmane.org/gmane.comp.version-control.git/200145
> 	http://thread.gmane.org/gmane.comp.version-control.git/201065
> 	http://thread.gmane.org/gmane.comp.version-control.git/201306

Thanks.
