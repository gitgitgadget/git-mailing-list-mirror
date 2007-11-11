From: bob <kranki@mac.com>
Subject: Re: git packs
Date: Sun, 11 Nov 2007 07:54:01 -0500
Message-ID: <48B406B0-FA9D-4173-B2DF-A01B193E5338@mac.com>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com> <00593593-E943-4DA0-AA9B-FDBB866E7EFB@mac.com> <20071110174559.GA2200@old.davidb.org> <134659C4-BA10-4B9E-9C64-2754A90D93F8@mac.com> <20071111110942.A4013@edi-view2.cisco.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Derek Fawcus <dfawcus@cisco.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 13:54:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrCKg-0002mb-Pl
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 13:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147AbXKKMyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 07:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754131AbXKKMyQ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 07:54:16 -0500
Received: from smtpoutm.mac.com ([17.148.16.79]:56734 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754112AbXKKMyP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 07:54:15 -0500
Received: from mac.com (asmtp004-s [10.150.69.67])
	by smtpoutm.mac.com (Xserve/smtpout016/MantshX 4.0) with ESMTP id lABCs5wP000943;
	Sun, 11 Nov 2007 04:54:05 -0800 (PST)
Received: from [192.168.2.23] (c-66-176-54-4.hsd1.fl.comcast.net [66.176.54.4])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp004/MantshX 4.0) with ESMTP id lABCs2Eq009584
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 11 Nov 2007 04:54:03 -0800 (PST)
In-Reply-To: <20071111110942.A4013@edi-view2.cisco.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64452>

Well, there are actually two problems here.  The first is that
crashreporter crashed trying to create the crash report of
the git failure.  The second was the error in git itself.
Hope that helps.

I am submitting an Apple bugreport on the first and
Nicolas Pitre is probably correct in his fix.  When I
was looking at index-pack.c everything was using 32
bit unsigned and signed number where off_t was
64-bit which is what a stat() would return.  My problem
is that I was not familiar enough with git internals to
figure out the solution.  My review was the first time
that I ever looked at git source.

Thanks, Nicolas

On Nov 11, 2007, at 6:09 AM, Derek Fawcus wrote:

> On Sat, Nov 10, 2007 at 01:01:46PM -0500, bob wrote:
>> It is fairly disappointing as far as indicating the problem.  Here is
>> the entire report since it was so short.
>
>> Error Formulating Crash Report:
>> *** -[NSCFDictionary setObject:forKey:]: attempt to insert nil value
>> (key: VMUSignaturePath)
>
> huh?  The above looks like an ObjC invocation.  Last I checked,   
> git was C.
> So why is that in the frame?
>
> DF
