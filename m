From: Grzegorz Kossakowski <grek@tuffmail.com>
Subject: Re: git-mergetool changes file rights?
Date: Sat, 07 Mar 2009 20:54:44 +0100
Message-ID: <49B2D104.80708@tuffmail.com>
References: <49B298FA.2050803@tuffmail.com> <20090307194821.GA29312@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 20:56:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg2cz-0002rW-QK
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 20:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314AbZCGTyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 14:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbZCGTyk
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 14:54:40 -0500
Received: from mxout-08.mxes.net ([216.86.168.183]:4683 "EHLO
	mxout-08.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043AbZCGTyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 14:54:40 -0500
Received: from [192.168.0.125] (unknown [82.210.157.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTPSA id 87D3AD05AF;
	Sat,  7 Mar 2009 14:54:36 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081227)
In-Reply-To: <20090307194821.GA29312@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112568>

Charles Bailey pisze:
> On Sat, Mar 07, 2009 at 04:55:38PM +0100, Grzegorz Kossakowski wrote:
>> grek@linux-p3yg:~/asf/git/infrastructure/apache-git-mirrors/bin> git mergetool
>> merge tool candidates: kdiff3 kdiff3 tkdiff xxdiff meld gvimdiff opendiff emerge vimdiff
>> Merging the files: email-update.sh
>>
>> Normal merge conflict for 'email-update.sh':
>>   {local}: modified
>>   {remote}: modified
>> Hit return to start merge resolution tool (kdiff3):
>> error: open("bin/email-update.sh"): Permission denied
>> error: unable to index file bin/email-update.sh
>> fatal: updating files failed
> 
> Looking at this sequence of error messages it looks like mergetool ran
> kdiff3 and this 'succeeded', but when mergetool came to 'git add' the
> result of the merge it fell over in a heap because it couldn't read
> the file because of the strange ---x------ permissions.
> 
> mergetool just uses mv to create a backup of the to-be-merged path and
> then uses cp to recreate the original path before invoking kdiff3. I
> haven't managed to get cp to do anything other that use the same mode
> as the source file for a copied file.
> 
> What version of kdiff3 are you using? I ask because this fix looks
> like it may be relevant:
> 
> http://kdiff3.svn.sourceforge.net/viewvc/kdiff3/trunk/kdiff3/src-QT4/fileaccess.cpp?r1=84&r2=96
> 
> The changelog for 0.9.95 includes this:
> 
> - Fixed permissions when writing executable file. (Un*x only)

Hi Charles,

I didn't thought of blaming kdiff3 which seems to be the real guilty for my problems. I'm using 0.9.94 version but I'm
in the process of update.

I'll try that version and report back if it fixes my problem.

Thanks for your help!

-- 
Best regards,
Grzegorz Kossakowski
