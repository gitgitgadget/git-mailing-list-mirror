From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3] Allow the user to change the temporary file name for
 mergetool
Date: Tue, 19 Aug 2014 22:36:53 +0200
Message-ID: <53F3B565.5080309@kdbg.org>
References: <xmqqa970wgy0.fsf@gitster.dls.corp.google.com> <1408468545-6879-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 22:37:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJq9Q-0001bf-9x
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 22:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbaHSUg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 16:36:59 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:15080 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750936AbaHSUg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 16:36:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 474BBCDF82;
	Tue, 19 Aug 2014 22:36:55 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id CF68F19F45C;
	Tue, 19 Aug 2014 22:36:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
In-Reply-To: <1408468545-6879-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255517>

Am 19.08.2014 19:15, schrieb Robin Rosenberg:
> Using the original filename suffix for the temporary input files to
> the merge tool confuses IDEs like Eclipse. This patch introduces
> a configurtion option, mergetool.tmpsuffix, which get appended to
> the temporary file name. That way the user can choose to use a
> suffix like ".tmp", which does not cause confusion.

I have a merge tool that does syntax highlighting based on the file
extension. Given this:

> +	BACKUP="./$MERGED.BACKUP.$ext$tmpsuffix"
> +	LOCAL="./$MERGED.LOCAL.$ext$tmpsuffix"
> +	REMOTE="./$MERGED.REMOTE.$ext$tmpsuffix"
> +	BASE="./$MERGED.BASE.$ext$tmpsuffix"

I guess I lose syntax highlighting if I were to use mergetool.tmpsuffix;
but then I don't use Eclipse. Could it be that this is really just a
band-aid for Eclipse users, not IDEs in general as you are hinting in
the Documentation of the new variable?

-- Hannes
