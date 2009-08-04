From: Eric Stegemoller <estegemoller@idmcomp.com>
Subject: Re: External Diff Tool
Date: Tue, 04 Aug 2009 10:12:15 -0400
Message-ID: <4A7841BF.5060308@idmcomp.com>
References: <4A70AE1F.7070004@idmcomp.com> <36ca99e90907291345r188a2182n77a2fd5cb55a8bc4@mail.gmail.com> <4A71F2F1.4060605@idmcomp.com> <20090801111227.GA26029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 16:20:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYKsO-0005XS-V4
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 16:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053AbZHDOUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 10:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755479AbZHDOUO
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 10:20:14 -0400
Received: from smtp172.iad.emailsrvr.com ([207.97.245.172]:48240 "EHLO
	smtp172.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433AbZHDOUM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 10:20:12 -0400
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Aug 2009 10:20:12 EDT
Received: from relay17.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay17.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id EF7C81B40F8;
	Tue,  4 Aug 2009 10:12:15 -0400 (EDT)
Received: by relay17.relay.iad.mlsrvr.com (Authenticated sender: estegemoller-AT-idmcomp.com) with ESMTPSA id B54FC1B40C1;
	Tue,  4 Aug 2009 10:12:15 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090801111227.GA26029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124790>

David Aguilar wrote:
> On Thu, Jul 30, 2009 at 03:22:25PM -0400, Eric Stegemoller wrote:
>   
>> Bert Wesarg wrote:
>>     
>>> On Wed, Jul 29, 2009 at 22:16, Eric Stegemoller<estegemoller@idmcomp.com> wrote:
>>>   
>>>       
>>>> Hello,
>>>>
>>>>  git config --global diff.tool TestTool
>>>>  git config --global difftool.TestTool.cmd ""c:/TestTool/test.exe" "$LOCAL"
>>>>         
>>> Try with quoting the " inside the config value:
>>>
>>>   git config --global difftool.TestTool.cmd "\"c:/TestTool/test.exe\"
>>> \"$LOCAL\" \"$REMOTE\""
>>>   Bert
>>>   
>>>       
>> Thanks, but this did not solve it. Interestingly, I have captured the  
>> command line that is sent out by GIT and it is calling the correct  
>> program but not adding anything to the command line. So, nothing is  
>> there. Seeing this I have been experimenting around with the parameters  
>> and I still it is calling the correct program but sending a blank  
>> command line. Any suggestions on how to pursue this?
>>
>> Eric
>>     
>
>
> I think shell is to blame here.
>
> Try editing ~/.gitconfig by hand.
>
> I think the suggestion above forgot to escape the $ character.
>
> Since the $'s weren't escaped, the shell interpolated the
> $LOCAL, etc. variables and replaced them with the empty
> string.
>
>
>   
Escaping the $'s did the trick! Thanks for everyones help.

Thanks,
Eric
