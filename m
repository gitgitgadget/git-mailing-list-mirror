From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: textconv not invoked when viewing merge commit
Date: Fri, 15 Apr 2011 08:54:49 +0200
Message-ID: <vpq62qg3sxy.fsf@bauges.imag.fr>
References: <201104111912.47547.kumbayo84@arcor.de>
	<4DA415AB.9020008@drmicha.warpmail.net>
	<20110414190901.GA1184@sigill.intra.peff.net>
	<7vipughbxh.fsf@alter.siamese.dyndns.org>
	<7vd3kohb5n.fsf@alter.siamese.dyndns.org>
	<7v8vvcha2s.fsf@alter.siamese.dyndns.org>
	<20110414202356.GB6525@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 08:58:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAczF-0001Zv-Vn
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 08:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692Ab1DOG6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 02:58:32 -0400
Received: from imag.imag.fr ([129.88.30.1]:45380 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178Ab1DOG6b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 02:58:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p3F6sog3019872
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 15 Apr 2011 08:54:50 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QAcvZ-0002RZ-V2; Fri, 15 Apr 2011 08:54:49 +0200
In-Reply-To: <20110414202356.GB6525@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Apr 2011 16:23:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 15 Apr 2011 08:54:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171590>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 14, 2011 at 01:06:19PM -0700, Junio C Hamano wrote:
>
>> Instead, I think we should just use "Binary blob $SHA-1\n" as if that is
>> the textconv of a binary file without textconv filter.  That would
>> certainly make the code much simpler, and more importantly, the output
>> would become more pleasant. We would show something like:
>> 
>>     - Binary blob bc3c57058faba66f6a7a947e1e9642f47053b5bb
>>      -Binary blob 536e55524db72bd2acf175208aef4f3dfc148d42
>>     ++Binary blob 67cfeb2016b24df1cb406c18145efd399f6a1792
>> 
>> if we did so.
>
> Yeah, I think that is pretty readable. But it gives me a funny feeling
> to encode magic strings inside actual diff output. That is, the output
> is indistinguishable from a file which contained the "Binary blob..."
> strings.
>
> I can't think of a case where it matters, though, so maybe it is just
> paranoia.

A line-counting, statistics tool would think that 1 line has been
removed from both branches, and one new added by the merge.

Well, I know no tool parsing combined diff actually, so it's indeed a
hypothetical case.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
