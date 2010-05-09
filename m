From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: [PATCH v2 0/2] clone: simplify progress message
Date: Sun, 09 May 2010 16:10:57 -0700
Message-ID: <4BE74101.20900@pcharlan.com>
References: <4BE60E89.8010709@pcharlan.com> <20100509110221.GA16639@coredump.intra.peff.net> <4BE7166A.5030107@pcharlan.com> <7vr5lk90yg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 10 01:11:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBFeM-0006vw-7s
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 01:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab0EIXK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 19:10:59 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:43605 "EHLO
	swarthymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753458Ab0EIXK7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 19:10:59 -0400
Received: from [192.168.0.119] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	by swarthymail-a2.g.dreamhost.com (Postfix) with ESMTP id 67B24EE6D8;
	Sun,  9 May 2010 16:10:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <7vr5lk90yg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146754>

On 05/09/2010 03:15 PM, Junio C Hamano wrote:
> Pete Harlan <pgit@pcharlan.com> writes:
> 
>> On 05/09/2010 04:02 AM, Jeff King wrote:
>>> On Sat, May 08, 2010 at 06:23:21PM -0700, Pete Harlan wrote:
>>> 
>>>> "git clone foo bar" currently reports "Cloning into
>>>> /path/to/bar/.git".  Change this message to "Cloning into bar" to more
>>>> closely match the user's expectation.
>>> 
>>> I am a little torn on this. For most users, it is just another
>>> implementation detail that makes git's output more confusing. And it is
>>> likely to be the very first git message seen by many people. But at the
>>> same time, it is telling you where the repository actually is, which is
>>> something that can help users learn about how git works.
>>> 
>>> I guess it comes down to how much detail we want to show.
>>
>> For me it isn't only a matter of detail; I find "Cloning into
>> bar/.git" misleading, since bar is getting more than a .git directory.
> 
> That is also misleading, as cloning is done into bar/.git and everything
> else happens locally as part of the checkout.
> 
> I didn't want to go into nitpicky details, but you asked for it ;-)

Fair enough :)

>> Pete Harlan (2):
>>   clone: have progress report mention top level dir, not git dir
>>   clone: add bare clone to the progress message
> 
> I think the squashing these two into one patch makes quite a lot of
> sense.  Does any of the existing test need adjustments, by the way?

No, the test (t5601-clone.sh) looks for "Clon", so the new message
passes that just as well.

I could add a new test that ensures that "bare repository" shows up in
the message when --bare is passed if you think that's worthwhile.

--Pete
