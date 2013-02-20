From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH v3 0/8] Fix GIT_CEILING_DIRECTORIES that contain
 symlinks
Date: Wed, 20 Feb 2013 04:39:38 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1302200427220.3204@dr-wily.mit.edu>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu> <7v7gqkgvxe.fsf@alter.siamese.dyndns.org> <CAJDDKr4ki+NjSeuZpAU6bM=YAQ_3mdHCtawstdCqe9Ewvp=arQ@mail.gmail.com> <508E0FAC.5050600@alum.mit.edu> <51246B31.6000605@mit.edu>
 <7vmwuzzd76.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	David Aguilar <davvid@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	"Lars R. Damerow" <lars@pixar.com>, Jeff King <peff@peff.net>,
	Marc Jordan <marc.jordan@disneyanimation.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 10:45:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U86Ei-0007wt-Be
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 10:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933715Ab3BTJor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 04:44:47 -0500
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:58532 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756797Ab3BTJop (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Feb 2013 04:44:45 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Feb 2013 04:44:45 EST
X-AuditID: 1209190c-b7f046d00000094c-07-512499dfb603
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 59.70.02380.FD994215; Wed, 20 Feb 2013 04:39:43 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id r1K9dg1J024396;
	Wed, 20 Feb 2013 04:39:43 -0500
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id r1K9dd8a028044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 20 Feb 2013 04:39:40 -0500
In-Reply-To: <7vmwuzzd76.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixG6nrnt/pkqgQVuztcWGpWuYLY68ecJs
	0XWlm8miofcKs8WTuXeZLZ5N3shucfSUhUXb1C0sFj9aepgt1r+7yuzA5dHa383m8aa9l9Fj
	56y77B4PX3Wxezzr3cPocWH7SWaPi5eUPT5vkgvgiOKySUnNySxLLdK3S+DK2L9rGltBC2vF
	3WuzWRsYPzJ3MXJySAiYSLy6e5MRwhaTuHBvPVsXIxeHkMA+Rokv82+zQDgbGSUuLPzNBOFs
	Y5JYMe07G0gLi4C2xIp7fWDtbAJqEnM3TGYHsUWA7Ilth1hAbGaBdmaJd28zQWxhAX+JM3vb
	weKcAmYSRzZPAevlFXCQuPXxElhcSGAWk8SOXVEgtqiArsTeQ2fYIWoEJU7OfAI1U0ti+fRt
	LBMYBWYhSc1CklrAyLSKUTYlt0o3NzEzpzg1Wbc4OTEvL7VI11AvN7NELzWldBMjKDI4JXl2
	ML45qHSIUYCDUYmHV2O+cqAQa2JZcWXuIUZJDiYlUV6uaSqBQnxJ+SmVGYnFGfFFpTmpxYcY
	JTiYlUR4f3YA5XhTEiurUovyYVLSHCxK4ryXU276CwmkJ5akZqemFqQWwWRlODiUJHgzZwA1
	ChalpqdWpGXmlCCkmTg4QYbzAA33AKnhLS5IzC3OTIfIn2JUlBLntQFJCIAkMkrz4HphiesV
	ozjQK8K8HSBVPMCkB9f9CmgwE9DgtcuVQQaXJCKkpBoYRSpbmA9lXtnZy7zjxydH+99qE541
	L+q4tyon7XDWvydX045pcORpKxc0uVrPOMduvyVmdqdx1JSJjXceuNvK+2TMm3Xy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216700>

On Tue, 19 Feb 2013, Junio C Hamano wrote:
> Assuming that this says "yes":
> 
> 	D=/afs/athena.mit.edu/user/a/n/andersk/my/dir
>         cd "$D"
>         test "$(/bin/pwd)" = "$D" && echo yes

Correct.

> Perhaps existing of an empty element in the list would do?  E.g.
> 
> 	GIT_CEILING_DIRECTORIES=:/afs/athena.mit.edu/users/a/n/andesk
> 
> or something like that.  And in such a case, we do not run realpath on 
> the elements on the list before comparing them with what we get from 
> getcwd(3).

That seems reasonable, and has the advantage of backwards compatibility 
with versions before 1.8.1.2, I guess.

Anders
