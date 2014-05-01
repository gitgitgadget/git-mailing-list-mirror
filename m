From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pull is Evil
Date: Thu, 01 May 2014 08:16:42 -0700
Message-ID: <7vbnvhil5x.fsf@alter.siamese.dyndns.org>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
	<xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
	<536106EA.5090204@xiplink.com>
	<xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
	<536152D3.5050107@xiplink.com>
	<5361598f8eaf7_4781124b2f02b@nysa.notmuch>
	<536173F5.7010905@xiplink.com>
	<53617877b41a9_41a872f308ef@nysa.notmuch>
	<20140501094610.GB75770@vauxhall.crustytoothpaste.net>
	<5362266a3ca00_284da2f2eca3@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 17:28:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfsuG-0004BS-0o
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 17:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbaEAP2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 11:28:12 -0400
Received: from b-pb-fb-quonix.pobox.com ([208.72.237.77]:46635 "EHLO
	b-pb-fb-quonix.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbaEAP2L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 11:28:11 -0400
X-Greylist: delayed 791 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 May 2014 11:28:11 EDT
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com [208.72.237.35])
	by b-pb-fb-quonix.pobox.com (Postfix) with ESMTP id 66E1B1058E;
	Thu,  1 May 2014 11:14:54 -0400 (EDT)
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40A9C7BF37;
	Thu,  1 May 2014 11:14:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l7Np7vpc5F65JiEWkjau774EHzM=; b=Lekecq
	hUlhJmweLTvJ2zldlZK67I229a8YrYEFziTD/V6Jr70UYF7DHJq4S7W0tqhXqxND
	5Rc8yQQfgs+uHGOZzvWyZpAjwiS+JBMvrz2lBgyJ02h0VAeLVQwveEayptTFyuQO
	wwAHuuU1KEO3CUe5aLLLmF5ypJYpTsHkmGFRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m0XuLWnWor7gzFPanluZ8LIc2Pt+urqw
	YAvhbJBFZy4n7pRDT9iwgQzFE8/IChuSNDC5Tt7Ay4wrcldFr4VvN8LZilHBoZAw
	1CYIPRLZ2q27mp+3heq8E/pQ/yn5Az5S+oFCNlTDrT6050DG7pSyy8kzzEHsPzco
	yDOhJ6Q86NA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 253AE7BF36;
	Thu,  1 May 2014 11:14:54 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61A2B7BF33;
	Thu,  1 May 2014 11:14:51 -0400 (EDT)
In-Reply-To: <5362266a3ca00_284da2f2eca3@nysa.notmuch> (Felipe Contreras's
	message of "Thu, 01 May 2014 05:48:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 57A520CA-D143-11E3-B0BE-9131D3124DD0-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247815>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> brian m. carlson wrote:
>> ..
>> At work, we have a workflow where we merge topic branches as
>> non-fast-forward, so that we have a record of the history (including who
>> reviewed the code), but when we want to just update our local branches,
>> we always want fast-forward:
>> 
>>   git checkout maintenance-branch
>>   # Update our maintenance branch to the latest from the main repo.
>>   git pull --ff-only
>>   git pull --no-ff developer-remote topic-branch
>>   git push main-repo HEAD
>> 
>> So there are times when fast-forward merges are the right thing, and
>> times when they're not, and as you can see, this depends on context and
>> isn't per-repository.
>
> That's not what I asked.
>
> I didn't ask you if fast-forward merges were the right thing to do in
> every situation.
>
> I asked you, *when* people do a fast-forward merge (that is; when it's
> possible and desirable), what are the problems that a fast-forward merge
> causes?

But then I think you asked a wrong question.  The opposite case of
the question tells me what is wrong in it:

    When people do a real merge (that is: when it's possible and
    desirable), there is no reason to forbid 'git pull' from creating a
    real merge.  What are the problems that a real merge causes under
    that condition?

By definition, because of "when it's possible and DESIRABLE" part,
the answer is "absolutely zero".  That is not an interesting
question, is it?

My reading of the design of the "let's forbid non-ff merge when
people do 'git pull'" is based on this reasonong:

 - Most people are not integrators, and letting "git pull" run on
   their work based on a stale upstream to sync with an updated
   upstream would create a merge in a wrong direction and letting
   user continue on it.  We need to have a way to prevent this.

 - Forbid "git pull" when the HEAD is based on a stale upstream,
   i.e. the pull does not fast-forward.  Integrators that would want
   to _allow_ real merges may be inconvenienced so we will give a
   configuration to let them say that with pull.mode=merge.

 - We do not forbid "git pull" if the pull will fast-forward.  We do
   not do anything for that case, because everybody will accept
   fast-forward, whether he is a contributor or an integrator.

Doesn't Brian's case show the justification "because everybody will
accept fast-forward" does not hold?  It shows that the user do not
necessarily know when it's possible and DESIRABLE, and updating the
command is about helping people avoid an action that may not be
desirable in the end.

Brian needs a way to make sure he fast-forwards when pulling the
project's maintenance-branch into his maintenance-branch, and also
he does *not* fast-forward when pulling developer's fix branch into
that same maintenance-branch of his.  So neither pull.mode nor
branch.*.pullmode would help him and the example may show we need a
bit more work to help that case, no?
