From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cherry-pick and git-commit --amend in version 1.7.6.4
Date: Wed, 05 Oct 2011 10:40:37 -0700
Message-ID: <7v8voz8hgq.fsf@alter.siamese.dyndns.org>
References: <4E8C6F2F.1070306@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nicolas.dichtel@6wind.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 19:40:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBVSW-0001lr-Bt
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 19:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935085Ab1JERkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 13:40:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56810 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935024Ab1JERkj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 13:40:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2417513C;
	Wed,  5 Oct 2011 13:40:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZnkG4GJiAHVZOUN1lm18mypT7dQ=; b=e7mKqd
	WlngAeKLLxK975jQ9VwfBTD+3sCxgdI0Nit5x8ABQ209ZOVMxk88iyyAUWkPUvvm
	DSiilLuNwmrCgkg5ifDBy1z7AztLOu38vj20R0ymiQjQv0cQH+sm5mK47VLCbtD5
	VGLsL+OQXdBCfp0LJp7z5cxYhDWZ5N8o9tZKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=utykgYqdkunScdcmdwl7EUJoe7PeY+tF
	5hc9xdYx7RJM1V48oHXZZ1K7JG692Xd1Wq3EYtf3KSgcLEAHF5eixvIjqcn8qgKb
	YGku9L0bF2oTDcEY0cnIjn0cdWPimurOomZy5oSptKEmvNbEm+mH6i7oDViwU6Hl
	g7pN8iMmqtI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA87D513B;
	Wed,  5 Oct 2011 13:40:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E4EC5137; Wed,  5 Oct 2011
 13:40:38 -0400 (EDT)
In-Reply-To: <4E8C6F2F.1070306@6wind.com> (Nicolas Dichtel's message of "Wed,
 05 Oct 2011 16:52:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 235F2AA8-EF79-11E0-8FF4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182866>

Pinging Jay who may have know a thing or two from the history leading to
37f7a85 (Teach commit about CHERRY_PICK_HEAD, 2011-02-19).

Nicolas Dichtel <nicolas.dichtel@6wind.com> writes:

> Hi,
>
> still with version 1.7.6.4, when I do a cherry-pick, that succeeded, I
> cannot do a commit --amend after:
>
> # git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
> [dev 1a04a23] drivers/net/usb/asix.c: Fix unaligned accesses
>  1 files changed, 33 insertions(+), 1 deletions(-)
> # echo $?
> 0
> # git commit --amend
> fatal: You are in the middle of a cherry-pick -- cannot amend.
> #
>
> The same operations (with the same patch), with version 1.7.3.4 is ok.
>
>
> Regards,
> Nicolas
