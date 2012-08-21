From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC 0/2] svn-fetch|push - an alternate approach
Date: Tue, 21 Aug 2012 09:06:20 +0200
Message-ID: <5033336C.4050906@alum.mit.edu>
References: <1345311556-70767-1-git-send-email-james@foobar.co.nz> <5030BE33.9000007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "James R. McKaskill" <james@foobar.co.nz>, git@vger.kernel.org
To: Marco Schulze <marco.c.schulze@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 09:13:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3ieb-0004iy-Bn
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 09:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722Ab2HUHN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 03:13:28 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:59582 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753318Ab2HUHN0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2012 03:13:26 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Aug 2012 03:13:26 EDT
X-AuditID: 12074411-b7fa36d0000008cc-5c-50333370894c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id DC.5D.02252.07333305; Tue, 21 Aug 2012 03:06:24 -0400 (EDT)
Received: from [192.168.69.140] (p57A25F8F.dip.t-dialin.net [87.162.95.143])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7L76LVK009090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 21 Aug 2012 03:06:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <5030BE33.9000007@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqFtgbBxgsOWJoEXXlW4mi3X7JC0O
	HdjA6MDscfyGosfOWXfZPT5vkgtgjuK2SUosKQvOTM/Tt0vgzvi71K3gJ0fFrgef2BoY57B3
	MXJySAiYSEztuMYGYYtJXLi3HswWErjMKLFqs3AXIxeQfYZJ4uiBxWAJXgFtidc7GlhBbBYB
	VYnu1tksIDabgK7Eop5mJhBbVCBEYs23KYwQ9YISJ2c+Aarh4BABqrmzgg8kzCzgJHHx7iyw
	EmEBW4mpF4+wgpQICcRLnPimBBLmFNCUOHzkKQtEuY7Eu74HzBC2vMT2t3OYJzAKzEKyYBaS
	sllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXVy80s0UtNKd3ECAlZwR2MM07KHWIU
	4GBU4uF9McUoQIg1say4MvcQoyQHk5IoL6OBcYAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd5q
	faAcb0piZVVqUT5MSpqDRUmcl2+Jup+QQHpiSWp2ampBahFMVoaDQ0mCN94IqFGwKDU9tSIt
	M6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFKPxxcAoBUnxAO0tBWnnLS5IzAWKQrSeYjTm+H/y
	5F1Gjs9PgaQQS15+XqqUOG85SKkASGlGaR7cIliyesUoDvS3MG8aSBUPMNHBzXsFtIoJaNWj
	uQYgq0oSEVJSDYymaZyXf+u9/uT/0HDheuWX/JusZ/6WV/x3ed3ys8mVzbX/HJsUfa93cmSk
	zEszX2S78y6D3LoVXz5I3F3s9VL1uJPmPIY/4nMbn5d+P8m+QSRu6Za1EZb8/YrS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203948>

On 08/19/2012 12:21 PM, Marco Schulze wrote:
> 
> On 18-08-2012 14:39, James R. McKaskill wrote:
>> As a twist the code does not use the svn library, but rather talks the
>> svn protocol directly. I actually found it much easier to go this route
>> then trying to bend everything to how the svn library understands
>> things. It also has the advantage of not depending on libsvn. A number
>> of distributions currently distribute the svn specific parts of git
>> seperately to avoid this dependency.
> It is a bit of a pain to work with libsvn, but I think it is worth using 
> it, not only due to protocol support, but also due to ready-to-use 
> support for SVN deltas and dumps.  Pipelining could be implemented by 
> maintaining a set of connections (svn_ra_session_t structures) and 
> manually distributing work between them.

Using libsvn would also have the benefit of letting the Subversion
project worry about forwards and backwards compatibility if the protocol
ever changes.  (They tend to be quite diligent about that.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
