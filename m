From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] VCS helpers
Date: Fri, 04 Sep 2009 10:03:22 -0700
Message-ID: <7vd466lk11.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0909032213120.28290@iabervon.org>
 <7v63bz198j.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0909041141020.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 19:03:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjcCP-0003wt-Fx
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 19:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933478AbZIDRDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 13:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932873AbZIDRDf
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 13:03:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932751AbZIDRDe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 13:03:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 462F0256F2;
	Fri,  4 Sep 2009 13:03:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Jtk2AWJi8bp5pMkmL7Op7GmZFbs=; b=SFqe/fjFe6wE9fkXAH0D+mq
	d5UjarZOHJMtytxhVjXNkHiUotiEA+wp1ULJqHD5RqEVV7YuEQJa+PfyDCtEXNww
	fbSVPOtPc/FAZZcEqO9y/L0ZxEbAle4T9IQJESfGS+Y6s4r3Bq17RvTdGvS4OUCr
	zpkG+f34WYk1gont/1mo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=wP86Wd/lhre2n+HBxpf4FixYoD3RyOKxp83NZ1qg1ly4aesXN
	sB2BW241qn7h5ucc6Ah7m4DS8Z3hsLi8K9dZTh3h6UmiV+HcDVwWUcBJa4P8QkH0
	Bl8qKibWEBCQQy5hOZ9JMIy6tdnsRjpDtdchKlQyIMyHb0grZmDlCbaZ2w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F2FF256F0;
	Fri,  4 Sep 2009 13:03:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3152F256ED; Fri,  4 Sep
 2009 13:03:24 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DF5CBBF6-9974-11DE-A74D-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127747>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Fri, 4 Sep 2009, Junio C Hamano wrote:
>
>> Because the theme of the topic does not have anything to do with fixing
>> the deepening of shallow clones nor giving an extended error message from
>> non-fast-forward git-push, I queued the series after reverse-rebasing onto
>> old db/vcs-helper~8, in order to keep the topic branch pure, instead of
>> merging unrelated topics from maint, master or next into it.  The result
>> merged in 'pu' obviously has to match what you expected by applying the
>> patches on top of 'next', and I am reasonably sure it does.
>
> I'd thought that topics in pu were carried as based on next, particularly 
> once they depend on something (e.g., the beginning of the series) in next. 
> I suppose there's better options, but what do you do to find them? (Feel 
> free to refer me to the "note from the maintainer" if it's there, but I 
> don't remember that detail)

Oh, I was *not* complaining that you gave a patch based on 'next'.  I was
merely explaining what I did to your patch, in case somebody wonders why
the output of "log -p -8 db/vcs-helper" looks different from what you
posted on the list.  I also wanted you to verify the result.

> FWIW, there was a semantic mismerge in the original basing of this series 
> on 07a4a3b496, which I finally fixed in this version; the code to handle 
> NULL urls in builtin-fetch was after a new conversion of the url.
>
> In any case, I think both the reverse-rebase and merge are correct.

Thanks.  Actually, the fact your patch was based on 'next' did help me
verify the result of the rebase and the merge.

It is a good discipline to spend some extra effort to keep a topic pure if
and only if the other topics that the topic textually depends on were of
more dubious quality than the topioc itself.  In such a case, there is no
guarantee that they graduate ever, and the topic will be blocked without
major effort later.

It does not matter in practice when we are reasonably sure that other
topics that the topic depends on are likely to be already in when the
topic is completed.  In this particular case, many of the changes the
reverse rebase needed to remove are in fact already in master and some are
even in maint, and in retrospect, there was not much point doing this only
to risk mistakes.

In fact, I originally merged the commits whose changes overlapped and were
already in master (Nico's "deepening shallow", Matthieu's "give better
warning to non-fast-forward push", to name a few) on top of the part of
db/vcs-helper that was already in 'next', and then applied your patches on
top of the result, as a middle ground solution.  The topic would not have
been as pure as the result I pushed out, but it would still have been much
better than merging the whole master before applying the series.

The principle of keeping the topic branch pure in this case may fall into
my OCD ;-).
