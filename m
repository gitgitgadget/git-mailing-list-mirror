From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] push: --follow-tag
Date: Tue, 05 Mar 2013 12:49:57 +0100
Message-ID: <5135DBE5.6080909@alum.mit.edu>
References: <7vd2vewu24.fsf@alter.siamese.dyndns.org> <7v6216wtrk.fsf@alter.siamese.dyndns.org> <20130305082204.GB13552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 05 12:50:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCqO7-0001EL-TT
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 12:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab3CELuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 06:50:03 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:54064 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752809Ab3CELuB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Mar 2013 06:50:01 -0500
X-AuditID: 1207440c-b7ff06d0000008f7-b9-5135dbe869d7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id C8.5D.02295.8EBD5315; Tue,  5 Mar 2013 06:50:00 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r25BnvcO018915
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 5 Mar 2013 06:49:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <20130305082204.GB13552@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqPvitmmgQecbFYuuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3BmHZr5nKejirvi19TBTA+MH
	ji5GTg4JAROJ+zsusEPYYhIX7q1n62Lk4hASuMwoMXV2BxOEc4xJ4sOsxawgVbwC2hJbFm4E
	s1kEVCWeNy9mA7HZBHQlFvU0M4HYogJhEi+X7GCDqBeUODnzCQuILSIgK/H98EZGEJtZwFpi
	xevDYPXCQDOf3L/CArGsj1Fi+/FPYM2cQEV7Xr0GOo8DqEFdYv08IYheeYntb+cwT2AUmIVk
	xSyEqllIqhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXUy80s0UtNKd3ECAldnh2M39bJ
	HGIU4GBU4uFlOWoSKMSaWFZcmXuIUZKDSUmU9+ZN00AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxK
	IrwLjgDleFMSK6tSi/JhUtIcLErivKpL1P2EBNITS1KzU1MLUotgsjIcHEoSvDtvATUKFqWm
	p1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEgyI1vhgYqyApHqC9i0HaeYsLEnOBohCtpxh1
	OXa/e/SCUYglLz8vVUqcdw1IkQBIUUZpHtwKWKJ6xSgO9LEw7wGQKh5gkoOb9ApoCRPQEo9Q
	E5AlJYkIKakGxpwnp99NZ5lxZfWrFnVZlrz0FcqtZbn9f35M63u/lf9UzFyjKZf95zxprxW8
	8O/yzY/q7Mv+emvdYToXXbqib4JnTIzradkzG+fuuc0i0ZfRN/9MmsvfFXobZrtY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217445>

On 03/05/2013 09:22 AM, Jeff King wrote:
> On Mon, Mar 04, 2013 at 04:54:39PM -0800, Junio C Hamano wrote:
> [...]
> This will find anything under refs/tags, including annotated and
> non-annotated tags. I wonder if it is worth making a distinction. In
> many workflows, unannotated tags should not be leaked out to public
> repos. But because this feature finds any reachable tags, it will push a
> tag you made a long time ago as a bookmarker on some part of the history
> unrelated to the release you are making now.
> 
> One obvious alternative is only to push annotated tags with this
> feature. That has the downside of not matching fetch's behavior, as well
> as withholding the feature from people whose workflow uses only
> unannotated tags.
> 
> Another alternative would be to change the inclusion rule from
> "reachable" to "points at the tip of something being sent". But then we
> lose the feature that it would backfill any old tags the remote happens
> to be missing.

I have no opinion on this matter, but ISTM that another obvious
alternative would be to push tags that point at *any* commits that are
being sent (not just at the tip), but not those that point to older
commits already known to the server.  This would reduce the potential
for accidental pushes of "distant" tags.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
