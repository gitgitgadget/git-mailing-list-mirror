From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: BUG 1.7.9: git branch fails to create new branch when --edit-description
 is used
Date: Sun, 29 Jan 2012 11:11:28 +0100
Message-ID: <4F251B50.5080602@alum.mit.edu>
References: <2443.1327701165@plover.com> <7vr4ykybnl.fsf@alter.siamese.dyndns.org> <4F2399B6.8020507@alum.mit.edu> <7vbopoxp5q.fsf@alter.siamese.dyndns.org> <4F24E78A.7060502@alum.mit.edu> <7v39azxb5l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Jason Dominus <mjd@plover.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 29 11:11:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrRjf-00042R-Ax
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 11:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847Ab2A2KLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 05:11:35 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:51078 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab2A2KLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 05:11:34 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDE2E.dip.t-dialin.net [84.190.222.46])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0TABSxo022915
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 29 Jan 2012 11:11:29 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <7v39azxb5l.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189284>

On 01/29/2012 07:42 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 01/28/2012 08:27 AM, Junio C Hamano wrote:
>>>
>>> We could error it out (i.e. you cannot name a thing that does not yet
>>> exist), or we could consider it is a convenience feature that you can
>>> prepare a description even before you create one, or we could even tweak
>>> it more like "-t $name" that tries to work both on existing one (without
>>> changing any base) or non-existing one, creating it while at it. The last
>>> approach historically is the most error prone (we had numerous bugs in the
>>> create_branch() helper after it started allowing an existing branch when
>>> updating the "track" information) and I would rather not go that route if
>>> we can avoid it.
>>>
>>> Honestly speaking, I haven't formed an opinion.
>>
>> I vote for an error.  Otherwise a typo in the branch name would lead to
>> the description's apparent disappearance into Nirvana.  An error would,
>> for example, have made it clear to the OP what was happening.
>>
>> A more useful option might be
>>
>>     git branch --with-description <branchname> [<start-point>]
>>
>> i.e., that a branch's description can be set at the same time as the
>> branch is created.
> 
> So you are saying either option 1 or 3 is preferrable, while I was saying
> I would rather avoid 3 if we could avoid it. Is that the short version?

Not quite.  I agree that "--add-description" should fail if the branch
already exists.  But I was suggesting that there be a new *different*
option that can be used when creating a branch.  "--with-description" is
probably not a great name, but I think it is a good idea that it be
spelled differently than "--add-description".  Perhaps even "--message",
even though the abbreviation "-m" is precluded by the existing "-m" option.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
