From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Build-in "git-shell"
Date: Wed, 20 Aug 2008 08:54:14 +0200
Message-ID: <48ABBF96.2050609@viscovery.net>
References: <20080818123727.GB11842@schiele.dyndns.org> <7vy72tkfu0.fsf@gitster.siamese.dyndns.org> <20080819072650.GE11842@schiele.dyndns.org> <7vpro5fnke.fsf@gitster.siamese.dyndns.org> <48AA8931.1030009@viscovery.net> <20080819091830.GG11842@schiele.dyndns.org> <7vbpzoy53d.fsf@gitster.siamese.dyndns.org> <7v7iacv6kb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 08:55:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVhbL-0003wQ-B6
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 08:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbYHTGyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 02:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbYHTGyT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 02:54:19 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:44747 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbYHTGyS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 02:54:18 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KVhaB-0008DR-6p; Wed, 20 Aug 2008 08:54:15 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CD77154D; Wed, 20 Aug 2008 08:54:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v7iacv6kb.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2, UPPERCASE_25_50=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92966>

Junio C Hamano schrieb:
> This trivially makes "git-shell" a built-in.  It makes the executable even
> fatter, though.
...
> diff --git a/Makefile b/Makefile
> index 71339e1..1a52f71 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -546,6 +546,7 @@ BUILTIN_OBJS += builtin-rev-parse.o
>  BUILTIN_OBJS += builtin-revert.o
>  BUILTIN_OBJS += builtin-rm.o
>  BUILTIN_OBJS += builtin-send-pack.o
> +BUILTIN_OBJS += builtin-shell.o
>  BUILTIN_OBJS += builtin-shortlog.o
>  BUILTIN_OBJS += builtin-show-branch.o
>  BUILTIN_OBJS += builtin-show-ref.o

You must squash this in:

diff --git a/Makefile b/Makefile
index 57d16cb..fae9b22 100644
--- a/Makefile
+++ b/Makefile
@@ -826,7 +826,6 @@ EXTLIBS += -lz
 ifndef NO_POSIX_ONLY_PROGRAMS
 	PROGRAMS += git-daemon$X
 	PROGRAMS += git-imap-send$X
-	PROGRAMS += git-shell$X
 endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl

We removed git-shell from the MinGW build only because of the compat
dependencies. We don't have problems building it as a built-in.

-- Hannes
