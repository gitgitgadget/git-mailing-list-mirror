From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: Interactive rebase with pre-built script?
Date: Thu, 13 Sep 2012 14:08:31 -0400
Message-ID: <5052211F.6060000@sohovfx.com>
References: <alpine.DEB.2.00.1209110725130.8398@ds9.cixit.se> <5050BA90.2010105@sohovfx.com> <alpine.DEB.2.00.1209131431580.20765@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Sep 13 20:31:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCEBj-0000x0-L2
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 20:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089Ab2IMSar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 14:30:47 -0400
Received: from smtp03.beanfield.com ([76.9.193.172]:50251 "EHLO
	smtp03.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab2IMSaq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 14:30:46 -0400
X-Greylist: delayed 1323 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Sep 2012 14:30:46 EDT
X-Spam-Status: No
X-beanfield-mta03-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta03-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta03-MailScanner: Found to be clean
X-beanfield-mta03-MailScanner-ID: 1TCDq5-0009Xx-L7
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta03.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1TCDq5-0009Xx-L7; Thu, 13 Sep 2012 14:08:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <alpine.DEB.2.00.1209131431580.20765@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205405>

On 09/13/2012 09:33 AM, Peter Krefting wrote:
>> But this could potentially be dangerous because if "rebase" fires up 
>> a editor for any other reason (e.g. having a "reword" or "squash" in 
>> your recipe), then the commit message will be messed up. So you need 
>> to make sure your recipe won't trigger any editor except for the recipe.
> Indeed, that's why I don't want to do that. 
Are you expecting to have "reword" or "squash" in your recipe? If not, I 
think you should be safe.
If there's a conflict, then rebase will stop, and next time you run "git 
rebase --continue", your normal editor will be back.
 From your original description, it sounded like you are only doing "pick".

On 09/13/2012 09:33 AM, Peter Krefting wrote:
> Perhaps I should add some switch that would append the contents of a 
> specific file to the prebuild recipe, I guess that should be fairly 
> easy. The question is what to call the switch.
How about calling the switch "--todo"? i.e. "rebase -i --todo my_recipe"
Can we also get some inputs from others on whether adding this switch to 
"rebase -i" is desirable?

On 09/11/2012 11:35 AM, Junio C Hamano wrote:
> Using "git cherry-pick $(git rev-list --reverse .....)" ought to work.
And I assume what Junio suggested doesn't help with your problem? 
Because of the time skewed behavior?
