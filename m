From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: standardize on $() for command substitution
Date: Wed, 31 Oct 2007 22:16:31 -0700
Message-ID: <7vr6jaczps.fsf@gitster.siamese.dyndns.org>
References: <1193892608-31322-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 06:16:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InSQG-0000W1-Pb
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 06:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbXKAFQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 01:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbXKAFQj
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 01:16:39 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:37282 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbXKAFQj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 01:16:39 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B1D312F0;
	Thu,  1 Nov 2007 01:16:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 44A738EEC8;
	Thu,  1 Nov 2007 01:16:57 -0400 (EDT)
In-Reply-To: <1193892608-31322-1-git-send-email-dpmcgee@gmail.com> (Dan
	McGee's message of "Wed, 31 Oct 2007 23:50:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62917>

Dan McGee <dpmcgee@gmail.com> writes:

> Commit 889a50e909dba5f4416049afc5eeae601fe133bc changed several `` to $()
> format for command substitution, so we should standardize on one format
> for clarity.
> ...
> @@ -203,7 +203,7 @@ do
>  	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
>  		case "$#,$1" in
>  		*,*=*)
> -			strategy=`expr "z$1" : 'z-[^=]*=\(.*\)'` ;;
> +			strategy=$(expr "z$1" : 'z-[^=]*=\(.*\)'` ;)
>  		1,*)
>  			usage ;;
>  		*)

The patch might have meant well, but it is a rather unnecessary
code churn without fixing anything and introducing a bug X-<.
