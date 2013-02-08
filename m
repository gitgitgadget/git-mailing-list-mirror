From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCHv6] Add contrib/credentials/netrc with GPG support
Date: Thu, 07 Feb 2013 20:53:17 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87mwvfbmgi.fsf@lifelogs.com>
References: <87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vvca6u47f.fsf@alter.siamese.dyndns.org>
	<87k3qmr8yc.fsf@lifelogs.com> <87fw1ar3og.fsf_-_@lifelogs.com>
	<87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vvca6u47f.fsf@alter.siamese.dyndns.org>
	<87k3qmr8yc.fsf@lifelogs.com>
	<7vhalqsfkf.fsf@alter.siamese.dyndns.org>
	<8738xaqy40.fsf_-_@lifelogs.com>
	<7vip66qu0u.fsf@alter.siamese.dyndns.org>
	<7vtxpqnwiv.fsf@alter.siamese.dyndns.org>
	<876226p97h.fsf_-_@lifelogs.com>
	<7vtxpn4r7a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 02:53:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3dA2-0003KG-1Q
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 02:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757921Ab3BHBxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 20:53:21 -0500
Received: from z.lifelogs.com ([173.255.230.239]:42252 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756909Ab3BHBxT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 20:53:19 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id D8E68DE0E3;
	Fri,  8 Feb 2013 01:53:18 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vtxpn4r7a.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 07 Feb 2013 15:52:41 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215742>

On Thu, 07 Feb 2013 15:52:41 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

>> +	@echo "=> Look for any entry in the default file set"
>> +	echo "" | ./git-credential-netrc -d -v get
>> +	@echo "=> Look for github.com in the default file set"
>> +	echo "host=google.com" | ./git-credential-netrc -d -v get
>> +	@echo "=> Look for a nonexistent machine in the default file set"
>> +	echo "host=korovamilkbar" | ./git-credential-netrc -d -v get

JCH> Whose netrc is this reading?

JCH> Don't we want all of them to have "-f A" and ship "A" (rename it to
JCH> something more reasonable), so that anybody can notice when he tries
JCH> to improve it and breaks it?

I agree this Makefile is not a good test to ship out.  It was my quickie
test rig that I should have reworked before adding to the patch.  Sorry.

I see contrib/subtree/t and contrib/mw-to-git/t that I could copy.  The
test will have a few files to parse, and will be able to compare the
expected to the actual output.  Does that sound like a good plan?

Ted
