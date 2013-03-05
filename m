From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git rebase" loses the additional changes in "evil" merges
Date: Tue, 05 Mar 2013 13:35:40 -0800
Message-ID: <7vy5e1sf6b.fsf@alter.siamese.dyndns.org>
References: <201303042058.r24KwwEx012408@freeze.ariadne.com>
 <7vtxoqx3s1.fsf@alter.siamese.dyndns.org>
 <201303052118.r25LIoAC000463@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dale Worley <worley@c-66-31-108-177.hsd1.ma.comcast.net>
X-From: git-owner@vger.kernel.org Tue Mar 05 22:36:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCzWu-00075B-AR
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 22:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440Ab3CEVfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 16:35:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931Ab3CEVfp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 16:35:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06448BB1D;
	Tue,  5 Mar 2013 16:35:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l7Y4loFyNvL7F9wsztA5QuAncjM=; b=mc9v3u
	CrfzGPNgJzmd0uK7LHRWk/oKEM+jDEQ4MIY+jsodHApZnN9KhtRBNqmYa3+fEmFL
	SZAdaBX5NHRjZWMY9oHwuU1jQThTCuJM/JrSOHGYuYcz26bfQemD+UNpCunF+agS
	rLGthX5C69p4bOjQibSZlZayecZXH6OcHWjHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pGdKBvWrD4rkB+Q06wu4780hFJQKlAHR
	5hmgsAnmWY9yh1YMSqy69gFkvnNVWN21cBwMyHUEAnupXAtxd7JzK545IeEpmYKa
	mwiDdAqibj50OhHiEYlYFFlIbbATXdEysMRKP82DjjOlDeGMryJErYwDdKj4anVZ
	uFCBfrCXvqs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EECBABB1C;
	Tue,  5 Mar 2013 16:35:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71C43BB17; Tue,  5 Mar 2013
 16:35:42 -0500 (EST)
In-Reply-To: <201303052118.r25LIoAC000463@freeze.ariadne.com> (Dale Worley's
 message of "Tue, 5 Mar 2013 16:18:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A196E618-85DC-11E2-8D81-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217484>

Dale Worley <worley@c-66-31-108-177.hsd1.ma.comcast.net> writes:

>> From: Junio C Hamano <gitster@pobox.com>
>> 
>> I think this is to be expected for "git rebase", as it does not even
>> look at merges.  It is a way to find non-merge commits that haven't
>> been applied yet, and apply them to the upstream to create a new
>> linear history.
>
> I disagree. "git rebase" is not characterized as ...

The intention has always been "I have these patches, some were
applied upstream already, now what do I have left?".

You do realize that you are disagreeing with somebody who designed
the original "git rebase" (before the --preserve-merges was added),
do you?
