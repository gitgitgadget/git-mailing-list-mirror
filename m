From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] checkout: implement "-" shortcut name for last
 branch
Date: Fri, 16 Jan 2009 13:31:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901161329490.3586@pacific.mpi-cbg.de>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <1231978322-21228-1-git-send-email-trast@student.ethz.ch> <7vocy8s51o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 13:32:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNnry-0001H1-4J
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 13:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759440AbZAPMat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 07:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757024AbZAPMat
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 07:30:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:46616 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754639AbZAPMas (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 07:30:48 -0500
Received: (qmail invoked by alias); 16 Jan 2009 12:30:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp018) with SMTP; 16 Jan 2009 13:30:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rxaFYzd4rsWkKkWBDRm0p0AsDYsgv1tnNEg+oHF
	OxW4hF+40/Fbkm
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vocy8s51o.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105946>

Hi,

On Thu, 15 Jan 2009, Junio C Hamano wrote:

> I do not see a reason to limit the new notation "where I was" only to 
> "git checkout".  Wouldn't it be handy if you can use the notation as the 
> other branch to merge from, or the commit to rebase on?
> 
> [...]
> 
> Another reason is the one level limitation.  If we do not use LAST_HEAD,
> and instead used HEAD reflog, to get to this information, there is no
> reason we cannot to give an equally easy access to the second from the
> last branch the user was on.
> 
> So I think it is just the matter of coming up with a clever syntax that
> works on reflogs to name the nth last branch we were on and teach that
> syntax to both get_sha1() and resolve_ref().
> 
> With the attached illustration patch,
> 
>      $ git checkout junk
>      $ git chekcout master
>      $ git checkout @{-1}
> 
> will take you back to junk branch.  It probably would serve as a starting
> point, if anybody is interested.

I like it.  Additionaly, we could teach "checkout" that "-" is 
equivalent to "@{-1}", as checkout cannot possibly take stdin, so 
it would not hurt.  Thomas?

Ciao,
Dscho
