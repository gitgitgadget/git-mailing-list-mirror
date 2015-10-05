From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 6/9] ref-filter: introduce format_ref_array_item()
Date: Mon, 05 Oct 2015 10:49:48 +0200
Message-ID: <vpq1td9zolv.fsf@grenoble-inp.fr>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-7-git-send-email-Karthik.188@gmail.com>
	<vpqoagg9n2l.fsf@grenoble-inp.fr>
	<CAOLa=ZTMf9i=+9Rgi9oO==vr_JGtG3J9DvQWk18Zx-yd5_35XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 10:50:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj1T5-0008AG-Mb
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 10:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbbJEItz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 04:49:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57018 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616AbbJEIty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 04:49:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t958nlSb012613
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 5 Oct 2015 10:49:47 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t958nmQs028191;
	Mon, 5 Oct 2015 10:49:48 +0200
In-Reply-To: <CAOLa=ZTMf9i=+9Rgi9oO==vr_JGtG3J9DvQWk18Zx-yd5_35XA@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 5 Oct 2015 13:19:13 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 05 Oct 2015 10:49:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t958nlSb012613
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444639789.3021@JnbeGPzquPU6NlOgTnXk0g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279047>

Karthik Nayak <karthik.188@gmail.com> writes:

> The problem is with colors which tag.c doesn't use by default.
> Here we need to print colors only if we're printing to a tty which supports
> colors.

Ah, and tag --format '%(color:...)' does not do the tty autodetection.

> which does not play well with the implementation of --column as done
> in tag.c. Where, If I'm not wrong the --column option captures all
> output, formats it and then prints it to stdout. Hence when using
> colors, we're told that the printing isn't done to a tty which
> supports colors, hence we lose out on colors.

What I don't understand is how --column is different from --no-column
wrt colors.

In any case, this should be explained better in comments.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
