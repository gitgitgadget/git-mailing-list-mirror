From: Knut Franke <k.franke@science-computing.de>
Subject: Re: [PATCH 1/2] Add a new option 'core.askpass'.
Date: Mon, 30 Aug 2010 13:44:21 +0200
Organization: science + computing ag
Message-ID: <201008301344.22983.k.franke@science-computing.de>
References: <201008271251.19754.k.franke@science-computing.de> <7vaao8hsmx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Frank Li <lznuaa@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 13:59:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq31b-0003tU-JR
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 13:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab0H3L7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 07:59:37 -0400
Received: from smtp1.belwue.de ([129.143.2.12]:34548 "EHLO smtp1.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754169Ab0H3L7g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 07:59:36 -0400
X-Greylist: delayed 910 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Aug 2010 07:59:36 EDT
Received: from mx3.science-computing.de (mx3.science-computing.de [193.197.16.20])
	by smtp1.belwue.de with ESMTP id o7UBiOgN006426
	for <git@vger.kernel.org>; Mon, 30 Aug 2010 13:44:24 +0200 (MEST)
	env-from (prvs=851ee50e4=k.franke@science-computing.de)
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 70E42AC006;
	Mon, 30 Aug 2010 13:44:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guinesstest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EUoWNtZBOmac; Mon, 30 Aug 2010 13:44:23 +0200 (CEST)
Received: from sirmione.science-computing.de (sirmione.science-computing.de [10.10.24.2])
	by scmail.science-computing.de (Postfix) with ESMTP id CEA97AC001;
	Mon, 30 Aug 2010 13:44:23 +0200 (CEST)
Received: from sirmione.localnet (localhost [127.0.0.1])
	by sirmione.science-computing.de (Postfix) with ESMTP id BAE20AE3C9;
	Mon, 30 Aug 2010 13:44:23 +0200 (CEST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.29-0.1-pae; KDE/4.1.3; i686; ; )
In-Reply-To: <7vaao8hsmx.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154790>

On Friday 27 August 2010 19:28:38 Junio C Hamano wrote:
> I don't see ASKPASS documented anywhere in the Documentation/ in the first
> place.  Perhaps we would want to fix that while we are at it.

It's at least mentioned in the core.askpass documentation added by the patch,
but I'll try to improve.

Incidentally, the documentation for other environment variables
(GIT_PROXY_COMMAND, GIT_SSL_CERT, GIT_SSL_KEY, GIT_SSL_NO_VERIFY,
GIT_SSL_CERT_PASSWORD_PROTECTED, GIT_SSL_CAINFO, GIT_SSL_CAPATH)
is equally sparse.

> Also this
> does not feel like a "core." thing, but it may be just me.

Where else could it go? It's not entirely http specific:

$ grep git_getpass *.c
connect.c:char *git_getpass(const char *prompt)
http.c:                 user_pass = xstrdup(git_getpass("Password: "));
http.c: ssl_cert_password = git_getpass("Certificate Password: ");
http.c:                          * git_getpass is needed here because its very likely stdin/stdout are
http.c:                          * but that is non-portable.  Using git_getpass() can at least be stubbed
http.c:                         user_name = xstrdup(git_getpass("Username: "));
imap-send.c:                    arg = git_getpass(prompt);

Nor does it relate to a single command.
-- 
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Roland Niemeier, 
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Michel Lepert
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196 
