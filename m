From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 03/10] Add a mergetool-lib scriptlet for holding common
	merge tool functions
Date: Wed, 1 Apr 2009 20:58:40 -0700
Message-ID: <20090402035839.GA43852@gmail.com>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com> <1238590514-41893-3-git-send-email-davvid@gmail.com> <1238590514-41893-4-git-send-email-davvid@gmail.com> <200904020039.41894.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, charles@hashpling.org, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 02 06:00:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpE6a-000887-HP
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 06:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430AbZDBD6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 23:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbZDBD6t
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 23:58:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:28910 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbZDBD6t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 23:58:49 -0400
Received: by rv-out-0506.google.com with SMTP id f9so391235rvb.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 20:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DNy7wQXLoRndATyud88QFQLpp9yVAiKpX7zhA6iQils=;
        b=Crd8y2NrsbNJN+SqcPWfbkqId4Mnmodi9FrjjbFSdqpWsSA1tGUYNpQp24sYVFs8eb
         TIb5mnKpl1m+7lChT/Ub/3BZ+WL/Xckw56+p6Mp6uASuXnRRKzmG5kGUzRXQO7w/g/lp
         u1gyX9L1YPjPwsiyEqrQV21AV68G4/3FauEQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FLMS48GfaQQissRXcKEROSndHDGsyZWuFK4RROO+oFgJFDSWp3zg8GTB1s016v8AHW
         uhIJ8IrrbJJR+xpBvksu5SCIItR4DHYFr0OClLIkk1LZd9uyMNgsWMEZApgyCfGYPJLZ
         fw7GdKo0VXlSIsS82xtmdENQJR9imglAiNUdA=
Received: by 10.141.204.17 with SMTP id g17mr4348755rvq.41.1238644726633;
        Wed, 01 Apr 2009 20:58:46 -0700 (PDT)
Received: from gmail.com (isrfasc7a1-gw.disneyanimation.com [12.188.26.241])
        by mx.google.com with ESMTPS id b8sm1712350rvf.42.2009.04.01.20.58.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 20:58:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200904020039.41894.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115434>

On  0, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> David Aguilar, 01.04.2009:
> > 
> > diff --git a/git-mergetool-lib.sh b/git-mergetool-lib.sh
> > +valid_tool () {
> > +	case "$1" in
> > +	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
> > +		if test "$1" = "kompare" && ! diff_mode; then
> > +			return 1
> > +		fi
> > +		;; # happy
> > +	*)
> > +		if ! test -n "$(get_custom_cmd "$1")"; then
> 
> Better this?
> 		if test -z "$(get_custom_cmd "$1")"; then
> 
> > +			return 1
> > +		fi ;;
> 
> For consistency:
> 		fi
> 		;;
> 


I'll reroll tonight and include you on the CC when I resent the
patches in question.

Thanks Markus.

-- 
		David
