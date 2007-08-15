From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH 1/2] Introduces xmkstemp()
Date: Wed, 15 Aug 2007 13:17:04 -0300
Organization: Mandriva
Message-ID: <20070815131704.6cb76dbe@localhost>
References: <20070814164453.400b9c55@localhost>
	<1b46aba20708150811o3a6fa14ew72e925c93d158ec4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Carlos Rica" <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 18:17:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILLZ7-0005ME-If
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 18:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757119AbXHOQRq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 12:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756965AbXHOQRq
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 12:17:46 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:36908 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757060AbXHOQRp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 12:17:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 84E981A2BB;
	Wed, 15 Aug 2007 13:17:40 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id wJ96K7RFngdc; Wed, 15 Aug 2007 13:17:35 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 0D00C1A2C3;
	Wed, 15 Aug 2007 13:17:11 -0300 (BRT)
In-Reply-To: <1b46aba20708150811o3a6fa14ew72e925c93d158ec4@mail.gmail.com>
X-Mailer: Claws Mail 2.10.0 (GTK+ 2.11.6; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55917>


 Hi Carlos,

Em Wed, 15 Aug 2007 17:11:02 +0200
"Carlos Rica" <jasampler@gmail.com> escreveu:

| 2007/8/14, Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>:
| >
| > This is a wrapper for mkstemp() that performs error checking and
| > calls die() when an error occur.
| 
| I think that it is related with the git_mkstemp() function in path.c.

 Yeah, you right.

| Perhaps we should use xmkstemp inside that function too, since
| it is only used in diff.c and after the call it also dies when fd<0.

 Actually, git_mkstemp() is also called by your builtin-verify-tag.c
program and the function which calls it (run_gpg_verify()) doesn't
die() on error.

 This series is not supposed to change programs/design behaivor,
hence I've chosen to not port the calls which doesn't explicit die
on error.

 But feel free to go ahead and port the others. ;)

-- 
Luiz Fernando N. Capitulino
