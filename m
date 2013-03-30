From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bug in "git rev-parse --verify"
Date: Sat, 30 Mar 2013 06:29:40 +0100
Message-ID: <51567844.7030503@alum.mit.edu>
References: <51543FDB.9010109@alum.mit.edu> <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com> <515462FB.9040605@alum.mit.edu> <20130328153808.GB3337@sigill.intra.peff.net> <7vli97v558.fsf@alter.siamese.dyndns.org> <51565F96.1020203@alum.mit.edu> <7vk3opr0ke.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <junio@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 30 06:30:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULoMn-0000uC-Iq
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 06:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab3C3F3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 01:29:46 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:54408 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750714Ab3C3F3p (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Mar 2013 01:29:45 -0400
X-AuditID: 12074413-b7f226d000000902-35-5156784822ab
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 55.22.02306.84876515; Sat, 30 Mar 2013 01:29:44 -0400 (EDT)
Received: from [192.168.69.140] (p57A2472C.dip.t-dialin.net [87.162.71.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2U5TfpF022175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 30 Mar 2013 01:29:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <7vk3opr0ke.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqOtRERZocGOCnEXXlW4mi4beK8wW
	K6bcY7H40dLD7MDi8ax3D6PHxUvKHp83yQUwR3HbJCWWlAVnpufp2yVwZ1xY0cFSMIel4v/P
	bawNjLuYuxg5OSQETCQm3t/CCGGLSVy4t56ti5GLQ0jgMqPEjo872CGc00wSV1buZ+pi5ODg
	FdCW6L4YA2KyCKhK/H2eD9LLJqArsainmQnEFhUIk9h7YRobiM0rIChxcuYTFhBbREBNYmLb
	ITCbWaBA4s32b2A3CAvoSBzv6QCLCwlsYpJofMADYnMKmEk8XnGKEaJeR+Jd3wNmCFteYvvb
	OcwTGAVmIVkxC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmuvlZpbopaaUbmKE
	hLDwDsZdJ+UOMQpwMCrx8EqsCg0UYk0sK67MPcQoycGkJMrrVhIWKMSXlJ9SmZFYnBFfVJqT
	WnyIUYKDWUmEV34FUDlvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYJX
	rRxoqGBRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoTuOLgZEKkuIB2qsL0s5bXJCY
	CxSFaD3FqMvRtejzK0Yhlrz8vFQpcV5mkCIBkKKM0jy4FbCE9YpRHOhjYV5bkCoeYLKDm/QK
	aAkT0JLlX4NBlpQkIqSkGhjns/Xpzkn82uusbZ55ImO3CVOs1y1htpmyWbfm59xclZzVu3JN
	2222nIXLMt8taqp89+pOiaTgM7blO7o2vmt3FWtvc2XpmWSzoYVV0n9C5MXnT+44 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219556>

On 03/30/2013 05:09 AM, Junio C Hamano wrote:
> So why not verify arguments while making sure of their type early
> with 'rev-parse --verify "$userinput^{desiredtype}"?

Yes, that's a better solution in almost all cases.  Thanks for the tip.

(It doesn't change my opinion that the documentation for "rev-parse
--verify" is misleading, but given that you don't appear to want to
change its behavior I will submit a documentation patch.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
