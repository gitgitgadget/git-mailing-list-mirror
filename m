From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Don't optimize code in debug build
Date: Sun, 13 Feb 2011 10:36:50 +0100
Message-ID: <201102131036.51311.j6t@kdbg.org>
References: <AANLkTinw7DJ3hP7ACcScHTYy-Dvizq-OxefP6e0dEBbR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 10:37:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoYOE-0008H5-RO
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 10:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938Ab1BMJgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 04:36:54 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:11747 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753669Ab1BMJgx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 04:36:53 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 89624130057;
	Sun, 13 Feb 2011 10:36:51 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6868319F6D3;
	Sun, 13 Feb 2011 10:36:51 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTinw7DJ3hP7ACcScHTYy-Dvizq-OxefP6e0dEBbR@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166649>

On Sonntag, 13. Februar 2011, Piotr Krukowiecki wrote:
> --- a/Makefile
> +++ b/Makefile
> @@ -262,7 +262,10 @@ endif
>
>  # CFLAGS and LDFLAGS are for the users to override from the command line.
>
> -CFLAGS = -g -O2 -Wall
> +CFLAGS = -g -Wall
> +ifndef DEBUG
> +CFLAGS += -O2
> +endif
>  LDFLAGS =
>  ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)

Instead of this, you can just write

 CFLAGS = -g -Wall

in your config.mak. Is anything wrong with that?

-- Hannes
