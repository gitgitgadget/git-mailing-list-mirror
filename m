From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking submodules out of main directory.
Date: Wed, 03 Aug 2011 12:41:24 -0700
Message-ID: <7vaabqb7vf.fsf@alter.siamese.dyndns.org>
References: <4E0A08AE.8090407@web.de>
 <1311792580.2413.82.camel@Naugrim.eriador.com>
 <1311843465.3734.40.camel@Naugrim.eriador.com> <4E3192D4.5000504@web.de>
 <1311932377.3734.182.camel@Naugrim.eriador.com> <4E34122B.5020509@web.de>
 <1312062927.3261.334.camel@Naugrim.eriador.com> <4E370107.3050002@web.de>
 <1312287584.3261.798.camel@Naugrim.eriador.com> <4E384510.1070803@web.de>
 <20110803062536.GB33203@book.hvoigt.net>
 <1312374382.3261.913.camel@Naugrim.eriador.com>
 <7v8vractdw.fsf@alter.siamese.dyndns.org> <4E399C62.30604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: henri GEIST <henri.geist@flying-robots.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Aug 03 21:41:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QohJv-0002HB-RW
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 21:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546Ab1HCTlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 15:41:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65382 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755514Ab1HCTl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 15:41:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 610304D5E;
	Wed,  3 Aug 2011 15:41:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d43IsEGySIuhK2WI1Gpp8F+Er20=; b=LvJcOp
	PmKTwlmYrwGq+yIw+6nuDB49IDTjan3UsuurrjglFf0O4EOx/KpK8n28ExTTLny6
	klAbiOftSC6modQXPSM51muxDGceaCERKoidp5w9gNkYbhZRTJGlHMyKTMH1qYKU
	w2RcPRfgHlG3vimRlysq48F71uUf6jbZMtH5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wW7oCEd9IPLRtX4FswOdNMFth/BUXiHf
	+wA20+5YWE/7/12/3PdPamN43Y0AEgCIv3mAfzBkEvduS71wS9f4PJXMhrYM6bQQ
	zth+fc21EudWEWo8LhYk86MGbnRxQJ2pvSt/WJFkND0dwb1gV1yZsmXZmZfZIANJ
	YKV3P3Kar80=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5849C4D5D;
	Wed,  3 Aug 2011 15:41:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7B214D5C; Wed,  3 Aug 2011
 15:41:25 -0400 (EDT)
In-Reply-To: <4E399C62.30604@web.de> (Jens Lehmann's message of "Wed, 03 Aug
 2011 21:07:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93095E48-BE08-11E0-8B44-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178614>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> 1) To use me, you need another submodule "foo"
>
>    This is very helpful when you want to add the Gimp submodule and it
>    can tell you you'll need the libpng submodule too in your superproject
>    (but I'd vote to use the submodule name here, not the path as that
>    should be the superproject's decision).

That is something you can add to .gitmodules in the superproject, no?
E.g.

	[submodule "Gimp"]
        	url = http://some/where/
		path = gimp/
        	depends = version 1.2.3 of "Glib"

	[submodule "Glib"]
        	url = http://some/where/else/
		path = libs/glib

> In addition to that, it can (but mustn't) specify any of the following:

I am guessing you meant "does not have to", instead of mustn't, here...

> a) Of this submodule "foo" I need at least that version because I won't
>    compile/work with older versions of that. (this can be tightened to
>    "exactly that version" to give henri the behavior he wants, but that
>    should be policy, not mandatory)

The "loose collection of projects" approach like that has its uses, and it
is called "repo". Why re-invent it? The behaviour Henri wants to specify
the exact version is how git submodules work already, so I do not see
there is anything to be done here.

> b) And if you don't know where to get it, use this url

Again that is the job of .gitmodules in the superproject.

> That is all stuff the submodule knows better than the superproject.

Not necessarily. The version A0 of submodule A may depend on submodule B
and may also know it must have at least version B0 of that submodule, but
the superproject would know other constraints, e.g. the superproject
itself also calls into submodule B and wants a newer version B1 of it.
