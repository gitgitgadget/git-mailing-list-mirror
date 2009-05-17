From: David Aguilar <davvid@gmail.com>
Subject: Re: What's cooking in git.git (May 2009, #02; Sun, 17)
Date: Sun, 17 May 2009 04:41:43 -0700
Message-ID: <20090517114142.GA25956@gmail.com>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 17 13:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5enl-0007qe-5h
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 13:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbZEQLly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 07:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbZEQLly
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 07:41:54 -0400
Received: from mail-pz0-f115.google.com ([209.85.222.115]:55627 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbZEQLlx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 07:41:53 -0400
Received: by pzk13 with SMTP id 13so1649349pzk.33
        for <git@vger.kernel.org>; Sun, 17 May 2009 04:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZuFBzhe3MeR3BHfKnILia5sVQdKPEGGZKTWA/klX0WM=;
        b=AdGGEmhASDaz9486YsQTAlcOpKzl2ZpFSbi98FsTh/vZhhilGvEGSEi20k0emf6jWS
         9Yx89rQd/oOiyhmi2S5YTQY1+6ZWjBSCHz5MBSFT3DEDpOVfmfmhOpCt91NC+ltzAF2N
         kr0o14ZSC3mwihPnd70Cq8VCy3RBweFVN79xI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OGpaLp8gwjyKP2cteMxzhOC7jFWzLDaG4AVkahB4km9dYlpyHQWTNljC22AtrFc8lS
         7v/GJmNCZLYv7CLdUPjsdtdwrVVxZwPp9hiz8BJ7JaTtYWG0EBhHdtzb3CaRRgNdEP58
         BUXFWAoYvbEhVjwzJDPP3XOPP2FQUiPsy2kpU=
Received: by 10.114.80.18 with SMTP id d18mr8826358wab.147.1242560514413;
        Sun, 17 May 2009 04:41:54 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n6sm3593575wag.4.2009.05.17.04.41.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 May 2009 04:41:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vab5ci281.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119393>

On Sun, May 17, 2009 at 01:05:18AM -0700, Junio C Hamano wrote:
> ----------------------------------------------------------------
> [Actively cooking]
> 
> * da/mergetool-lib (Sat May 2 01:57:21 2009 -0700) 1 commit
>  - mergetool--lib: specialize diff options for emerge and ecmerge
> 
> Can somebody tell me what the current status of this is?  I thought there
> was some objection, but I lost track...

This one was good to go.

The original reporter of the problem w/ emerge was happy with
the patch.  The specialization for ecmerge was also correct.

The objection was about having to translate the ecmerge command
name for mac os x (which the patch doesn't do).  We
settled on not doing it (meaning leave the patch alone
as-is) since it's not customary for os x users to have ecmerge
in their $PATH and thus it's up to them to configure it if
they want it.  The motivation being that we don't want to
start special-casing any platforms.

The patch for araxis was also good (after explaining that the
-title: options don't work correctly which is why the patch
didn't include it).  I can resend again later in case
it got lost.  I also share Dscho's "if it's not free then I
won't touch it" attitude, tho I'm not opposed to helping out
users on under-privileged platforms from time to time.
It seemed like Myagi(?) wasted a lot of time getting araxis
working with msysgit/mergetool so porting the patch to
mergetool--lib felt like the nice thing to do.

-- 

	David
