From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH v2] mergetool--lib: add new merge tool TortoiseMerge
Date: Sun, 5 Apr 2009 01:10:08 -0400
Message-ID: <DB42161D-8B55-4739-B418-D286B280EFF8@silverinsanity.com>
References: <1238904024-11238-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, markus.heidelberg@web.de, charles@hashpling.org,
	git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 07:12:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqKeM-0000dC-Cz
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 07:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbZDEFKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 01:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbZDEFKU
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 01:10:20 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:59329 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbZDEFKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 01:10:18 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 93C8B1FFC160; Sun,  5 Apr 2009 05:10:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 3C7CB1FFC03B;
	Sun,  5 Apr 2009 05:09:59 +0000 (UTC)
In-Reply-To: <1238904024-11238-1-git-send-email-davvid@gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115635>


On Apr 5, 2009, at 12:00 AM, David Aguilar wrote:

> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index dcd4516..268485a 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -46,10 +46,13 @@ check_unchanged () {
>
> valid_tool () {
> 	case "$1" in
> -	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge |  
> vimdiff | gvimdiff | ecmerge | diffuse)
> +	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge |  
> vimdiff | gvimdiff | ecmerge | diffuse | tortoisemerge)
> 		if test "$1" = "kompare" && ! diff_mode; then
> 			return 1
> 		fi
> +		if test "$1" = "tortoisemerge" && ! merge_mode; then
> +			return 1
> +		fi
> 		;; # happy
> 	*)
> 		if test -z "$(get_merge_tool_cmd "$1")"; then

Why is `case "$1"` being followed by two `if test "$1" =`s?
Wouldn't it be simpler to have separate case arms for them?
Especially with how long that list is getting...

~~ Brian
