From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-merge.txt: weaken warning about uncommited changes
Date: Tue, 18 Jun 2013 07:57:23 -0700
Message-ID: <7vmwqn8o18.fsf@alter.siamese.dyndns.org>
References: <1371544975-18703-1-git-send-email-Matthieu.Moy@imag.fr>
	<CALkWK0=USVa2htHSTyj4C7FrKEko-e_UGAnu-3UNvx_ue1vwig@mail.gmail.com>
	<vpqppvju794.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 18 16:57:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoxLf-0007UF-7R
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 16:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156Ab3FRO51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 10:57:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755280Ab3FRO50 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 10:57:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C83BB28ECD;
	Tue, 18 Jun 2013 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9rH0Tom+Xjdd9i5mEtSi1bf7z4E=; b=C/GVVp
	32laxfQwIDvtHRFXsl3wllcKGJCoTzTMa9Oh2yuF0oIjmEyaI5R1zBD/4X1MFJnp
	gQXQHRLDfF1ZlQh3v1oo7fPB52/wuvF/Y0/Eq43KVUFC6leUkTEwJXPmgAG0CmCq
	qL8Pre9vnGzYHDRQlsFI6jaNQFzPC6wBlSrfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=US32BuXDnTojndXE9Gk0rQr4v+9nTNtD
	3+IIEHEBEI/4Yr0p6s0lZpRaU2xN99ylEq/l5i4fvbikrQLOxazhPJSQLnIk76G3
	RMftYzauzzsgRK0UUNw/wlFJijwvyIDmGyZJskhcAidENDh7ZsA6Z0UpYnGoZRI/
	kja9gKM59Ww=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB4DD28ECC;
	Tue, 18 Jun 2013 14:57:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3728E28EC9;
	Tue, 18 Jun 2013 14:57:25 +0000 (UTC)
In-Reply-To: <vpqppvju794.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	18 Jun 2013 10:56:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6317C4F0-D827-11E2-A6DE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228245>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Matthieu Moy wrote:
>>> Weaken the warning by discouraging only merge with /non-trivial/
>>> uncommited changes.
>>>
>>> I don't think documenting all the failure cases in the doc would be a
>>> good idea, so I've left the "in some cases" part.
>>
>> It's already documented in the pre-merge checks section, as Jonathan
>> pointed out [1]. 
>
> I had missed this one. But that's not the only case, you may also have
> problems with renames. The complete list would be really long to have
> here, and won't bring much to the user.

True.

After having re-read the thread up to the message from Jonathan, I
suspect that a "merge" half of "pull --autosquash" series (which had
to be dropped) was based on a misunderstanding and we didn't have to
have that discussion if the documentation were a little less
discouraging about merging in a dirty working tree?

>> We should update the documentation to point to it: I do not think
>> "non-trivial" is much of an improvement.
>
> Actually, I think it essentially says it all. If your changes are
> important enough to deserve a real backup, you should stash or commit.
> If you're ready to take the risk of losing it (the risk is small, but
> does exist), it's OK to run "git merge" blindly.

Your documentation update makes sure that we are less discouraging,
I think.  It does not have to be the only phrasing (hinting others
to try to come up with a beeter version if they are so inclined),
but it is going in the right direction.
