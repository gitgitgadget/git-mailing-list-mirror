From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] git-tag man: when to use lightweight or annotated tags
Date: Fri, 26 Jul 2013 12:36:43 -0700
Message-ID: <20130726193643.GH14690@google.com>
References: <51EFA9A9.4010103@gmail.com>
 <7vtxjj66kn.fsf@alter.siamese.dyndns.org>
 <51F12BE6.80606@gmail.com>
 <51F13A8F.9040400@xiplink.com>
 <51F23706.5040009@gmail.com>
 <51F2375E.1080003@gmail.com>
 <51F28D08.8050507@xiplink.com>
 <51F2AFBA.4020602@gmail.com>
 <51F2B2CD.1030004@gmail.com>
 <20130726190602.GC29799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniele Segato <daniele.segato@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 26 21:36:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2not-0004jp-9L
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 21:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab3GZTgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 15:36:49 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:44732 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab3GZTgs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 15:36:48 -0400
Received: by mail-pd0-f174.google.com with SMTP id 3so2206922pdj.5
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MORwaPY+uG8isHr6CU75ZEHyRfXgnzIrU69a7vPV3M4=;
        b=xwRvwyGqOid21EzezDMP7JKo4CFlLSACDXG6uggioAgAwuHg6xQvezu3JwqTZpRRDa
         1E4qiWprwLjKo3VdC5/lxGzDyNGXGVSNRNvdEtUtkVL5rgfLDc66FRi6m+lYMJnBBsDt
         FFtFiynm/UAkpiNmzZvx/UQLPStT71mYAsb8icjgAdeoUGaPXTXFE/m4k3nabivaKt/2
         rSZqWx93/40YptjWlQnJ3htcbA+f1FE8HpMgzVOpLyXYlJBdm1YxKQNMRxwiRYoJCh1R
         7Tkmbb1O/ISY2EznyKYWWRngOn0E9iv68+XvU3L2jd6JJwa8z5eFnsosxXYifbnCA3UZ
         nF3A==
X-Received: by 10.68.228.39 with SMTP id sf7mr55545985pbc.34.1374867407830;
        Fri, 26 Jul 2013 12:36:47 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id e7sm48550265pbc.11.2013.07.26.12.36.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 12:36:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130726190602.GC29799@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231199>

Jeff King wrote:

> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -42,6 +42,17 @@ is used to specify custom GnuPG binary.
>  GnuPG key for signing. 	The configuration variable `gpg.program`
>  is used to specify custom GnuPG binary.
>  
> +Tag objects (created with `-a`, `s`, or `-u`) are called "annotated"
> +tags; they contain a creation date, the tagger name and e-mail, a
> +tagging message, and an optional GnuPG signature. Whereas a
> +"lightweight" tag is simply a name for an object (usually a commit
> +object).
> +
> +Annotated tags are meant for release while lightweight tags are meant
> +for private or temporary object labels. For this reason, some git
> +commands for naming objects (like `git describe`) will ignore
> +lightweight tags by default.

Very readable, and I think this is a good start.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Eventually the description section should probably be tweaked to start
by explaining what the command is actually for. ;-)
