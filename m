From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 03/10] Add a mergetool-lib scriptlet for holding common merge tool functions
Date: Thu, 2 Apr 2009 00:39:41 +0200
Message-ID: <200904020039.41894.markus.heidelberg@web.de>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com> <1238590514-41893-3-git-send-email-davvid@gmail.com> <1238590514-41893-4-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, charles@hashpling.org, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 00:41:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp97L-0004g7-92
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 00:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbZDAWjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 18:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753036AbZDAWjf
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 18:39:35 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:49413 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbZDAWjf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 18:39:35 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 0AD9FF9DCF00;
	Thu,  2 Apr 2009 00:39:33 +0200 (CEST)
Received: from [89.59.70.14] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lp95o-0003lB-00; Thu, 02 Apr 2009 00:39:32 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1238590514-41893-4-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18jxUM/3GPripZ97gJ6iQZYLoB/rOlmreQvDmdE
	dc+SgwTfGG2VL60rUjqrIKc/9s3p1BMy2hX/pdQWWtHBVzPDNF
	9vbXMcMSBuZTnisDR9SQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115421>

David Aguilar, 01.04.2009:
> 
> diff --git a/git-mergetool-lib.sh b/git-mergetool-lib.sh
> +valid_tool () {
> +	case "$1" in
> +	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
> +		if test "$1" = "kompare" && ! diff_mode; then
> +			return 1
> +		fi
> +		;; # happy
> +	*)
> +		if ! test -n "$(get_custom_cmd "$1")"; then

Better this?
		if test -z "$(get_custom_cmd "$1")"; then

> +			return 1
> +		fi ;;

For consistency:
		fi
		;;
