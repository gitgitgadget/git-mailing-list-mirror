From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Mon, 02 Nov 2009 16:36:27 -0800
Message-ID: <7vtyxctpf8.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com>
 <7vzl74trmc.fsf@alter.siamese.dyndns.org>
 <20091102235707.GV10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 03 01:36:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N57O9-0005V7-Jl
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 01:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757395AbZKCAgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 19:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757379AbZKCAgd
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 19:36:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35280 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378AbZKCAgc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 19:36:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 63672906A6;
	Mon,  2 Nov 2009 19:36:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BrnuRam5PBo7ZaqvYeeVajGW9Jo=; b=BYKXM3
	SQfzMgMl/bRMX2R+cLlp+m3zqAeUvLVmWtsLpn8WVa8I/SXkB4Ex46qDJKzdmAFw
	0UW4bVu9+KRwQOT+VrcLHpvWa8rO2qx7o0iS8QzJNaLtUmxyYSZpYATVvo7GGWuv
	YB6RjdXGbSH3pomUa7xHtm2d2UaKDbgP0+zmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ArY9AZ1rDT/U+U9KYUBYZd3rhdLSlpjc
	mKm2Lyalv5b9zOXuEhhcZxmFRc3q8whxRl594opCFwp9fuFjPSJOlfAPeI0RVWR2
	MLmu4vOQpKtlciUNmCQyj6ChbfHkMNI6b409KxDCwrtrH2g7KrmoF/kJOKLMDO6Y
	oxukid9oxkA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 37646906A5;
	Mon,  2 Nov 2009 19:36:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7D05D906A4; Mon,  2 Nov 2009
 19:36:29 -0500 (EST)
In-Reply-To: <20091102235707.GV10505@spearce.org> (Shawn O. Pearce's message
 of "Mon\, 2 Nov 2009 15\:57\:07 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F027502A-C810-11DE-8A1F-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131938>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Shouldn't we say "the client MUST NOT make reference update request if
>> everything is up to date" which would imply that in practice there is no
>> reason to send an empty pack data?
>
> Create a new branch to point at an existing object.  Branch creation
> causes a pack to be expected, but if you are creating a new branch
> that points at an existing object there is nothing to pack.  E.g.:
>
>   git remote add -f A user@host:proj.git
>   git push A A/master:refs/heads/new-branch
>
> causes a 0 object pack file to be sent, assuming the remote project's
> master branch has not changed in between the two commands.

Ahh, you are right.  Thanks.
