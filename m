From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git commit path vs rebase path
Date: Wed, 09 May 2012 14:54:24 -0700
Message-ID: <7v62c5qaun.fsf@alter.siamese.dyndns.org>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>
 <7vaa1j7vg1.fsf@alter.siamese.dyndns.org> <4FA8BBB0.1080406@viscovery.net>
 <CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>
 <4FA8C5DB.5060002@viscovery.net>
 <CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com>
 <7vhavqwqpz.fsf@alter.siamese.dyndns.org>
 <7v1umuwpo9.fsf@alter.siamese.dyndns.org>
 <CAAXzdLVj0szCgpdOSdhnLdkBKAM+e6vrQpvrsz4HeUo+Nh1K6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Steven Penny <svnpenn@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 23:54:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSEq9-0005M0-IH
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 23:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758326Ab2EIVy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 17:54:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52492 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758184Ab2EIVy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 17:54:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F37F7852;
	Wed,  9 May 2012 17:54:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZoDGbrYJof12DQCfa4xGgZfKsiA=; b=mcron+
	S1tJ3lUQnymZbN767AFnyaiKNkK+rZY1mwXKDnIPSecD8FPlmR8cbJqDUmj6vWg7
	kjTMYEBKDYGQqXfMCT/l5xshpGMqYp6dnyQMps/y8Zug3yN+wSK4f+SpT97QFHMW
	NF0SnDgf0nYT/GSvT9MeNmSJJyDrPC4eG+i40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mAE7zRcFehPBwTx8FruyYAw+c9OHsDWh
	IIDpkAbh5V1FWyFTKbCjOZe5ICWNiMNyhwGM+4ZU8wUk9Scn4rf/0tg2S/JIP59X
	9hQtnMN+EZIDL1/IqlPaDr0OWHWSTey80esjhGNAFBCzyOuZZKssHCR3BOqNv7Tp
	G0hC8uGgFNw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95BA07851;
	Wed,  9 May 2012 17:54:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29EB77850; Wed,  9 May 2012
 17:54:26 -0400 (EDT)
In-Reply-To: <CAAXzdLVj0szCgpdOSdhnLdkBKAM+e6vrQpvrsz4HeUo+Nh1K6A@mail.gmail.com> (Steven
 Penny's message of "Tue, 8 May 2012 17:47:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B705CB8-9A21-11E1-8080-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197521>

Steven Penny <svnpenn@gmail.com> writes:

> so the best compromise would be "C:/test/hello.sh" which can be created with
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 7b3ae75..ba198d2 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -260,6 +260,11 @@ case $(uname -s) in
>  		return 1
>  	}
>  	;;
> +*CYGWIN*)
> +    pwd () {
> +        builtin cygpath -m
> +    }
> +    ;;

What does "uname -s" say on cygwin exactly?  Our existing system detection
code I found was in the Makefile and it looks out "uname -o" output and
compares it with "Cygwin".

I am not suggesting to change this part of the code to use "uname -o" at
all; I just want to double check that the above *CYGWIN* matches it.
