From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] contrib/subtree: Use %B for Split Subject/Body
Date: Tue, 08 Jan 2013 16:41:11 -0800
Message-ID: <7vzk0j9oig.fsf@alter.siamese.dyndns.org>
References: <1357646997-28675-1-git-send-email-greened@obbligato.org>
 <1357646997-28675-3-git-send-email-greened@obbligato.org>
 <CAPYzjrQ1ngfOwBuzq+Da1Ynd18Vwt8=LCyu2yhE6dX8vivwReg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "David A. Greene" <greened@obbligato.org>, git@vger.kernel.org
To: =?utf-8?Q?=E9=83=91=E6=96=87=E8=BE=89=28Techlive_Zheng=29?= 
	<techlivezheng@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 01:41:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsjjb-0000f7-SX
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 01:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203Ab3AIAlP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2013 19:41:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47503 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551Ab3AIAlP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jan 2013 19:41:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 473FAA171;
	Tue,  8 Jan 2013 19:41:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dX6VYsEiXJ40
	qK+xxfKhi5e2DFw=; b=v0Ob5iLXy/M1gDEFHCV4+DjC1/8WBbwPjQupmcvCvWQK
	Ank0dXyJIPIskRqSxTPV2+drr0NXPqMoHifnKyt7mDj+NT49hHsaiPwDdpIbnf46
	+YL3S2BMoyFhzTzkDOcWYhbb96e2gVKQJ08uqVEyeTZsU6i3EaLCgN3bF3phRZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=V6ZC79
	lCTrs2s8Jr68XIbfVFKpKO1d9mHM5x8TCR6oiGJE71iyZkAw03OAiJNIvhirIdLp
	Y4ncy/eXgyYykhWEMa59Xa4qcGdvwuGGEuWr60pL9gKmLHMLcixfVDl7OUTOooAy
	pmt6ilAFOcVf6eKKOxLgZprYxYUaZtBUyFwIU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 371E8A170;
	Tue,  8 Jan 2013 19:41:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6397A164; Tue,  8 Jan 2013
 19:41:13 -0500 (EST)
In-Reply-To: <CAPYzjrQ1ngfOwBuzq+Da1Ynd18Vwt8=LCyu2yhE6dX8vivwReg@mail.gmail.com>
 (=?utf-8?B?IumDkeaWh+i+iShUZWNobGl2ZQ==?= Zheng)"'s message of "Wed, 9 Jan
 2013 07:21:27 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 452BF20A-59F5-11E2-80EA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213018>

"=E9=83=91=E6=96=87=E8=BE=89(Techlive Zheng)"  <techlivezheng@gmail.com=
> writes:

>> +test_expect_success 'check hash of split' '
>> +        spl1=3D$(git subtree split --prefix subdir) &&
>> +        undo &&
>> +        git subtree split --prefix subdir --branch splitbr1test &&
>> +        check_equal ''"$(git rev-parse splitbr1test)"'' "$spl1"
>> +        git checkout splitbr1test &&
>> +        new_hash=3D$(git rev-parse HEAD~2) &&
>> +        git checkout mainline &&
>> +        check_equal ''"$new_hash"'' "$subdir_hash"
>> +'
>> +
> This test is not test the correct thing, I am currently working on it=
=2E

Will keep the topic branch out of 'next' for now.

David, how would you like to handle a reroll of this piece?
