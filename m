From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase: use @{upstream} if no upstream specified
Date: Tue, 8 Feb 2011 22:17:37 -0600
Message-ID: <20110209041737.GD24346@elie>
References: <1297125475-19151-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <AANLkTi=Uqkzv+ucBzww6R1V+0ujmfH-dED8XJhyRvWQF@mail.gmail.com>
 <alpine.DEB.2.00.1102081320350.4475@debian>
 <20110208220505.GA17981@elie>
 <alpine.DEB.2.00.1102081916330.9042@debian>
 <alpine.DEB.2.00.1102081959210.14152@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 05:17:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn1Uz-0003J8-2S
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 05:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756323Ab1BIERn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 23:17:43 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50759 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756288Ab1BIERm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 23:17:42 -0500
Received: by iyj8 with SMTP id 8so3974492iyj.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 20:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=LMtgdjbZvgSlzsP9KF+bkrKXu3+732BLAHujAIOg4CI=;
        b=wYo0IiwoBK0NSy3ah6DbhmPfnAvxkw3tJ0ljGgajsBSTRbnLa4hcgr8WRaakGFIek9
         +kzR2u+hCF8i2Qk59284CKmx4S6SJJVb+FRluLe9GrgU2klcHRvy3XUDWlHyvIxYIhrY
         4Vm9NI6kDuGW64LCizPdIZQLwW8J75TfJr6aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fHWdX5vuS//HIOz3/Jt10qFWd1+0FLHj7JhTGiRBfs6FLvy4u/8ZtZo2FMb9k8O8Ks
         OXCezQ1hGmgbphHwaD8FKCpqQIFQ4rLelogihuEtwWeTpSfCP9ZUQ8dfp3g5gVPEXrYt
         DHbB9Zsezdxcg3I0rK6HfGDh1TPue1x2veb4E=
Received: by 10.231.14.4 with SMTP id e4mr6435127iba.55.1297225061990;
        Tue, 08 Feb 2011 20:17:41 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id u9sm351204ibe.20.2011.02.08.20.17.40
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Feb 2011 20:17:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1102081959210.14152@debian>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166390>

Martin von Zweigbergk wrote:

> Maybe something like this on top? I put it in git-parse-remote.sh for
> now.

Thanks.  That sounds like a good place.

> Changes to the text compared to before:
>
>  * "remote branch" became "upstream branch", even for git pull

Sensible for pull --rebase.  I'm not so sure about plain pull --- what
if I am upstream and pulling from downstream?

>  * "You asked me to pull" became "You asked me to merge" or "You asked
>    me to rebase", even for git pull

"To pull" would be clearer if the reader is new and unfamiliar with
the details.

>  * Now printed to stderr, because I simply didn't think about it. Good
>    or bad?

If this were a new message, I'd say stderr is better.

As is, the change to stderr seems relatively harmless, though I haven't
thought about it deeply.  But a part of me likes to see functional
changes isolated in separate commits to make tracking down bugs a
little easier.

Hope that helps,
Jonathan
