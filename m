From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: quick bare clones taking longer?
Date: Thu, 10 May 2007 10:56:50 +0200
Organization: eudaptics software gmbh
Message-ID: <4642DE52.F9F0A5B2@eudaptics.com>
References: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net>
		<20070509.150256.59469756.davem@davemloft.net>
		<7v3b25siwk.fsf@assigned-by-dhcp.cox.net>
		<20070509.162301.48802460.davem@davemloft.net>
		<7vy7jxr35a.fsf@assigned-by-dhcp.cox.net>
		<7vd519r10c.fsf@assigned-by-dhcp.cox.net> <vpqtzul3xzm.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 10:57:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm4SY-0005KX-Ju
	for gcvg-git@gmane.org; Thu, 10 May 2007 10:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757555AbXEJI4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 04:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756672AbXEJI4s
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 04:56:48 -0400
Received: from main.gmane.org ([80.91.229.2]:37897 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757555AbXEJI4r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 04:56:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hm4S2-0003Nx-SV
	for git@vger.kernel.org; Thu, 10 May 2007 10:56:42 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 May 2007 10:56:42 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 May 2007 10:56:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46851>

Matthieu Moy wrote:
> 
> Junio C Hamano <junkio@cox.net> writes:
> 
> >  get_repo_base() {
> > -     (cd "$1" && (cd .git ; pwd)) 2> /dev/null
> > +     (
> > +             cd "`/bin/pwd`" &&
> > +             cd "$1" &&
> > +             (
> > +                     cd .git
> > +                     pwd
> > +             )
> > +     ) 2>/dev/null
> >  }
> 
> Will this work on windows?

Yes. As does the alternative that uses cd -P. MinGW uses bash (3.1
here).

-- Hannes
