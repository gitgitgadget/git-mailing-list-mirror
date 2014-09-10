From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH v2 1/2] Makefile: add check-headers target
Date: Wed, 10 Sep 2014 19:24:50 +0200
Message-ID: <vpqk35bo0bh.fsf@anie.imag.fr>
References: <1410049821-49861-1-git-send-email-davvid@gmail.com>
	<xmqqiokylz46.fsf@gitster.dls.corp.google.com>
	<vpqsik13o84.fsf@anie.imag.fr>
	<xmqqa969nav9.fsf@gitster.dls.corp.google.com>
	<20140910000328.GB12644@gmail.com>
	<xmqq38bzieqj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 19:25:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRldm-0006yT-Jj
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 19:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbaIJRZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 13:25:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48202 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269AbaIJRZC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 13:25:02 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s8AHOmsM022829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Sep 2014 19:24:48 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s8AHOoYA001642;
	Wed, 10 Sep 2014 19:24:50 +0200
In-Reply-To: <xmqq38bzieqj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 10 Sep 2014 10:09:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 10 Sep 2014 19:24:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s8AHOmsM022829
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1410974689.04695@FAXcKsHLh9D79N0INwj94Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256756>

Junio C Hamano <gitster@pobox.com> writes:

> David Aguilar <davvid@gmail.com> writes:
>
>> On Mon, Sep 08, 2014 at 12:57:46PM -0700, Junio C Hamano wrote:
>>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>> ...
>>> > for header in .h ewah/*.h vcs-svn/*.h xdiff/*.h
>>> > do
>>> > 	...
>>> > done
>>> 
>>> Yes, that would be even better.  Then you wouldn't even have to
>>> worry about $IFS dance.
>>
>> The original motivation was to avoid picking up the generated
>> common-cmds.h header file.
>
> 	for header
>         do
>         	case "$header" in $exceptions) continue ;; esac
> 		...
> 	done
>
> with comments describing why these exceptions are made would be a
> better way to go in such a case.

+1 from me. It would allow developers to use the rule without "git
add"-ing new .h files, and the comment would document why the
exceptions are there (which missed in the original patch IMHO).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
