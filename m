From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] git-bisect.sh : create a file if the bisection is in old/new mode, named "BISECT_OLDNEWMODE", so it can easily be seen outside the program without having to read BISECT_TERMS. This will have to be changed in further versions if new terms are introduced.
Date: Mon, 08 Jun 2015 13:54:57 +0200
Message-ID: <vpqvbeybejy.fsf@anie.imag.fr>
References: <1433522061-14532-1-git-send-email-stuberl@ensimag.grenoble-inp.fr>
	<CAP8UFD1OSSxfQOLggRv-VjE-8U=Vg7X5oe_UeFi4_yqOfXvgPA@mail.gmail.com>
	<1179544255.257552.1433703835857.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	j franck7 <j_franck7@msn.com>,
	Valentin Duperray <valentinduperray@gmail.com>,
	Thomas Nguy <thomasxnguy@gmail.com>, lucienkong@hotmail.com,
	Christian Couder <chriscool@tuxfamily.org>
To: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:55:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ve3-0004hF-4r
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbbFHLzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:55:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58873 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbbFHLzE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 07:55:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t58Bsujn003043
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 13:54:56 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58BsvI2002441;
	Mon, 8 Jun 2015 13:54:57 +0200
In-Reply-To: <1179544255.257552.1433703835857.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Louis-Alexandre Stuber's message of "Sun, 7 Jun 2015 21:03:55 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 08 Jun 2015 13:54:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58Bsujn003043
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434369297.61422@dRI/3gQ0LkT0GD+KadmStA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271027>

Please, don't top-post on this list.

Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr> writes:

> Thank you for the feedback. We are trying to apply all of your suggestions, but we would prefer to rebase the history before doing some of them (like renaming variables).
>
> About the BISECT_OLDNEWMODE file: The current implementation changes almost nothing to revision.c. We thought it was better, even if it needs a new file. The code for bisect uses BISECT_TERMS because 3 states are
> possible: 'bad/good mode', 'old/new mode', or 'no bisection started'
> (if BISECT_TERMS doesn't exist).

I don't think it's the main reason. The point is to make the code
generic: once the bisection has started and the terms are chosen, the
possible states for a commit are not really bad/good or old/new, but
'first line in BISECT_TERMS/second line in BISECT_TERMS'.

> But the other files (like revision.c) don't need all these
> informations, so we thought it would be good to check if a file exists
> instead of reusing BISECT_TERMS, which would require reading its
> content.
>
> ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> De: "Christian Couder" <christian.couder@gmail.com>
> ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
