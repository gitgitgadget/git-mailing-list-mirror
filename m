From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minimum libCurl version for git
Date: Tue, 24 Mar 2009 00:35:44 -0700
Message-ID: <7vvdpz2x0v.fsf@gitster.siamese.dyndns.org>
References: <e2b179460903201059j20e37c1cr7ccfa4b42e45c9d9@mail.gmail.com>
 <7vy6uzg98v.fsf@gitster.siamese.dyndns.org>
 <e2b179460903230424v1c98d73ci1f41918807fb2d5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>, Daniel Stenberg <daniel@haxx.se>,
	Nick Hengeveld <nickh@reactrix.com>,
	Mike Hommey <mh@glandium.org>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 08:37:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1CR-00088a-2Y
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 08:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbZCXHf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 03:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbZCXHf4
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 03:35:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbZCXHfz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 03:35:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D7D40A4A0B;
	Tue, 24 Mar 2009 03:35:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1DDEFA4A0A; Tue,
 24 Mar 2009 03:35:45 -0400 (EDT)
In-Reply-To: <e2b179460903230424v1c98d73ci1f41918807fb2d5c@mail.gmail.com>
 (Mike Ralphson's message of "Mon, 23 Mar 2009 11:24:57 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 675CBC1E-1846-11DE-991B-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114407>

Mike Ralphson <mike.ralphson@gmail.com> writes:

> 2009/3/20 Junio C Hamano <gitster@pobox.com>:
>> We can have these two macro definitions on our side
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0#if curl older than 7.10.8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0#define CURLINFO_RESPONSE_CODE CURLINFO_H=
TTP_CODE
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0#endif
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0#if curl older than 7.9.7
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0#define CURLOPT_READDATA CURLOPT_INFILE
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0#endif
>>
>> for backward compatibility, while writing our code to the recent API=
 by
>> using CURLINFO_RESPONSE_CODE and CURLOPT_READDATA, and people with o=
lder
>> curl would not have to suffer a bit.
>
> See? That's why they pay you the big maintainer-bucks... 8-)

The big maintainer-buck is called zero cents.  I am only paid with the
freedom to spend 20% of my day-job time on git [*1*].

In any case, "Write to the latest API, support older platforms with
backward compatibility wrapper as necessary" is a good practice employe=
d
by many successful projects, including the kernel, and I think it would
apply here nicely.

>> Mike, I'd say we declare 7.9.3 as the floor and go from there.  That=
's
>> your #3, I think.
>
> Short patch series to follow, though maybe not today.

Thanks.

[Footnote]

*1* ... which is still generous of my employer and NEC, given the curre=
nt
economic climate, but I wouldn't exactly call that "big bucks" ;-).
