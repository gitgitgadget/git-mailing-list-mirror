From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Wed, 06 Feb 2013 18:12:13 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <8738x9ghpu.fsf@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v6226pdb7.fsf@alter.siamese.dyndns.org>
	<vpqa9rhaml6.fsf@grenoble-inp.fr> <876225o5mj.fsf@lifelogs.com>
	<vpqmwvhxyuj.fsf@grenoble-inp.fr> <87sj59mo2y.fsf@lifelogs.com>
	<20130206215724.GA27507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Michal Nazarewicz <mpn@google.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 00:12:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3EAZ-0000hq-5C
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 00:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699Ab3BFXMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 18:12:22 -0500
Received: from z.lifelogs.com ([173.255.230.239]:58919 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775Ab3BFXMV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 18:12:21 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 5DF94DE0E3;
	Wed,  6 Feb 2013 23:12:20 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <20130206215724.GA27507@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 6 Feb 2013 16:57:24 -0500")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215661>

On Wed, 6 Feb 2013 16:57:24 -0500 Jeff King <peff@peff.net> wrote: 

JK> On Wed, Feb 06, 2013 at 10:58:13AM -0500, Ted Zlatanov wrote:
MM> I don't know about the netrc credential helper, but I guess that's
MM> another layer. The git-remote-mediawiki code is the code to call the
MM> credential C API, that in turn may (or may not) call a credential
MM> helper.
>> 
>> Yup.  But what you call "read" and "write" are, to the credential
>> helper, "write" and "read" but it's the same protocol :)  So maybe the
>> names should be changed to reflect that, e.g. "query" and "response."

JK> Is that true? As a user of the credential system, git-remote-mediawiki
JK> would want to "write" to git-credential, then "read" the response. As a
JK> helper, git-credential-netrc would want to "read" the query then
JK> "write" the response. The order is different, but the operations should
JK> be the same in both cases.

Logically they are different steps (query and response), even though the
data protocol is the same.  But it's really not a big deal, I know what
it means either way.

JK> The big difference is that mediawiki would want an additional function
JK> to open a pipe to "git credential" and operate on that, whereas the
JK> helper will be reading/writing stdio.

Yup.

Ted
