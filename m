From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/6] transport-helper: clarify *:* refspec
Date: Thu, 18 Apr 2013 09:28:05 +0200
Message-ID: <87li8gxpq2.fsf@linux-k42r.v.cablecom.net>
References: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
	<1366243524-18202-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 09:28:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USjGQ-0004OA-4V
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 09:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965898Ab3DRH2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 03:28:09 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:10088 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965073Ab3DRH2I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 03:28:08 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 18 Apr
 2013 09:27:57 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 18 Apr 2013 09:28:04 +0200
In-Reply-To: <1366243524-18202-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Wed, 17 Apr 2013 19:05:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221616>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The *:* refspec doesn't work, and never has, clarify the code and
> documentation to reflect that. This in effect reverts commit 9e7673e
> (gitremote-helpers(1): clarify refspec behaviour).
[...]
> -test_expect_success 'pulling with straight refspec' '
> -	(cd local2 &&
> -	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git pull) &&
> -	compare_refs local2 HEAD server HEAD
> -'
> -
> -test_expect_failure 'pushing with straight refspec' '
> -	test_when_finished "(cd local2 && git reset --hard origin)" &&
> -	(cd local2 &&
> -	echo content >>file &&
> -	git commit -a -m eleven &&
> -	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git push) &&
> -	compare_refs local2 HEAD server HEAD
> -'

So what's wrong with the tests?  Do they fail to test what they claim
(how?), test something that wasn't reasonable to begin with, or
something entirely different?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
