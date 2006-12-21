From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: specify charset for commits
Date: Fri, 22 Dec 2006 01:36:39 +0600
Message-ID: <200612220136.39905.litvinov2004@gmail.com>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de> <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 20:37:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxTin-0003iB-Cw
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 20:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423057AbWLUTgu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 14:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423058AbWLUTgu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 14:36:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:15935 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423057AbWLUTgu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 14:36:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2750738uga
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 11:36:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NWOMhPa7WZCdvOoL2Rbtr0rwUVmV9ibNNBSGLHVPhdZ41vkkuGk3326X4o3aBTDrx7XtEAzSI3QBUreavAkJtzknaWG0uJaZEw+stdGghi7rP/anvsqD8RdGqErVpCIXr5PQyOvGj8GhtHyAJdhLCh9tvWLCjmmgreUTPBJer/M=
Received: by 10.66.248.5 with SMTP id v5mr11285821ugh.1166729808315;
        Thu, 21 Dec 2006 11:36:48 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id 30sm14546301ugf.2006.12.21.11.36.45;
        Thu, 21 Dec 2006 11:36:46 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8
In-Reply-To: <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35083>

> I do not think we want to change the commit header
Can you please explain why not ?

>  (1) git-am should default to -u; this was suggested on the list
>      long time ago, but is an incompatible change.  v1.5.0 we
>      can afford to be incompatible to make it more usable and
>      safer.
I use git-am rarely so can't comment on this

>  (2) update commit-tree to reject non utf-8 log messages and
>      author/committer names when i18n.commitEncoding is _NOT_
>      set, or set to utf-8.
>
>      Maybe later we can use encoding validation routines for
>      other encodings by checking i18n.commitEncoding, but at the
>      minimum the above would be safe enough for recommended UTF-8
>      only cases.
See the situation:
1. I have utf-8 encoded repo.
2. Somebody clone my repo, try to commit using non-utf-8 encoding, fail and 
change i18n.commitEncoding. When it commits something and ask me to pull.
3. I pull and got non-utf-8 commit message :-)
