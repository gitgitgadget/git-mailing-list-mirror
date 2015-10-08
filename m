From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 05/10] ref-filter: adopt get_head_description() from branch.c
Date: Thu, 08 Oct 2015 21:01:03 +0200
Message-ID: <vpq8u7dmbgw.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<1444295885-1657-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 21:01:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkGRQ-000285-IA
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 21:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbbJHTBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 15:01:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48754 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755272AbbJHTBK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 15:01:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t98J11js010002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 8 Oct 2015 21:01:01 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t98J13Lg009629;
	Thu, 8 Oct 2015 21:01:03 +0200
In-Reply-To: <1444295885-1657-6-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 8 Oct 2015 14:48:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 08 Oct 2015 21:01:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t98J11js010002
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444935662.89706@Lb++zuVdmA/PSXaF4ONnCA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279261>

Karthik Nayak <karthik.188@gmail.com> writes:

> Copy the implementation of get_head_description() from branch.c.  This
> gives a description of the HEAD ref if called. This is used as the
> refname for the HEAD ref whenever the FILTER_REFS_DETACHED_HEAD option
> is used. Make it public because we need it to calculate the length of
> the HEAD refs description in branch.c:calc_maxwidth() when we port
> branch.c to use ref-filter APIs.

If it's made public, then it could be simpler to just _move_ the
function instead of copying it. You'd need to add a #include
<ref-filter.c> to branch.c, but you're going to add one anyway.

Code movement is more "git blame" friendly than code copy, and as a
reviewer I'd rather see the code movement here and not hear about it
later in the series.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
