From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] run-command: simplify wait_or_whine
Date: Sat, 1 Jun 2013 16:19:22 +0200
Message-ID: <87wqqdoqvp.fsf@hexa.v.cablecom.net>
References: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"John J. Franey" <jjfraney@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 16:19:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uimel-0004Ys-Ma
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 16:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236Ab3FAOTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 10:19:32 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:22504 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754131Ab3FAOTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 10:19:30 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 1 Jun
 2013 16:19:23 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 1 Jun
 2013 16:19:27 +0200
In-Reply-To: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 1 Jun 2013 08:51:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226131>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Nobody is checking for specific error codes; it's the errno that's
> important.
[...]
> -		/*
> -		 * This return value is chosen so that code & 0xff
> -		 * mimics the exit code that a POSIX shell would report for
> -		 * a program that died from this signal.
> -		 */
> -		code += 128;

Have you checked the callers?  There are lots of callers of
finish_command(), which returns the value from wait_or_whine()
unmodified.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
