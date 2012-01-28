From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: BUG 1.7.9: git branch fails to create new branch when --edit-description
 is used
Date: Sat, 28 Jan 2012 07:46:14 +0100
Message-ID: <4F2399B6.8020507@alum.mit.edu>
References: <2443.1327701165@plover.com> <7vr4ykybnl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Jason Dominus <mjd@plover.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 28 07:46:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rr23l-0001re-0U
	for gcvg-git-2@lo.gmane.org; Sat, 28 Jan 2012 07:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402Ab2A1GqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 01:46:22 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:36087 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab2A1GqV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 01:46:21 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDCB7.dip.t-dialin.net [84.190.220.183])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0S6kEvD004889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 28 Jan 2012 07:46:15 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <7vr4ykybnl.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189251>

On 01/28/2012 12:21 AM, Junio C Hamano wrote:
> Mark Jason Dominus <mjd@plover.com> writes:
> 
>> This should work, but doesn't:
>>
>>         % git branch
>>         * master
>>         % git branch  --edit-description  blarf
>>         [Edit description and exit editor normally]
>>         % cat .git/BRANCH_DESCRIPTION 
>>         I like blarf
>>         # Please edit the description for the branch
>>         #   blarf
>>         # Lines starting with '#' will be stripped.
>>         % git branch -a
>>         * master
>>
>> Where is branch blarf?
> 
> You haven't created one in that sequence yet.
> 
> This is more of a documentation bug. 
> 
> As the SYNOPSIS section makes it clear, the '--edit-description' is a
> separate mode from showing (the first group), creating or repointing (the
> second), or renaming (the third).
> 
> After that you should be able to say "git branch blarf" and view its
> description.

Given this design, shouldn't "git branch --edit-description" fail if the
branch doesn't already exist?

Shouldn't it also resolve ambiguous reference names?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
