From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Fix error in diff_filepair::status documentation.
Date: Sat, 01 Nov 2008 23:31:11 -0700
Message-ID: <7vod0y3ahc.fsf@gitster.siamese.dyndns.org>
References: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth>
 <20081101220314.1116.79924.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 07:32:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwWVr-0000KT-AL
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 07:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbYKBGbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 01:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbYKBGbZ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 01:31:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbYKBGbY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 01:31:24 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0BDAE77D3E;
	Sun,  2 Nov 2008 01:31:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C2A8F77D3D; Sun,  2 Nov 2008 01:31:17 -0500 (EST)
In-Reply-To: <20081101220314.1116.79924.stgit@gandelf.nowhere.earth> (Yann
 Dirson's message of "Sat, 01 Nov 2008 23:03:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DEB26F02-A8A7-11DD-AD3A-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99819>

Yann Dirson <ydirson@altern.org> writes:

> Signed-off-by: Yann Dirson <ydirson@altern.org>
> ---
>
>  diffcore.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/diffcore.h b/diffcore.h
> index 713cca7..05d0898 100644
> --- a/diffcore.h
> +++ b/diffcore.h
> @@ -62,7 +62,7 @@ struct diff_filepair {
>  	struct diff_filespec *one;
>  	struct diff_filespec *two;
>  	unsigned short int score;
> -	char status; /* M C R N D U (see Documentation/diff-format.txt) */
> +	char status; /* M C R A D U etc. (see DIFF_STATUS_* in diff.h) */

I think you spotted the right bug and fixed it in a wrong way.  The status
letters are user visible, and "git grep status Documentation/*diff*"
mention it in handful places without listing its repertoire, which _is_
the bug.
