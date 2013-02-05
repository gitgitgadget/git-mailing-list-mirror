From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Tue, 05 Feb 2013 15:03:01 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87bobyr0ju.fsf@lifelogs.com>
References: <87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vvca6u47f.fsf@alter.siamese.dyndns.org>
	<87k3qmr8yc.fsf@lifelogs.com>
	<7vip66sftf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:03:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2ojv-000269-7L
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 21:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984Ab3BEUDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 15:03:06 -0500
Received: from z.lifelogs.com ([173.255.230.239]:54104 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111Ab3BEUDE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 15:03:04 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 7F346DE0E3;
	Tue,  5 Feb 2013 20:03:02 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vip66sftf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 05 Feb 2013 11:47:56 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215530>

On Tue, 05 Feb 2013 11:47:56 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> Ted Zlatanov <tzz@lifelogs.com> writes:
JCH> Oh, another thing. 'default' is like 'machine' followed by any
JCH> machine name, so the above while loop that reads two tokens
JCH> pair-wise needs to be aware that 'default' is not followed by a
JCH> value.  I think the loop will fail to parse this:
>> 
JCH> default       login anonymous    password me@home
JCH> machine k.org login me           password mysecret
>> 
>> I'd prefer to ignore "default" because it should not be used for the Git
>> credential helpers (its only use case is for anonymous services AFAIK).
>> So I'll add a case to ignore it in PATCHv4, if that's OK.

JCH> You still need to parse a file that has a "default" entry correctly;
JCH> otherwise the users won't be able to share existing .netrc files
JCH> with other applications e.g. ftp, which is the whole point of this
JCH> series.  Not using values from the "default" entry is probably fine,
JCH> though.

OK; done in PATCHv4.

Ted
