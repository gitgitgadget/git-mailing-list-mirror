From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] send-email: squelch warning from Net::SMTP::SSL
Date: Fri, 05 Jul 2013 13:31:10 +0200
Message-ID: <vpqbo6hw8e9.fsf@anie.imag.fr>
References: <1373019511-13232-1-git-send-email-artagnon@gmail.com>
	<20130705104557.GL9161@serenity.lan>
	<CALkWK0nWvmuxfZJF_Mk2MmJNxz4+=46m_pBtzjSZprLxABhNeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>, Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 13:31:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv4Eg-0000N7-0H
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 13:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757207Ab3GELba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 07:31:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58471 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757048Ab3GELb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 07:31:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r65BV9Hb013618
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 5 Jul 2013 13:31:09 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Uv4EI-0004yN-Si; Fri, 05 Jul 2013 13:31:10 +0200
In-Reply-To: <CALkWK0nWvmuxfZJF_Mk2MmJNxz4+=46m_pBtzjSZprLxABhNeA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 5 Jul 2013 16:22:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 05 Jul 2013 13:31:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r65BV9Hb013618
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1373628674.97932@ER65FIbehX4EeFQdV8QJLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229650>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> John Keeping wrote:
>> I don't think this is really "fix", it's more plastering over the
>> problem.
>
> It defaulted to SSL_VERIFY_NONE before Net::SMTP::SSL was updated, and
> the behavior hasn't changed now.  The new version simply asks us to be
> explicit about SSL_VERIFY_NONE, so we are aware about it.

"We" as "the Git developers", yes. But your change makes sure users are
_not_ aware about it. There's a long history of software ignoring SSL
certificates by default, I don't think we should cast in stone that we
don't want SSL certificate verification.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
