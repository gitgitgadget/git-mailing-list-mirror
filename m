From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase -i: remove undocumented '--verify' flag
Date: Mon, 22 Nov 2010 13:53:57 +0100
Message-ID: <vpqoc9hsemy.fsf@bauges.imag.fr>
References: <1290408504-14639-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 13:54:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKVuj-0007VW-JA
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 13:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab0KVMy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 07:54:28 -0500
Received: from mx2.imag.fr ([129.88.30.17]:54019 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755732Ab0KVMy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 07:54:27 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id oAMCrj72024869
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Nov 2010 13:53:45 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PKVu9-0002o3-Oi; Mon, 22 Nov 2010 13:53:57 +0100
In-Reply-To: <1290408504-14639-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin von Zweigbergk's message of "Mon\, 22 Nov 2010 07\:48\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 22 Nov 2010 13:53:45 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oAMCrj72024869
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1291035226.88857@qrmrwZjC7AFr24dflSzTkg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161887>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Remove the undocumented and unused '--verify' flag from interactive
> rebase.

I don't think this change is good. If a command has a --no-whatever
flag, one expects the --whatever flag to exist too, even if it's a
no-op.

>  	--no-verify)
>  		OK_TO_SKIP_PRE_REBASE=yes
>  		;;

--no-verify exists, so

> -	--verify)
> -		;;

--verify exists too.

I think a better change would be to add a comment like

--verify)
	# no-op, exists because --no-verify exists too.
	;;

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
