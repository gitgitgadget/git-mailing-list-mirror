From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Lightweight tag ?
Date: Mon, 12 Jan 2009 11:52:53 -0800
Message-ID: <7vzlhwgv3e.fsf@gitster.siamese.dyndns.org>
References: <38b2ab8a0901111044x5db21d74i25ff7a26bb702a5d@mail.gmail.com>
 <7v63klsgf5.fsf@gitster.siamese.dyndns.org> <m2bpucnas2.fsf@gmail.com>
 <496B3DA8.1040308@drmicha.warpmail.net>
 <38b2ab8a0901120556x279f320oe693304dd2452050@mail.gmail.com>
 <496B59A3.2080507@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jan 12 20:54:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMSrg-00068g-S2
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 20:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853AbZALTxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 14:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754782AbZALTxD
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 14:53:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbZALTxC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 14:53:02 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3391A1C54A;
	Mon, 12 Jan 2009 14:53:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 831691BF90; Mon,
 12 Jan 2009 14:52:55 -0500 (EST)
In-Reply-To: <496B59A3.2080507@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 12 Jan 2009 15:54:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9D94B386-E0E2-11DD-8040-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> That's not what Junio said:
>> 
>>    Don't use explicit --tags blindly.  It says "no matter what kind of tag,
>>    transfer everything under refs/tags".  Otherwise you won't see a
>>    difference.
>> 
>> So I interpret this like don't use --tags otherwise lightweight and annoted tags
>> are the same.
>
> I don't see a difference between lightweight tags and tag objects
> regarding the question of automatic tag following, see my parenthetical
> request for correction (below) in case I'm wrong.

It was me who was confused on two points.

 (1) push does not do autofollow and you always have to be explicit
     (including saying "--tags" which is to push all refs/tags/*); I
     somehow thought the question was about fetch;

 (2) if you explicitly ask to fetch tags, there won't be any difference
     (which was my "don't say --tags explicitly because you won't see a
     difference if you did so").

     On the other hand, the autofollowing during the fetch originally
     followed only annotated tags (it was partly by design, so that people
     can use lightweight tags for local stuff without worrying about
     contaminating others' tag namespace with many of them) and I somehow
     thought this was still the case.

     But it is not the case anymore since 6c96c0f (git-fetch: follow
     lightweight tags as well, 2006-11-18).

So, sorry for the noise.
