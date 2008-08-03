From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Sun, 3 Aug 2008 21:33:39 +0400
Message-ID: <20080803173339.GQ7008@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness> <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no> <20080725140142.GB2925@dpotapov.dyndns.org> <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no> <20080729134619.GB7008@dpotapov.dyndns.org> <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no> <80518F08-A9A9-4190-9AC4-D24DD6A1188B@zib.de> <32541b130807301133w4bfc8288oa2d15911b2317dca@mail.gmail.com> <56C07978-D6C9-4219-8B92-6217BD33F6D4@zib.de> <905315640808030954j7487a010p136c73406298ee29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 19:35:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPhU2-0008Tb-4O
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 19:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758003AbYHCRdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 13:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757891AbYHCRdq
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 13:33:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:2831 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757880AbYHCRdp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 13:33:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so846464fgg.17
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 10:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=iSuZcTNzGHi50LSeYgpA6L583E7OYo3/chAmzJID0Wc=;
        b=t2Chujtc4szHtnOI3TYPd8hUQhm3Bp/P+VXDeYytkTP43d0VMQnZUo7m0CbrOgKx+7
         D+CU7arapcedoAjqYyRWp5xtEGry30Kle5DLYocGnmT6eqT/LCoofS+7M+z1L9SykQ3i
         ti99Rsp+yidp+nFkNbjtQTrQ62rbIG0NmPH6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DDAeaXgzYA79D0SDOdmXZ+LM0+1/GEFS/mn+5vY4mk5ive56uovgN9gAWLcFrx8b6L
         zGkdKMY75YLnmQCuNAXRmY+QczcwN/Su1qIUmbyXBpf7p34isuuxlocJ0EUTla+orRdC
         yUq6FRN7v+gsdsnQ7VKeJaaSlALrbZxi+6U10=
Received: by 10.86.80.17 with SMTP id d17mr9587249fgb.24.1217784824173;
        Sun, 03 Aug 2008 10:33:44 -0700 (PDT)
Received: from localhost ( [85.141.237.93])
        by mx.google.com with ESMTPS id 4sm4504523fgg.4.2008.08.03.10.33.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Aug 2008 10:33:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <905315640808030954j7487a010p136c73406298ee29@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91256>

On Sun, Aug 03, 2008 at 09:54:42AM -0700, Tarmigan wrote:
> 
> For all I care, git can consider the files as binary, but by *default*
> I should get back the same as I put in.

Sorry, but Git is a source control system, and by definition the
main focus is on *text* files. Storying binary files is *exception*
not the rule. And the default settings should respect exactly that
fact.

> > For git's
> > autocrlf mechanism to work, a text file is only allowed to have a
> > *single* type of line endings.
> 
> Git's autocrlf mechanism can be a nice feature.  But by default it
> should not be on (even on windows) because it can modify screw up my
> files.
> 
> To be clear: when I say "git checkout" I want to get EXACTLY the same
> bits as went in when I did "git add" and "git commit".  Any other
> default is broken.

You will get exactly the same unless you change your autocrlf settings.
There are very rare situation where automatic heuristic can be wrong,
but even then you will be warned about that the file you are going to
checkout different. See core.safecrlf.

> 
> > Otherwise it is broken and git tries to
> > help you fixing it.
> 
> My files were NOT broken when I put them into git.  I committed them
> known good state.  If msysgit changes them by *default* , then msysgit
> is broken.

Text files committed with CRLF inside of your repository is BROKEN by
definition! So you had BROKEN state in the first place.

Of course, changing the global autocrlf setting should not change
autocrlf settings in already existing repositories, as it currently
does.  Care to provide patch?


Dmitry
