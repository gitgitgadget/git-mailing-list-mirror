From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Feb 2013, #04; Sat, 9)
Date: Mon, 11 Feb 2013 10:14:06 +0100
Message-ID: <vpqliavxlep.fsf@grenoble-inp.fr>
References: <7vtxplt5u2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 10:14:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4pTC-00043D-DY
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 10:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523Ab3BKJOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 04:14:15 -0500
Received: from mx1.imag.fr ([129.88.30.5]:39650 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754446Ab3BKJOO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 04:14:14 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1B9E6mD009492
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2013 10:14:06 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U4pSh-00034i-B0; Mon, 11 Feb 2013 10:14:07 +0100
In-Reply-To: <7vtxplt5u2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 09 Feb 2013 15:39:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Feb 2013 10:14:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1B9E6mD009492
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361178849.28264@PligiwY83nPcwL2a8L6aDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216027>

Junio C Hamano <gitster@pobox.com> writes:

> * mm/allow-contrib-build (2013-02-07) 2 commits
>  - perl.mak: introduce $(GIT_ROOT_DIR) to allow inclusion from other directories
>  - Makefile: extract perl-related rules to make them available from other dirs
>
>  Will merge to 'next'.

These two patches do not make much sense without the 3rd one:

  [PATCH 3/4] Makefile: factor common configuration in git-default-config.mak

because perl.mak uses $(pathsep) that is defined in Makefile, hence
unreachable from external callers.

You can either drop the series (I still think it's a good thing to make
the toplevel Makefile more modular, but I have no longer a personal
interest in it since the original goal is already reached by
mm/remote-mediawiki-build), or continue the discussion on [PATCH 3/4].

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
