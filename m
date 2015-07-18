From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] Fix detection of uname failure
Date: Sat, 18 Jul 2015 08:58:50 +0200
Organization: gmx
Message-ID: <e6959e1763d2f5cb2d14618a61edfab9@www.dscho.org>
References: <ef7d56584c3b5d6431f895df1d94eba8@www.dscho.org>
 <1437152981-28855-1-git-send-email-charles@hashpling.org>
 <7cf6757e8e81c2f9e102db24efbedb2a@www.dscho.org>
 <xmqq7fpy1n0z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 08:59:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGM5h-0000kE-4e
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 08:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbbGRG7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 02:59:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:58827 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbbGRG7A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 02:59:00 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LiY3U-1Yfuro0S0S-00ceoE; Sat, 18 Jul 2015 08:58:52
 +0200
In-Reply-To: <xmqq7fpy1n0z.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:MFrsKggmH4jTwhn1Fk0qbEAYw6AVqLxIUdcx868wk/41a29bDsZ
 ZVCsbZeyVvkarUsdcIt5nYr0aBAY+Le786jn8rmFbcDLUm/tGRTdsyO5pMLaPHNJ8AH841r
 TpMR72ZUoCWy0giyZwBNv67wCeeFeEBIaswH4V2S82pc83LfwJLZep2kAfqdMw3oaiJhGNP
 MjROo9cP9VVwO+PtkP+ig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7HDMmUafY1g=:2sTPRnyedEj34gbS8MlJlM
 Wm9LwrWDzF1myen6cf+maB2/oASVvKTCxnsBgLG0lMVyAYA1TjBKtx0E3bl9t94R1mvVb3tXU
 2ae4ATTLRcHpC9GFH+NnQ9EhzP0dQ12n3MyQdg8rAHWv0jt+I9nRlep7L12/nq58ML9bTUtCY
 RDoDa9iTRrWfpZr4BklT7Ve/dShrwUIPJ85wHNYJj4o868wIGd4EbRDvhhMNKlKeursPygPeU
 2RawpFO6K1YnJNO06m3LFGKXn+58WLZFfz2Q6+UIuhtp6mZkuSH6OBo+J7dv/puLO0DVGA/9D
 0REpsVNF6pKcP0E2oxmoqNgeSalSiULUGJ5eif/dh7O9+PLm8kmBOa0RtXOrxOp2zr0YS50wr
 /yXyhkZT0/YebxJTJU/Wi5awBZj5qTAxYPPsbHsma7EgW0BHiZY+EU2I4wmWbzLi6koWfcamQ
 TUV9YN+j6CTQ7tNuMf1c3gCyEqnFU+P3H4wRmn81GeR25vHrLbEhnp8P7ntq/Id2GVAcXlbTD
 +YypWoXMYkoYTq3huKGFinM9/8yIvDpotvTTcRBJXghFl0W7BYR14kJTwjzfnjZGqxow2sbZ8
 tsMCQFzJV+JxLm54bi0fd3RU+BQ6YUMJpQDipf8ihGVFC6VrbJm4apYiINcmlI1fTXEW0PGg7
 +6Va+Ri/wkY0XzjeFSP4wvI9BsZK6N3oEIKrc5EYhMIciIlDC9EUZdYx8xy3W3FulA7Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274155>

Hi Junio,

On 2015-07-17 23:39, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> On 2015-07-17 19:09, Charles Bailey wrote:
>>> From: Charles Bailey <cbailey32@bloomberg.net>
>>>
>>> According to POSIX specification uname must return -1 on failure and a
>>> non-negative value on success. Although many implementations do return 0
>>> on success it is valid to return any positive value for success.  In
>>> particular, Solaris returns 1.
>>>
>>> Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
>>
>> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> I'd s/Ack/Review/; as the original is not your code but you are well
> qualified (and have my trust) to judge the change to this codepath
> ;-)

Yeah, that's what I meant ;-)

Ciao,
Dscho
