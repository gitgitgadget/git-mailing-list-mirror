From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit --amen
Date: Thu, 04 Oct 2012 09:52:17 -0700
Message-ID: <7va9w218ou.fsf@alter.siamese.dyndns.org>
References: <0d559e3191a392841124d96870a67735@rom1v.com>
 <CABURp0rbNZSOC_Jtxfjp+j3SQR=+r0pU6vOXvc0Jnth0UU9mDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Romain_Vimont_=28=C2=AEom=29?= <rom@rom1v.com>,
	git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:48:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtdr-00033L-CO
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359Ab2JDQwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 12:52:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60688 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab2JDQwU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 12:52:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00A8F8C92;
	Thu,  4 Oct 2012 12:52:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+VJXqnuKGEM/ocLDgbiWH+sCHiA=; b=CtxqKd
	WlBCXYLqd8UjDUVXUDZh1Df1HQDRDgwflP9U6dkfseN8ZbmE6i1H5l/hUhbMaTDc
	muEA8L/VfFysbTl/ZYvtCmUiOUdvnBJf2GNbYCNmGMPZKWvV63pwDJCDkh2hY8F0
	IbAhwVv3GrHbPAl0cJDGS9fK+EAvesbES9zkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P1JH9SD3lpMVlpf5N0fYg+CKN4UtryTp
	0ral+dbdTfq1RGm69bru7sLT8XjdpPgp6pO+Pqi9C6RCJXawFDTyNt8e5W4h0S6S
	3mvSPpUc0iGsBdcR8lEJvdG6I/TNqJzwbyEuOcK0sf1mrPvpC95By80RIswrGtCL
	BJv9ygLDBuw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E22C38C91;
	Thu,  4 Oct 2012 12:52:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C6238C90; Thu,  4 Oct 2012
 12:52:19 -0400 (EDT)
In-Reply-To: <CABURp0rbNZSOC_Jtxfjp+j3SQR=+r0pU6vOXvc0Jnth0UU9mDA@mail.gmail.com> (Phil
 Hord's message of "Thu, 4 Oct 2012 10:25:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC29E052-0E43-11E2-8786-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207025>

Phil Hord <phil.hord@gmail.com> writes:

>> Is it normal that "git commit --amen" actually works ?
>> (it does like --amend)
>>
>> version 1.7.10.4
>
> Yes.  From Documentation/technical/api-parse-options.txt:
>
>     * Long options may be 'abbreviated', as long as the abbreviation
>       is unambiguous.
>
> Apparently since 2008-06-22.

Notice "technical/api-" part; that is a _wrong_ documentation page
to quote to end users.

Instead quote from "git help cli".

       From the git 1.5.4 series and further, many git commands (not
       all of them at the time of the writing though) come with an
       enhanced option parser.

> So 'git commit --am' also works.  But it should probably be avoided
> because of its similarity to 'git commit -am'.

Yes, in general, you should avoid relying on shortened form
working.  Git 2.4 may add an option "--amen" that has totally
different meaning.
