From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Makefile: implement help target
Date: Wed, 29 Sep 2010 08:41:36 -0700
Message-ID: <7vhbh8r1zj.fsf@alter.siamese.dyndns.org>
References: <AANLkTikx2tL73gJQnqjG7yp3btcZJprKLf0z9QwcAUC1@mail.gmail.com>
 <4fd8b490b4badd13c0ea46408e44dc7b317dc0ed.1285706151.git.git@drmicha.warpmail.net> <20100929051640.GA26324@sigill.intra.peff.net> <4CA2E4C7.305@drmicha.warpmail.net> <20100929073400.GA28010@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 17:42:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ynF-0001Wo-P9
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 17:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056Ab0I2Pl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 11:41:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38261 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab0I2Pl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 11:41:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C825DA05E;
	Wed, 29 Sep 2010 11:41:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l2c0tc+TPXcsDeMo4Ed79UiAag0=; b=pIhVMf
	nCLaJQDZrj6e72ltKqfgfwWnq4cnfFKb/ibPyVX3dIAtuGSHP1LqIOoqhv87ZUiw
	umajZLNDTrm8V5m9zOqiGS99x6zA3PbNHtAz6+9byGknYMg523IcYbJjY0a7NyxS
	oUeR3whxiPuFNUc/yDvPpvZD3FVhaFGELVmOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b4yn2BhPhzLEnSarhfUFZHwE/AayHUdS
	4sk6MEzHXRliUXDtX6AGmLoqX5lpPnUXviPWko2UNva4OHaLUDmLEUBOepozJ/tQ
	Yo9bXqxgj8nlTyJI6BAZugnw9MwSsZdFU8O4EY/BJ6+SregR33rEEMBwoQmaIhqh
	4E31mX6ONXg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B4D4FDA05A;
	Wed, 29 Sep 2010 11:41:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49B79DA052; Wed, 29 Sep
 2010 11:41:38 -0400 (EDT)
In-Reply-To: <20100929073400.GA28010@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 29 Sep 2010 03\:34\:01 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 11DB18B8-CBE0-11DF-9AAA-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157580>

Jeff King <peff@peff.net> writes:

> What I was trying to say was more that alphabetical is not necessarily
> the most useful order to present things in the help screen. Probably
> there is some hand-selected order that presents the entries in the least
> confusing way. And one way of representing that is to have the topics in
> that order in the Makefile, which in theory probably makes reading the
> Makefile itself simpler.

I agree with this, even though I do not feel _too_ strongly about it.

By the way, while we are at adding "make help" support...

With help annotations in the Makefile like this:

        # Help: install everything
        # - the user visible commands go to $(bindir)
        # - helper programs go to $(gitexec_instdir)
        # - templates go to $(template_instdir)
        install: all
                $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'

I imagine it would be really cool if "make help" said something like this:

    $ make help
    ...
    install:
      install everything
      - the user visible commands go to $(bindir) = /home/junio/bin
      - helper commands go to $(gitexec_instdir) = /home/junio/libexec/git-core
      - templates go to $(template_instdir) = /home/junio/share/git-core/templates

to help the builder figuring out what make variable(s) to tweak.  To be useful,
I think you would need to show the expansion, though.  E.g.

    - the user visible commands go to $(bindir) = /home/junio/bin
        bindir = $(prefix)/$(bindir_relative)
        prefix = $HOME
        HOME = /home/junio
        bindir_relative = bin

But again, I do not feel strongly about it either.
