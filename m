From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH 2/2] Re: Makefile: remove unused CURL_SYNONYMS variable
Date: Sat, 12 Sep 2009 07:52:54 +0200
Message-ID: <20090912055254.GA4752@vidovic>
References: <dd26f211fbc91046a861748d0463c9e4d06dbb4e.1252731038.git.nicolas.s.dev@gmx.fr> <fa00d720361eb3c449ebb1c937ec7b9b4f9b4452.1252731038.git.nicolas.s.dev@gmx.fr> <7vd45wloj4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 07:53:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmLXl-0007zE-F0
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 07:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159AbZILFw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 01:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbZILFw4
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 01:52:56 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:62729 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbZILFwz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 01:52:55 -0400
Received: by ewy2 with SMTP id 2so1650903ewy.17
        for <git@vger.kernel.org>; Fri, 11 Sep 2009 22:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=jRptM4LUg9ARe/zfFnbH5YDKqrXdq2UwAGRIKtMA+Nc=;
        b=ndJIviy9RC5747I6QO16YhVQp0p+3M4+dEM3BpIS9dYIKPGO7sWOlNwm4TGC7Rn4vK
         azeL8miY48xL5Ny+09vyW7iN6mMBXGyVSzamDw+NjLadHNjZQGcGLx21ihbfeLUU6M/5
         bjmvJ4Q4OjgiKDyAlRnHV0dqfxlGIs3p2jyAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kE6Gjto+MrPNF/UASvhtcF2Z/hOhZFjhsMmxW1xAsLNVLnz84j8CFz8yQeNb0D1Siv
         iq2nossdHzUbv6JqMl9f2w8TXFtsr9X+1de2+Z53nmwe3cJVSmUAQOK616ZRC1SEY5tX
         08YqHvdO+ilNcDbx9Nv3V7azAmti9/O/CmTSM=
Received: by 10.211.132.3 with SMTP id j3mr497409ebn.54.1252734778326;
        Fri, 11 Sep 2009 22:52:58 -0700 (PDT)
Received: from @ (91-165-134-53.rev.libertysurf.net [91.165.134.53])
        by mx.google.com with ESMTPS id 5sm1158858eyf.10.2009.09.11.22.52.56
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 11 Sep 2009 22:52:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vd45wloj4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128239>

The 11/09/09, Junio C Hamano wrote:
> 
> This looks wrong.  What's filtering out of what?
> 
> I think you meant to finish the revert of ad17f01 (Makefile: install
> hardlinks for git-remote-<scheme> supported by libcurl if possible,
> 2009-08-07) that c9e388b (Make the "traditionally-supported" URLs a
> special case, 2009-09-03) attempted to do but missed.
> 
> Perhaps you meant to do this?
> 
> diff --git a/Makefile b/Makefile
> index 8c44e35..1ac02d1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1655,7 +1655,7 @@ export gitexec_instdir
>  install: all
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) $(filter-out $(CURL_SYNONYMS), $(ALL_PROGRAMS)) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> +	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archive$X git-shell$X git-cvsserver '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
>  ifndef NO_PERL

Yes, exactly. Sorry for the mistake.

Oh, and I just saw that my sendemail.cc configuration has been ignored
resulting in not cc'ing the mailing list (fixed for this mail). I guess
it comes from some --cc options added at command line. Shouldn't --cc
add new cc to the cc list instead of override sendemail.cc?

-- 
Nicolas Sebrecht
