From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Wed, 06 Feb 2013 12:40:35 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <874nhpibn0.fsf@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v6226pdb7.fsf@alter.siamese.dyndns.org>
	<vpqa9rhaml6.fsf@grenoble-inp.fr> <876225o5mj.fsf@lifelogs.com>
	<vpqmwvhxyuj.fsf@grenoble-inp.fr> <87sj59mo2y.fsf@lifelogs.com>
	<vpqobfxwg2q.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michal Nazarewicz <mpn@google.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 06 18:41:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U38zU-0006Cp-QA
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 18:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765Ab3BFRki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 12:40:38 -0500
Received: from z.lifelogs.com ([173.255.230.239]:44047 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003Ab3BFRkh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 12:40:37 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 91BFDDE0E3;
	Wed,  6 Feb 2013 17:40:36 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <vpqobfxwg2q.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 06 Feb 2013 17:41:01 +0100")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215601>

On Wed, 06 Feb 2013 17:41:01 +0100 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote: 

MM> Ted Zlatanov <tzz@lifelogs.com> writes:
>> - sort the output tokens (after 'url' is extracted) so the output is consistent and testable

MM> Why not, if you want to use the output of credential_write in tests. But
MM> credential_write is essentially used to talk to "git credential", so the
MM> important information is the content of the hash before credential_write
MM> and after credential_read. They are unordered, but consistent and
MM> testable.

I like testing output (especially when it's part of an API), so we
should make the externally observable output consistent and testable.

The change is tiny, just sort the keys instead of calling each(), so I
hope it makes it in the final version.

>> Yup.  But what you call "read" and "write" are, to the credential
>> helper, "write" and "read" but it's the same protocol :)  So maybe the
>> names should be changed to reflect that, e.g. "query" and "response."

MM> I don't think that would be a better naming. Maybe "serialize" and
MM> "parse" would be better, but "query" would sound like it establishes the
MM> connection and possibly reads the response to me.

I'm OK with anything unambiguous.

Thanks!
Ted
