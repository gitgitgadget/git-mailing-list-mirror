From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bug in "git rev-parse --verify"
Date: Thu, 28 Mar 2013 16:34:19 +0100
Message-ID: <515462FB.9040605@alum.mit.edu>
References: <51543FDB.9010109@alum.mit.edu> <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 16:34:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULEqq-0006ot-U5
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 16:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab3C1PeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 11:34:23 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:62871 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756109Ab3C1PeW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Mar 2013 11:34:22 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-ab-515462fe8000
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 62.43.02295.EF264515; Thu, 28 Mar 2013 11:34:22 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2SFYJTJ026837
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 28 Mar 2013 11:34:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqPsvKSTQ4FIrr0XXlW4mixVT7rFY
	/GjpYXZg9njWu4fR4+IlZY/Pm+QCmKO4bZISS8qCM9Pz9O0SuDN+vH3BWvCQs+JTy0fmBsad
	7F2MnBwSAiYSDZtOsULYYhIX7q1n62Lk4hASuMwosWbafiYI5ziTxNmXbcwgVbwC2hLrrl4F
	62YRUJVY/HA9C4jNJqArsainmQnEFhUIk9h7YRobRL2gxMmZT4BqODhEBFQk+k7FgISZBVwl
	7j+8BVYiLKAjcbynA2yMkECBxNoTK8BsToFAiacLDrCBtDILqEusnycE0Sovsf3tHOYJjAKz
	kCyYhVA1C0nVAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5mSV6qSmlmxghYcuzg/Hb
	OplDjAIcjEo8vDMjQgKFWBPLiitzDzFKcjApifKGJwKF+JLyUyozEosz4otKc1KLDzFKcDAr
	ifA2xQHleFMSK6tSi/JhUtIcLErivKpL1P2EBNITS1KzU1MLUotgsjIcHEoSvEuB8SkkWJSa
	nlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rS+GJgnIKkeID2VoC08xYXJOYCRSFaTzHq
	cnQt+vyKUYglLz8vVUqc1xukSACkKKM0D24FLEm9YhQH+liYdzJIFQ8wwcFNegW0hAloyfKv
	wSBLShIRUlINjIlH2LpNplup8eakpX74wXzgms1t/o4rzfOZZ21scU28vnTz/o2H0i3rGfQt
	+SrCfyzbXqRRvfzkHvOgH1Ebvtyc9/zonK8/bC6ZT5rnfk3IpMMwh7vx3LcFOj8y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219409>

On 03/28/2013 02:48 PM, Junio C Hamano wrote:
> I think it has always been about "is this well formed and we can turn it
> into a raw 20-byte object name?" and never about"does it exist?"

That's surprising.  The man page says

    --verify
        The parameter given must be usable as a single, valid object name.
        Otherwise barf and abort.

"Valid", to me, implies that the parameter should be the name of an
actual object, and this also seems a more useful concept to me and more
consistent with the command's behavior when passed other arguments.


Is there a simple way to verify an object name more strictly and convert
it to an SHA1?  I can only think of solutions that require two commands,
like

    git cat-file -e $ARG && git rev-parse --verify $ARG

I suppose in most contexts where one wants to know whether an object
name is valid, one should also verify that the object has the type that
you expect:

    test X$(git cat-file -t $ARG) = Xcommit &&
        git rev-parse --verify $ARG

or (allowing tag dereferencing)

    git cat-file -e $ARG^{commit} &&
        git rev-parse --verify $ARG^{commit}

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
