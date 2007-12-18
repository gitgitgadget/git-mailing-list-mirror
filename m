From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Simple support for tree entry specification with relative pathnames
Date: Tue, 18 Dec 2007 13:03:04 -0800
Message-ID: <56b7f5510712181303h1e7ae35dpa0adfd6804a7cecd@mail.gmail.com>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>
	 <20071218204623.GC2875@steel.home> <20071218204752.GD2875@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>, danahow@gmail.com
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 22:03:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4jbB-0002rQ-UC
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 22:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbXLRVDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 16:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbXLRVDJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 16:03:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:1521 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbXLRVDG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 16:03:06 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1460165nfb.21
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 13:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Jtttl4W26/2QwJ9yNDDYFi1zjyRzdWm67NPnbNKyxHQ=;
        b=M9pa6ZMt8qR+hWNZLAk1Gdxg4APFQtC9ErXKXfWRAeYyVx1xiZexXdq22JgpEy8S6EhiCR+fvXIs6rYKIUNmdka/k578ux+JRtYTHCmdFs7utp0+cauXmWVr7nqrtmgK7GuZJjlXtXuEaTN5PVtDSzSozQjZNF87+myosbhuN/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EP6ovS4uNjU7aNE7A7/78hPcr77KsJtupMFxl5wpoHoIDFFUAJ5e4wU3LroE/JhUqRbYlFtXMwwLBTbCENpe8oBr8ZADvr5UNS9C1FvMdHgVI7xOG8lXz6BSAHKt1+juWqQ12it7ySrw3dnilPffzB/NmmmFaPpuCQRwxweBeA4=
Received: by 10.78.204.20 with SMTP id b20mr10530112hug.33.1198011784735;
        Tue, 18 Dec 2007 13:03:04 -0800 (PST)
Received: by 10.78.130.1 with HTTP; Tue, 18 Dec 2007 13:03:04 -0800 (PST)
In-Reply-To: <20071218204752.GD2875@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68814>

ACK from me...

I submitted a similar patch last May 4 which also
changed sha1_name.c to do this.  The patch
added a config variable to control this
(probably not desirable).  The patch also handled
leading/embedded . and .. .

In p4 you can say
  p4 <operation> file#rev
and file is interpreted relatively.

I wanted to be able to say
  git <operation> tree:file
and have file interpreted relatively.
This should only happen when you are inside the work tree.

Good luck!

Dana

On Dec 18, 2007 12:47 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> This allows git show to understand something like this:
>
>     $ test -f DIR/file && cd DIR &&  git show rev:file
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> This is a bit too simplistic and can be fooled easily:
>
>     .../t$ git show HEAD:../t/test-lib.sh
>
> wont work. It is short, though.

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
