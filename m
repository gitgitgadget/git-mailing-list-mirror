From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git subtree error (just how do you expect me to merge 0 trees?)
Date: Mon, 31 Dec 2012 21:54:01 -0800
Message-ID: <7vy5gdbg92.fsf@alter.siamese.dyndns.org>
References: <FBE22FDC-5800-40C8-9778-82DFD27579F6@drewcrawfordapps.com>
 <87licd3b7w.fsf@waller.obbligato.org>
 <7v7gnxd24h.fsf@alter.siamese.dyndns.org>
 <87d2xpwnty.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Crawford <drew@drewcrawfordapps.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Tue Jan 01 06:54:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpuoF-00040K-Ri
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 06:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937Ab3AAFyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 00:54:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63383 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932Ab3AAFyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 00:54:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82518BFF4;
	Tue,  1 Jan 2013 00:54:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P/6MDNJWcdFquSGjH5H3iXaKCbA=; b=wIXpQT
	k6c4RZhzPjau5R5qkonDBnHKGoaTNrWoP+SRfmb13ARhY2PwJEQRgaZkEcK46Zg4
	w/HLqEkLpMQnpbW/w1Ao7jyHl7VfR76NPBQCWhRrC++oG2px0ChKGzCS+6w/rpFr
	tpzZIKcXFQj7IxPV3M/qKjwvjyC3XWk6wcRzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N6085KVr3cDxSY/DpMmlq15BnbE5ZLM9
	C38Gp5XLYstLZyP0SvywWZZaW9wSNkSnha5CpM/bPYzlJ2Tms1oA+z8AGHpUEDac
	pzEuKXfCdpq8us7eT7w6ucsWj5TO8fGMr2mQ6Ek/MmTgIkxKV2a8vfegdRvkujtJ
	VMz/kwCiIjU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AA40BFF3;
	Tue,  1 Jan 2013 00:54:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C06C7BFF2; Tue,  1 Jan 2013
 00:54:03 -0500 (EST)
In-Reply-To: <87d2xpwnty.fsf@waller.obbligato.org> (greened@obbligato.org's
 message of "Mon, 31 Dec 2012 22:04:41 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6516B1A-53D7-11E2-B014-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212414>

greened@obbligato.org writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> With one positional option, git-subtree add simply assumes
>>> it's a refspec.  Is there an easy way to check whether a string is a
>>> proper refspec?  Even better would be a way to check if a string is a
>>> path to a git repository.
>>
>> Do you literally mean "a path to a repository" in the above, or do
>> you mean "a remote that is like what is accepted by 'git fetch'"?
>
> It's the latter as git-subtree calls git-fetch to do the work of
> getting revisions.

If that is the case, t should behave similar to 'git fetch' for
consistency.  If you want to name "current repository", you can
simply give "." as the repository parameter; this has long been
supported by 'git fetch' (as 'git pull . $branch' has been the way
to say 'git merge' for a long time).
