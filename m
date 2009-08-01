From: David Aguilar <davvid@gmail.com>
Subject: Re: External Diff Tool
Date: Sat, 1 Aug 2009 04:12:28 -0700
Message-ID: <20090801111227.GA26029@gmail.com>
References: <4A70AE1F.7070004@idmcomp.com> <36ca99e90907291345r188a2182n77a2fd5cb55a8bc4@mail.gmail.com> <4A71F2F1.4060605@idmcomp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Eric Stegemoller <estegemoller@idmcomp.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 13:12:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXCW1-0007pV-Mi
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 13:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbZHALMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 07:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbZHALMa
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 07:12:30 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:62862 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbZHALM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 07:12:29 -0400
Received: by wa-out-1112.google.com with SMTP id j5so405710wah.21
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 04:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6I3EdiQEf0hL8zJn4SfPqNLYqmSCDUd8f5MAH30nBKY=;
        b=TpVN9B17rJ2gxIJvaUyy9B4dKBhJy+VauhPDiWOsHt+Tx2hsoKXACkWwrhFSPx3aj9
         4AgAk6MxUy45CKzIY8joOEIMvZgF1YCk6+gmCprapmldWcCOxeCe+BDIC6QLAXyZLxm0
         VCq87kxm79zCxmDI6GydsB0EpAZoUOQqdetiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dRh7tSWuk5TB6Dd8PXYXw/955RB332HQ5PIMAFhFFQ5djQMpy7lxy2nVK6Qt2FT+uJ
         JcqQrH7FXR3+282Naow3rCfiXQyN1ooms4hM0hiAvZvvxKseUWeCbWqGRdd716j/mdx0
         9bsvdZ9YAYttoUTAZpHeaTHBejrANBB8hRPis=
Received: by 10.115.18.10 with SMTP id v10mr4104630wai.170.1249125149837;
        Sat, 01 Aug 2009 04:12:29 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id d20sm7046548waa.47.2009.08.01.04.12.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 04:12:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A71F2F1.4060605@idmcomp.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124617>

On Thu, Jul 30, 2009 at 03:22:25PM -0400, Eric Stegemoller wrote:
> Bert Wesarg wrote:
>> On Wed, Jul 29, 2009 at 22:16, Eric Stegemoller<estegemoller@idmcomp.com> wrote:
>>   
>>> Hello,
>>>
>>>  git config --global diff.tool TestTool
>>>  git config --global difftool.TestTool.cmd ""c:/TestTool/test.exe" "$LOCAL"
>> Try with quoting the " inside the config value:
>>
>>   git config --global difftool.TestTool.cmd "\"c:/TestTool/test.exe\"
>> \"$LOCAL\" \"$REMOTE\""
>>   Bert
>>   
> Thanks, but this did not solve it. Interestingly, I have captured the  
> command line that is sent out by GIT and it is calling the correct  
> program but not adding anything to the command line. So, nothing is  
> there. Seeing this I have been experimenting around with the parameters  
> and I still it is calling the correct program but sending a blank  
> command line. Any suggestions on how to pursue this?
>
> Eric


I think shell is to blame here.

Try editing ~/.gitconfig by hand.

I think the suggestion above forgot to escape the $ character.

Since the $'s weren't escaped, the shell interpolated the
$LOCAL, etc. variables and replaced them with the empty
string.


-- 

	David
