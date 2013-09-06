From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 0/5] Disable "git status" comment prefix
Date: Fri, 06 Sep 2013 18:44:24 +0200
Message-ID: <vpqwqmtsxw7.fsf@anie.imag.fr>
References: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqhadzhyjb.fsf@gitster.dls.corp.google.com>
	<vpqioyfukkw.fsf@anie.imag.fr>
	<20130905232322.GB29351@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 06 18:45:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHz9r-0006vx-Ih
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 18:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757079Ab3IFQpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 12:45:12 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52608 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756982Ab3IFQpL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 12:45:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r86GiM3M000714
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Sep 2013 18:44:22 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VHz8y-00009Q-Rn; Fri, 06 Sep 2013 18:44:24 +0200
In-Reply-To: <20130905232322.GB29351@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 5 Sep 2013 19:23:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Sep 2013 18:44:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r86GiM3M000714
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379090663.63183@o0kaUj2p/zekJY1sKiybyQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234062>

Jeff King <peff@peff.net> writes:

>   # and have 472 and 59 different commits each, respectively.
>   #
>   # Untracked files:
[...]
>   and have 472 and 59 different commits each, respectively.
>   Untracked files:

Indeed, I forgot the else branch in wt_status_print_tracking:

	if (s->display_comment_char)
		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%c",
				 comment_line_char);
	else
		fprintf_ln(s->fp, "");

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
