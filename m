From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2013, #05; Tue, 12)
Date: Wed, 13 Feb 2013 20:36:11 -0800
Message-ID: <7vtxpf341w.fsf@alter.siamese.dyndns.org>
References: <7v621xdql8.fsf@alter.siamese.dyndns.org>
 <CAH5451nPKq8DKwo+Bkxh08N-wqrYCY4BihbvaE14z5iGVA1iZw@mail.gmail.com>
 <7vsj51caqb.fsf@alter.siamese.dyndns.org>
 <CAH5451mmXg=xvb-gW0qNvp7f8M5Jk5_ZS+UHAzMaGhJ677zWmw@mail.gmail.com>
 <7vpq04b5e2.fsf@alter.siamese.dyndns.org>
 <CAH5451kogwuzOs+BrHksDSdECbHrmW8DwTve0_kKq+-PTx+4bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 05:36:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5qYs-0005AP-Om
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 05:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757520Ab3BNEgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 23:36:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39609 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755111Ab3BNEgO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 23:36:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBFF38A83;
	Wed, 13 Feb 2013 23:36:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UIRkYgCE4AHQYL0ShtLdBi7n/YQ=; b=hfU+yB
	2PUWkA014rAikdWImxzpdQ9ROa/KBLwjwAfOrMSBxYD3pPY20iloXT3QZlvvII58
	PaGqFwIKqJmgGTbeAPmVR7Zgeb4GB+Kk3fFGZ2xoqiZaij2EIVVcIzSj3dJ7wLxv
	0PRMnUX0bNpp/DIGyguSjyG2TatdFZv6K8Ev0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pRskeUgyQeiafUDjuET9VAt3gBTJWfVq
	ptyM6o84Brkzns41iDyiUlLl4kRD7r8mvmYL1PfWlqrwr/pkvczUZKecMJLZmdoc
	iRrKZGwrBeac912KYCj5UkUpt9eW3R8q9BpptmNMzPKKDI7dsHzht3ub4xGgKf+2
	FpFJRlgvPgs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEFD48A82;
	Wed, 13 Feb 2013 23:36:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F2298A81; Wed, 13 Feb 2013
 23:36:13 -0500 (EST)
In-Reply-To: <CAH5451kogwuzOs+BrHksDSdECbHrmW8DwTve0_kKq+-PTx+4bw@mail.gmail.com> (Andrew
 Ardill's message of "Thu, 14 Feb 2013 13:43:55 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FF76F6A-7660-11E2-A63F-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216297>

Andrew Ardill <andrew.ardill@gmail.com> writes:

>> We've discussed that before.
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/171811/focus=171818
>
> Something that I couldn't find discussed was the option of, rather
> than providing a config to 'turn it off', inverting the current
> default/flags combo.
>
> That is, currently git add defaults to not staging file deletions, and
> we provide command line flags to include them. The consensus in the
> thread is that it is better to stage them by default; it seems
> reasonable to me that if we stage deletions by default we should
> provide flags to _not_ stage them. If that was the entirety of the
> change, would your position from that thread, "if we need this
> optional, then it is not worth doing this", still hold?

If that is the change we are going to make, and if you can guarantee
that nobody who is used to the historical behaviour will complain,
then I am fine with it, but I think the latter part of the condition
will not hold.

> Some people would be adversely affected by this change, but any
> objections I can come up with are not game stoppers.
> - It is possible newcomers might stumble at deleted files being staged
> for commit by a command called 'add',...

New people are fair game; we haven't trained them with the
"inconsistent" behaviour, and the default being different from
historical behaviour will not affect them adversely.

> - For people who rely heavily on file deletions remaining out of the
> index, providing a flag allows them to keep their workflow.

Allowing to do the things they used to be able to do is a bare
minimum.  You are still forcing them to do things differently.

> - For scripts that rely on this behaviour, a flag allows it to be
> updated, though it may break in the meantime.

Likewise.

> Finally, making this change makes sense from a consistency point of
> view.

That is a given. Otherwise we wouldn't be even discussing this.
