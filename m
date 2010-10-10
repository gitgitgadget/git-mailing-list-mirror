From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git 1.7.3.1 cannot be built on FreeBSD 4 with gcc 2.95
Date: Sun, 10 Oct 2010 04:06:27 -0700
Message-ID: <7vfwwetih8.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=z1vqpimP_5kS_AxcVypM5Dx75p--XG8E3uSx=@mail.gmail.com>
 <AANLkTi=3BG0PScgp5X+y2-U1FqC6aoOrw_pyLU7cEzME@mail.gmail.com>
 <AANLkTindQ8Nty=eUGNgREish0K-=dGgg9qXjWbefKb3M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Akira Kitada <akitada@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 13:06:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4tjp-00076q-3I
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 13:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328Ab0JJLGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 07:06:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222Ab0JJLGh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 07:06:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5F4CDD1C0;
	Sun, 10 Oct 2010 07:06:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aWPE3NzvlLPR0sLkbeQJDME6uDY=; b=k0fO73
	v/gJvFPVeWnfn23dhZvyPfuuw2bVZofOA6b6gNt2z05lGLUBDmdUIIq6Qvmov07S
	ZyE7XK55pIONaSL2pxWdXG1DS4WPp3gFK9ELtDHpUO29Rpou07D52Taobb2wuf1Z
	X3gX2sKaJxiH8ZJr1o/z8cOfR4y24135x/Whk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z1kANbZ7qSDvg9+atZOJT3dSKBnlIALp
	wrm9cuCwBDCef8iq2laNXvZXtsywBD7jFvFnXNe+tqhJJ5YxNW60T+h8Zo5g5TCq
	QVariK4/Xf4dwAjYjHQqOVowrDKd/DJkM2F1mtte4UVNHfSgciAOjOi03w4peiIV
	nO4Q4xGwUjs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 736B3DD1B3;
	Sun, 10 Oct 2010 07:06:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3C56DD1AC; Sun, 10 Oct
 2010 07:06:28 -0400 (EDT)
In-Reply-To: <AANLkTindQ8Nty=eUGNgREish0K-=dGgg9qXjWbefKb3M@mail.gmail.com>
 (Akira Kitada's message of "Sun\, 10 Oct 2010 14\:25\:13 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 708900BA-D45E-11DF-B5D0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158656>

Akira Kitada <akitada@gmail.com> writes:

> Thanks for reply.
>
> I use perl 5.8.9 and ExtUtils::MakeMaker is 6.48.
>
> $ /usr/local/bin/perl -v | grep v5
> This is perl, v5.8.9 built for i386-freebsd

Hmm, that is not much different from what I'm running pre-push test on in
one of my VMs.

$ type perl
perl is hashed (/usr/local/bin/perl)
$ /usr/local/bin/perl -v | grep v5
This is perl, v5.8.9 built for i386-freebsd-64int
$ perl -e 'use ExtUtils::MakeMaker; print "$ExtUtils::MakeMaker::VERSION\n";'
6.48

One difference is that I never use ./configure, as that is somewhat
foreign afterthought in our build infrastructure, though.
