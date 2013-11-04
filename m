From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Mon, 04 Nov 2013 10:32:16 -0800
Message-ID: <xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>
References: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>
	<CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Greg Jacobson <coder5000@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 04 19:32:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdOwq-0003AC-V4
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 19:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852Ab3KDScV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 13:32:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35235 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758Ab3KDScU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 13:32:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9BF34D827;
	Mon,  4 Nov 2013 13:32:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FiVyIRtpxTbR3hZjQhcjY0BbGDk=; b=uBtw3H
	6WVz/rznX/HoTblkhNh73gd9pwhhXk2zHoC862F24wgl0umtIDgdBgwiJ8mH4ZDs
	Dw8V5QHUB5vtToQK2gmfELWdeP3QUtavH2ZS9WCVuRww6qm0zXtN55ENnDlTDKLe
	O/3L94WchKHibsn5IoBo5ZVfq+idP98/izRYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HCBGuV2I7Kimvu161NTt/QLTWQcXEzkx
	gQlsDIdnllkLA2UGFdhcPRCEfSJBn1ArC7wDRyEzJWtVm8jgiyBbddngOOboMl6M
	Krn1/RZz9kJIHyXIdlMDfMx4G2qxO7f3XF/ntEog6fph8ayDIzCdmn7tFGeZm/Fi
	19lo+yAyVeU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7C5D4D826;
	Mon,  4 Nov 2013 13:32:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 093984D823;
	Mon,  4 Nov 2013 13:32:17 -0500 (EST)
In-Reply-To: <CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>
	(Greg Jacobson's message of "Sun, 3 Nov 2013 08:35:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6F39E81A-457F-11E3-B577-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237294>

Greg Jacobson <coder5000@gmail.com> writes:

> Is there anything I could do to improve this patch?  Thank you.

My vague recollection is that we started from an excerpt from the
documentation page, not unlike this patch attempts to, but because
such an excerpt has to be less complete than the documentation for
brevity's sake, it is bound to be an incorrect and/or misleading
one, and decided that we are better off referring the users, who do
want to choose something other than the default we chose, to the
documentation.

Somebody cares to dig up the old discussion threads and post a few
pointers?

> On Fri, Oct 4, 2013 at 10:20 AM, Greg Jacobson <coder5000@gmail.com> wrote:
>> When the unset push.default warning message is displayed
>> this may be the first time many users encounter push.default.
>> Modified the warning message to explain in a compact
>> manner what push.default is and why it is being changed in
>> Git 2.0.  Also provided additional information to help users
>> decide if this change will affect their workflow.
>>
>> Signed-off-by: Greg Jacobson <coder5000@gmail.com>
>> ---
>>  builtin/push.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/builtin/push.c b/builtin/push.c
>> index 7b1b66c..5393e28 100644
>> --- a/builtin/push.c
>> +++ b/builtin/push.c
>> @@ -174,6 +174,15 @@ N_("push.default is unset; its implicit value is
>> changing in\n"
>>     "\n"
>>     "  git config --global push.default simple\n"
>>     "\n"
>> +   "When push.default is set to 'matching', git will push all local branches\n"
>> +   "to the remote branches with the same (matching) name.  This will no\n"
>> +   "longer be the default in Git 2.0 because a branch could be\n"
>> +   "unintentionally pushed to a remote.\n"
>> +   "\n"
>> +   "In Git 2.0 the new push.default of 'simple' will push only the current\n"
>> +   "branch to the same remote branch used by git pull.   A push will\n"
>> +   "only succeed if the remote and local branches have the same name.\n"
>> +   "\n"
>>     "See 'git help config' and search for 'push.default' for further
>> information.\n"
>>     "(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode\n"
>>     "'current' instead of 'simple' if you sometimes use older versions
>> of Git)");
>> --
>> 1.8.4.474.g128a96c.dirty
