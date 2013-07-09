From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Tue, 9 Jul 2013 19:42:49 +0200
Message-ID: <87ehb7d3za.fsf@hexa.v.cablecom.net>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	<7v38rnwuvb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 19:42:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwbwH-0002Iz-2P
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 19:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab3GIRmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 13:42:52 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:35382 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722Ab3GIRmw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 13:42:52 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 9 Jul
 2013 19:42:48 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 9 Jul
 2013 19:42:49 +0200
In-Reply-To: <7v38rnwuvb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 09 Jul 2013 09:39:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229973>

Junio C Hamano <gitster@pobox.com> writes:

>  (2) In the ranges "-L <anything>,/B/ -L /C/,<anything>", the
>      beginning of the second range is found by choosing C that comes
>      _after_ the end of the previous range (/B/ may choose either
>      the second or the 4th line, and the only C that comes after
>      either of them is the 5th line and that is where the second
>      range should begin, not at the beginning of the file).  The
>      same for "-L 1,3 -L /C/" (only C that comes after 3 is eligible
>      to be the beginning of the second range).

So passing several -L arguments does not blame the union of what each
argument would blame individually?  Doesn't that make it rather harder
to explain?

In any case, if you define it like that for blame, log -L should be
changed to match.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
