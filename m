From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2015, #01; Thu, 2)
Date: Fri, 03 Apr 2015 14:28:43 -0700
Message-ID: <xmqqpp7kgaus.fsf@gitster.dls.corp.google.com>
References: <xmqqbnj6gp20.fsf@gitster.dls.corp.google.com>
	<155011F7-1806-4226-B085-F1F4206062C6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org list" <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 23:28:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye990-0001ca-TP
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 23:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbbDCV2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 17:28:47 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752586AbbDCV2q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 17:28:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7560844E78;
	Fri,  3 Apr 2015 17:28:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cBGbrQwObk0HjAg8hDnyUvKTHjo=; b=gSOpOK
	2mx+FXWpa0pgIp6G5xnsDs3XnQhd9RwEPgyPNpovy6cUno8hdoCHKtabsKNhPkBu
	G30ft7R9qVPi4lshbCPj1SH2r91q2t7MG/fh/q3ktPUCvb13DE5Y7UCqObQjj1O3
	aXFDnfqGpZNOi5EOoirPW9uzsfm7cUZ/NhpFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EiPG7zp4C6pgMRLhcdFQysqMYdDWAUtu
	+lwKMJLaUuMou/CpEEVJwNMkGtHnBSkpNREBpqWAESPXfU2CO9ijNLAWVpW02dOV
	Vu+re7waKqiQ6X8DdKeMEpQZKuCzOJd3YOgpS09X/nVEqaiBUoGDTy44nim8u/KB
	rI+39YnWt/M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EF8044E77;
	Fri,  3 Apr 2015 17:28:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E824F44E76;
	Fri,  3 Apr 2015 17:28:44 -0400 (EDT)
In-Reply-To: <155011F7-1806-4226-B085-F1F4206062C6@gmail.com> (Kyle J. McKay's
	message of "Thu, 2 Apr 2015 17:55:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6842AC86-DA48-11E4-8DDA-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266731>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> On Apr 2, 2015, at 15:09, Junio C Hamano wrote:
>
>> * jc/show-branch (2014-03-24) 5 commits
>> - show-branch: use commit slab to represent bitflags of arbitrary
>> width
>> - show-branch.c: remove "all_mask"
>> - show-branch.c: abstract out "flags" operation
>> - show-branch.c: lift all_mask/all_revs to a global static
>> - show-branch.c: update comment style
>>
>> Waiting for the final step to lift the hard-limit before sending it
>> out.
>
>
> May I ask, now that this topic is over 1-year old, please, what is the
> final step?

It would be to "lift the hard-limit"; all the existing changes are
to allow the limit to be lifted by moving from "bits in a word-sized
field" to "commit-slab that can hold arbitrary number of bits".

>
> Perhaps someone might submit a patch... ;)
>
> -Kyle
