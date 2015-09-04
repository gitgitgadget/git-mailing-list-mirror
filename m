From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] graph.c: visual difference on subsequent series
Date: Fri, 4 Sep 2015 16:07:46 +0200
Message-ID: <55E9A5B2.5080606@drmicha.warpmail.net>
References: <1415626412-573-1-git-send-email-anarcat@koumbit.org>
 <87twspe6ix.fsf@marcos.anarc.at>
 <xmqqegjticd7.fsf@gitster.dls.corp.google.com>
 <55E7FEF3.2020400@drmicha.warpmail.net>
 <xmqq613rl92s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Antoine_Beaupr=c3=a9?= <anarcat@koumbit.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 16:07:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXrej-0004Ld-N5
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 16:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbbIDOHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 10:07:49 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59150 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750766AbbIDOHs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2015 10:07:48 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 67F5A20476
	for <git@vger.kernel.org>; Fri,  4 Sep 2015 10:07:48 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 04 Sep 2015 10:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=mCKpdWbuf4F4jmEbrhFPyHp4QbY=; b=I3v8z8
	ZoK1M+qdMGIIjC1Kcu3V8/NMGF4/DU+5bMXC5mlEXnsMUJi1ayHF4YvvfF6DOPxU
	lMmlHqHoy2+SwtgOgpEb0YhTa97LKp1dFDyGWA+u8RTwIP6B9IRZPzmJodVnVl1f
	sHTYNro/XcVeA3LEa/khlcVrf+zelP6V79YUY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=mCKpdWbuf4F4jmE
	brhFPyHp4QbY=; b=UvoQCMg1aXY8O6Qw7KBExgm5Lzf7GNadeNUA4aCuBNVC+6O
	rJibzr5ATq4Lmmc04kn6qVvF1wJNzldHPqw9kjwUIwFkfNtDyGsa39P9uxUUKuOs
	jHvgP/BnQVIYmlP2N+2Uj4tuONUCNTNuhUk6hBN79QxTMKIEyjXuomVFFu5M=
X-Sasl-enc: n49ly4fYWnuUvS2iOfKfGQfjVwavh40MXTrhZ2kSYjx3 1441375668
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B6EED6801C7;
	Fri,  4 Sep 2015 10:07:47 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <xmqq613rl92s.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277311>

Junio C Hamano venit, vidit, dixit 03.09.2015 19:13:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>> Is the design of your independent implementation the same except
>>> that 'o' is used instead of 'x'?  Independent implementation does
>>> not make the same design magically better, if that is the case ;-)
>>
>> Interestingly, the patch to the tests lists * to o changes only, no < or
>>> to o.
> 
> Well, in that case, then the opposite but an equivalent problem
> exists in the design, no?  It promises to make roots stand out by
> painting them as 'o', but it sometimes fails to do so.  In other
> words, ...
> 
>> The reason is simply that the patch doesn't change anything for left nor
>> right commits. I would say that is the best compromise since it does not
>> change the overall layout, provides more information by default and does
>> not override information that is requested specifically.
> 
> ... it fails your last criteria.

How would it? "--left-right" information is requested specifically and
not overridden. Root information is not requested specifically [by the
user].

>> If we want to put more information into log --graph simultaneously we
>> should really go beyond ASCII and look at how tig does it, e.g. using
>> unicode characters.
> 
> That's another way to do so, but shifting columns to show where the
> history is not connected also does not change the overall layout,
> provides more information by default, etc., and a big plus is that
> it would be an approach to do so without having to go beyond ASCII.

That would consume more horizontal space and annoy at least some people.
Alternatively, we could use more vertical space and annoy at least some
(other?) people.

In fact, I tend to think that horizontal space is more "precious" than
vertical space due to the common orientation of scrolling...

If we don't mind an increase in vertical spacing there are more issues
that could be solved, for example the merge point description sticking
visually to the commits above rather than the merged branch in the
typical old..new scenario.

In fact, both issues would be solved be adding an extra line after a
root commit (be it "real" root or boundary-wise).

Michael
