From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/3] rev-list: Introduce --no-output to avoid /dev/null
	redirects
Date: Fri, 9 Nov 2007 09:12:04 +0100
Message-ID: <20071109081204.GB2794@steel.home>
References: <20071108080052.GB16690@spearce.org> <7vejezx4b2.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 09:12:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqOyW-0005ZX-My
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 09:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbXKIIMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 03:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbXKIIMI
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 03:12:08 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:22802 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbXKIIMH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 03:12:07 -0500
Received: from tigra.home (Fc883.f.strato-dslnet.de [195.4.200.131])
	by post.webmailer.de (mrclete mo23) (RZmta 14.0)
	with ESMTP id I026a8jA96eVHR ; Fri, 9 Nov 2007 09:12:04 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A1887277AE;
	Fri,  9 Nov 2007 09:12:04 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 9E4D456D22; Fri,  9 Nov 2007 09:12:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vejezx4b2.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+cUM8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64140>

Junio C Hamano, Fri, Nov 09, 2007 08:32:01 +0100:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > @@ -640,7 +656,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
> >  		}
> >  	}
> >  
> > -	traverse_commit_list(&revs, show_commit, show_object);
> > +	traverse_commit_list(&revs,
> > +		nooutput ? noshow_commit : show_commit,
> > +		nooutput ? noshow_object : show_object);
> >  
> >  	return 0;
> >  }
> 
> The function names noshow_xxx() looked a bit funny, but I do not
> offhand have better alternatives to offer.

"hide", "skip", "ignore"?
