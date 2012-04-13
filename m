From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Fri, 13 Apr 2012 13:33:22 +0200
Message-ID: <871unrzx19.fsf@thomas.inf.ethz.ch>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
	<20120413091236.GC2164@goldbirke>
	<CAMP44s0_WQNpkVi0yMfaDgzBaUWOhRiS-2qxLtCHFzx71yKrSw@mail.gmail.com>
	<20120413105238.GE2164@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Apr 13 13:33:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIekt-0000CE-Dw
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 13:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489Ab2DMLd0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 07:33:26 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:17696 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390Ab2DMLd0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Apr 2012 07:33:26 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Fri, 13 Apr
 2012 13:33:21 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 13 Apr
 2012 13:33:22 +0200
In-Reply-To: <20120413105238.GE2164@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
	"Fri, 13 Apr 2012 12:52:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195421>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Fri, Apr 13, 2012 at 01:34:46PM +0300, Felipe Contreras wrote:
>> >> + =C2=A0 =C2=A0 run_completion "git f" &&
>> >> + =C2=A0 =C2=A0 ! grep -q -v "^f" out
>> >
>> > grep is not a git command, so I'm not sure, but shouldn't these us=
e
>> > 'test_must_fail grep' instead of '! grep'?
>>=20
>> I'm not sure. Junio has already queued this, maybe you should send a
>> patch on top of that.
>
> It seems that both are used in the test suite, but '! grep' is more
> common, so perhaps it's good as it is.
>
> $ git grep '! grep' -- t |wc -l
> 136
> $ git grep 'test_must_fail grep' -- t |wc -l
> 17

test_must_fail catches a segfault or other signal exit as "bad", unlike
! which would accept this.

Since we trust the platform tools to work (on the grounds that you have
bigger problems if they don't), ! grep is fine.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
