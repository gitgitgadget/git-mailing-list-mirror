From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Configure test for FREAD_READS_DIRECTORIES
Date: Tue, 04 Mar 2008 03:03:12 -0800
Message-ID: <7vod9u92fj.fsf@gitster.siamese.dyndns.org>
References: <200803041048.53399.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Tue Mar 04 12:04:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWUwX-0001m1-Lv
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 12:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065AbYCDLDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 06:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbYCDLDV
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 06:03:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbYCDLDU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 06:03:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 485BE2183;
	Tue,  4 Mar 2008 06:03:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9F8C12182; Tue,  4 Mar 2008 06:03:14 -0500 (EST)
In-Reply-To: <200803041048.53399.michal.rokos@nextsoft.cz> (Michal Rokos's
 message of "Tue, 4 Mar 2008 10:48:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76062>

Michal Rokos <michal.rokos@nextsoft.cz> writes:

> Hello,

"Hello," not wanted in the commit log message.

> this patch adds missing tests for FREAD_READS_DIRECTORIES.
>
> Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>

> +#
> +# Define FREAD_READS_DIRECTORIES if your are on a system which succeeds
> +# when attempting to read from an fopen'ed directory.
> +AC_CACHE_CHECK([whether system succeeds to read fopen'ed directory],
> + [ac_cv_fread_reads_directories],
> +[
> +AC_RUN_IFELSE(
> +	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
> +		[[char c;
> +		FILE *f = fopen("/etc", "r");

Why "/etc" and not "." I have to wonder...

On how many different platforms was this configure check tested on?
