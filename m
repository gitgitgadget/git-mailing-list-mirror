From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make sure objects/pack exists before creating a new 
 pack
Date: Thu, 26 Feb 2009 09:07:33 -0800
Message-ID: <7vmyc9t9d6.fsf@gitster.siamese.dyndns.org>
References: <49A428B7.4000003@spiralti.com>
 <7v7i3fivx2.fsf@gitster.siamese.dyndns.org>
 <7vocwrc7oe.fsf_-_@gitster.siamese.dyndns.org> <49A65EBF.10307@viscovery.net>
 <e2b179460902260319je8ce6c6qc028d260b9d35b7c@mail.gmail.com>
 <49A6B5E8.8040306@viscovery.net>
 <e2b179460902260754t38618c3fsf22a699ec35070cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Todd Zullinger <tmz@pobox.com>,
	Rafael Darder Calvo <rdarder@spiralti.com>, mike@abacus.co.uk
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 18:09:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcjjV-00013E-Qr
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 18:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745AbZBZRHq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2009 12:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754845AbZBZRHq
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 12:07:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbZBZRHp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 12:07:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A46859DB84;
	Thu, 26 Feb 2009 12:07:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8CE9C9DB7D; Thu,
 26 Feb 2009 12:07:35 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FB7229C6-0427-11DE-80A5-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111581>

Mike Ralphson <mike.ralphson@gmail.com> writes:

> 2009/2/26 Johannes Sixt <j.sixt@viscovery.net>:
>> Mike Ralphson schrieb:
>>> Even with j6t's patch, I'm seeing failures in t5300--pack-object.sh=
 on AIX 5.3
>>>
>>> * FAIL 15: survive missing objects/pack directory
>>> fatal: Unable to create temporary file (): No such file or director=
y
>>
>> I can confirm this. Your patch is good. I wrapped it up:
>>
>> -- snip --
>> From: Mike Ralphson <mike.ralphson@gmail.com>
>> Subject: [PATCH] Fix odb_mkstemp() on AIX
>>
>> The AIX mkstemp() modifies its template parameter to an empty string=
 if
>> the call fails. =C2=A0The existing code had already recomputed the t=
emplate,
>> but too late to be good.
>>
>> See also 6ff6af62, which fixed this problem in a different spot.
>
> Ah, I should have remembered that one.
>
> If my $DAYJOB email address could be used in the From, as per this s-=
o-b:
>
> Signed-off-by: Mike Ralphson <mike@abacus.co.uk>

Thanks.
