From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v2 3/3] status: introduce status.displayCommentChar to disable display of #
Date: Thu, 29 Aug 2013 08:58:09 +0200
Message-ID: <vpqeh9d3rwe.fsf@anie.imag.fr>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
	<1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq1u5da8dp.fsf@gitster.dls.corp.google.com>
	<20130828201803.GB8088@sigill.intra.peff.net>
	<xmqqmwo18pgw.fsf@gitster.dls.corp.google.com>
	<CAJDDKr6RDiAxgUdaE5aH4-wxYRY7fKnUukX1D-t07=-_P0CZAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 08:58:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEwBa-0003EN-33
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 08:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112Ab3H2G60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 02:58:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36418 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895Ab3H2G6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 02:58:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7T6w93Q028990
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 08:58:09 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VEwBG-0004HJ-3q; Thu, 29 Aug 2013 08:58:10 +0200
In-Reply-To: <CAJDDKr6RDiAxgUdaE5aH4-wxYRY7fKnUukX1D-t07=-_P0CZAg@mail.gmail.com>
	(David Aguilar's message of "Wed, 28 Aug 2013 14:59:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Aug 2013 08:58:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7T6w93Q028990
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378364291.98535@FKVioQvcxmfKMoN/hNCQlA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233239>

David Aguilar <davvid@gmail.com> writes:

> I have a poor imagination and cannot imagine why it needs to be
> switchable.

I could not either, but I found the reason in the commit message:
eff80a9fd990

    Some users do want to write a line that begin with a pound sign, #,
    in their commit log message.  Many tracking system recognise
    a token of #<bugid> form, for example.
    
    The support we offer these use cases is not very friendly to the end
    users.  They have a choice between
    
     - Don't do it.  Avoid such a line by rewrapping or indenting; and
    
     - Use --cleanup=whitespace but remove all the hint lines we add.
    
    Give them a way to set a custom comment char, e.g.
    
        $ git -c core.commentchar="%" commit
    
    so that they do not have to do either of the two workarounds.

I personnally think allowing an escape scheme (\#) would have been
better.

But as Junio said, it's too late. My change is not about commentchar
customizability, but about disabling the comment in "git status".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
