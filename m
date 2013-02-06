From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Wed, 06 Feb 2013 09:53:56 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <876225o5mj.fsf@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v6226pdb7.fsf@alter.siamese.dyndns.org>
	<vpqa9rhaml6.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michal Nazarewicz <mpn@google.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 06 15:54:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U36OD-000655-SJ
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 15:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132Ab3BFOx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 09:53:59 -0500
Received: from z.lifelogs.com ([173.255.230.239]:45399 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294Ab3BFOx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 09:53:59 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 69192DE0E3;
	Wed,  6 Feb 2013 14:53:57 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <vpqa9rhaml6.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 06 Feb 2013 09:11:17 +0100")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215579>

On Wed, 06 Feb 2013 09:11:17 +0100 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote: 

MM> Junio C Hamano <gitster@pobox.com> writes:
>> I see a lot of rerolls on the credential helper front, but is there
>> anybody working on hooking send-email to the credential framework?

MM> Not answering the question, but git-remote-mediawiki supports the
MM> credential framework. It is written in perl, and the credential support
MM> is rather cleanly written and doesn't have dependencies on the wiki
MM> part, so the way to go for send-email is probably to libify the
MM> credential support in git-remote-mediawiki, and to use it in send-email.

I looked and that's indeed very useful.  If it's put in a library, I'd
use credential_read() and credential_write() in my netrc credential
helper.  But I would formalize it a little more about the token names
and output, and I wouldn't necessarily die() on error.  Maybe this can
be merged with the netrc credential helper's
read_credential_data_from_stdin() and print_credential_data()?

Let me know if you'd like me to libify this...  I'm happy to leave it to
Matthieu or Michal, or anyone else interested.

Ted
