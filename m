From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Master and origin/master diverged
Date: Fri, 22 Jun 2012 16:59:01 -0700
Message-ID: <7v1ul6nbju.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi1Ot0Fyv=2_XYKyUcsKp-m+CkT-miF=jC=wt9Rbz_dXqQ@mail.gmail.com>
 <4FE4C0F7.2080309@gmail.com>
 <CAE1pOi2MN_c76UBeRzdRbU8s+0LzYVoVcJ13V0di=HQobj+aDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 01:59:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiDkw-0006He-4Z
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 01:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050Ab2FVX7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 19:59:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753378Ab2FVX7H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 19:59:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A2018382;
	Fri, 22 Jun 2012 19:59:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZqmP/gmrV6iRLHLeTZ/rYex/f2s=; b=a2HYoU
	wUTAt1RXfKquAJUoKeK5MRVHWrwwpDxzhYhj7Ux4scCU4kU5CDp0t05xL/OerD+6
	Y39nVcMR3hG67ssDjvzOu3UR+tr42Ftot6V3vnccN8/BSuGODW1NBhPu/z6ltF0Y
	IgPhRtNCAMwcjFBbj94RX2/dUFQTAzvrlVBcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y+kWTByqASzWJ/e7rC/4QDkgDpcvMwdB
	TJiY7Z50lsR8uEJQCM6vFAYsYNtfCXXcUsTd1XfWv0ckFZXWcUiKpT+1PE+9B33m
	NzdwdJllIKvblpGDjRtl3JVqzrn4fVlCnq1zVgRHaEVpNmYqb5/H1LUIiFGDljrS
	pScDmbHvTfc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71A798380;
	Fri, 22 Jun 2012 19:59:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E46CB837C; Fri, 22 Jun 2012
 19:59:05 -0400 (EDT)
In-Reply-To: <CAE1pOi2MN_c76UBeRzdRbU8s+0LzYVoVcJ13V0di=HQobj+aDg@mail.gmail.com> (Hilco
 Wijbenga's message of "Fri, 22 Jun 2012 13:18:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FE6DC00-BCC6-11E1-98BA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200489>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

>> Some ways you can prevent it from happening again:
>> (1) setting your canonical repo config to deny non-ff, and deny deletes:
>> [receive]
>>        denyDeletes = true
>>        denyNonFastforwards = true
>
> I would *really* like to do that but I need access to the server for
> that, right? Unfortunately, we use Unfuddle and that means no such
> access. So no server config changes and no Git hooks.

receive.denyNonFastforwards is a reasonable thing to ask for
projects with a shared repository workflow, so I suspect hosting
service providers may want to race adding support for it to win
customers.  Have you asked them?
