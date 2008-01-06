From: Rogan Dawes <rogan@dawes.za.net>
Subject: Re: [PATCH] Allow git-mergetool to handle paths with a leading space
Date: Sun, 06 Jan 2008 12:51:41 +0200
Message-ID: <4780B2BD.6020109@dawes.za.net>
References: <47809E7E.2090708@dawes.za.net> <7vodbz5ka9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 11:53:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBT87-0004re-RF
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 11:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbYAFKw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 05:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbYAFKw4
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 05:52:56 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:41372 "EHLO
	spunkymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751480AbYAFKw4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2008 05:52:56 -0500
X-Greylist: delayed 5116 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Jan 2008 05:52:56 EST
Received: from [192.168.201.100] (dsl-243-127-236.telkomadsl.co.za [41.243.127.236])
	by spunkymail-a9.g.dreamhost.com (Postfix) with ESMTP id 09C2D21222;
	Sun,  6 Jan 2008 02:52:52 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7vodbz5ka9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69725>

Junio C Hamano wrote:
> Rogan Dawes <rogan@dawes.za.net> writes:
> 
>> Signed-off-by: Rogan Dawes <rogan@dawes.za.net>
>>
>> ---
>> I am working on a project which has the root directory constructed
>> with a leading space. i.e. ./ dir/. "read" skips the leading space
>> char, and ends up with an incorrect filename, which can then not be
>> found. Setting IFS=\n solves this problem.
> 
> Does the project have a file that has letter 'n' (en) in its name?
> Have you tested your patch while having a conflict in that file?
> 

Yes, it works correctly.

$ git mergetool
merge tool candidates: kdiff3 tkdiff xxdiff meld gvimdiff vimdiff 
opendiff emerge vimdiff
Merging the files: 
webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/BackDoors.java 
webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/BlindSqlInjection.java 
webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/Challenge2Screen.java

Normal merge conflict for ' 
webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/BackDoors.java':
   {local}: modified
   {remote}: modified
Hit return to start merge resolution tool (kdiff3):
merge of 
webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/BackDoors.java 
failed

$

My copy and paste does not show the spaces properly, since everything 
gets wrapped. but the "Normal merge conflict for ' webgoat/" line would 
have taken the ' to the next line if the space was not there. :-)

Note that the lines after "Merging the files" don't include the spaces, 
but that is just cosmetic, IMO.

Rogan
