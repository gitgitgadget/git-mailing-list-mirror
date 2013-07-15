From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/5] diff: allow --patch to override -s/--no-patch
Date: Mon, 15 Jul 2013 17:28:08 +0200
Message-ID: <vpqa9lnderb.fsf@anie.imag.fr>
References: <vpqa9lof2e4.fsf@anie.imag.fr>
	<1373893639-13413-1-git-send-email-Matthieu.Moy@imag.fr>
	<1373893639-13413-3-git-send-email-Matthieu.Moy@imag.fr>
	<7v61wbeuix.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, stefanbeller@googlemail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 17:29:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UykiY-0001KD-4F
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 17:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933091Ab3GOP3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 11:29:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41945 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932675Ab3GOP3d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 11:29:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r6FFS7cj013173
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 17:28:09 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Uykh7-0002XE-7I; Mon, 15 Jul 2013 17:28:09 +0200
In-Reply-To: <7v61wbeuix.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 15 Jul 2013 08:02:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Jul 2013 17:28:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6FFS7cj013173
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1374506894.13642@48DAdGgkF6TJo5VRiZ4M1w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230479>

Junio C Hamano <gitster@pobox.com> writes:

> I am wondering if the difference after this patch between "-p" and
> "-U8" is deliberate, or just an accident coming from the way the
> original was written in ee1e5412 (git diff: support "-U" and
> "--unified" options properly, 2006-05-13).

No, it isn't. I just didn't notice the -U case.

> If the original were written in this way:
>
> 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch") ||
>             opt_arg(arg, 'U', "unified", &options->context))
>   		options->output_format |= DIFF_FORMAT_PATCH;

Yes, this seems to be a better way.

There are other cases like --patch-with-raw, I'll send a reroll.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
