From: Tim Harper <timcharper@gmail.com>
Subject: Re: Making submodules easier to work with (auto-update on checkout or merge, stash & restore submodules)
Date: Wed, 30 Apr 2008 15:37:16 -0600
Message-ID: <EFEF26F9-D5D6-4BAC-9A8F-6D96E45AFAF7@gmail.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com> <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness> <BC221793-3FB5-4249-8E8D-819C1B413592@gmail.com> <32541b130804301331o70310831raf71db7cbb51d507@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 23:38:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrK0B-0000YQ-GA
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 23:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762701AbYD3VhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 17:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762636AbYD3VhW
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 17:37:22 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:64051 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762298AbYD3VhV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 17:37:21 -0400
Received: by wf-out-1314.google.com with SMTP id 28so562626wfc.4
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 14:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=9o88YMDWd7Fy8l/Uc+BdRBKiiBsFQlVCeuW2fSHrhys=;
        b=PRtZ+BUqKn7UignNPYuH1iSE7QuN761vkiWbBrT2wr84+ZTcFpMkfABLpn6247/QmBE+mKDx68wRTmmKfyHoYv0kZRgdK0PEzITZSAW8X/vZp6nRgYwmJaWyFyUDPQvS0OFT/WEysHkBr6m3DvT5EWlEH0cvHwrBwi3miL54L9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=wz9oBPLmUgyRLJWpUu3CfoW3Ap2vp8PVMyomlRCb+TUKUPtMI8KSgDDs2L7ZHMifIMo/7Prk0OB2piS1lf1xsmqf6C/bd3ZaqVe/vgv7iIFz0OiocMSjXYv31x7P4Wgm52KgLMDb7yFEbYyW+E5UVovTz3Iqo5wG1GF3LvSHyco=
Received: by 10.142.171.6 with SMTP id t6mr498388wfe.117.1209591440802;
        Wed, 30 Apr 2008 14:37:20 -0700 (PDT)
Received: from ?10.0.1.193? ( [66.182.89.5])
        by mx.google.com with ESMTPS id 27sm3440188wff.7.2008.04.30.14.37.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Apr 2008 14:37:19 -0700 (PDT)
In-Reply-To: <32541b130804301331o70310831raf71db7cbb51d507@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80874>


On Apr 30, 2008, at 2:31 PM, Avery Pennarun wrote:

> On 4/30/08, Tim Harper <timcharper@gmail.com> wrote:
>>> The problem, of course, is that you can easily have valuable, but
>>> not-tracked, files in there.  Deleting the submodule is therefore no
>>> option.
>>
>> Submodules are not deleted.  They are moved out of the working copy  
>> into a
>> folder in .git.  Therefore, upon changing back to the branch with the
>> submodule, they are restored, without nay a hair on their head lost.
>
> <drool>
>
> Yes!  I'm a little sad that I didn't think of that, because it sounds
> like *exactly* what I want.
>
Glad to hear I'm not the only one who feels that way :)


> What about the following case:
> - submodule matches the super module checkin

?

>
> - make changes to submodule but to *not* commit them

Changes will never be lost, because the submodule is either stashed  
away, working copy and all, or a "checkout" command is issued to  
change the HEAD pointer.  The latter is like changing branches with  
uncommitted code - the changes will either be carried, and possibly  
conflict.
>
> - switch supermodule branches, which should checkout a different  
> submodule

Submodule is automatically changed for you, so changing branches makes  
sure  you always have the "whole project".  Recursion isn't handled at  
the time being, so it only works for 1 level deep.

>
> - submodule checkout causes a conflict with uncommitted files

Oooh - this could be a problem currently, especially if you're not on  
a branch.  If you have to resolve conflicts the way to resolve them is  
to commit, and you can't switch to a branch to commit unless you  
resolve your issues.  In which case, you'll probably want to resolve,  
commit, then create a new branch with your current HEAD, then merge it  
into a branch.  I'll visit that as issues arise.  This is bleeding  
edge experimentation here :)
>
>
> What will/should happen here?  It seems like either the supermodule's
> submodule pointer won't be set properly (ie. git-submodule-update will
> fail, but the supermodule won't be marked as conflicted, thus
> git-commit in the supermodule will commit the wrong submodule
> revision) or else submodule files might have to be lost or something.

This is a good point: I don't believe that submodules have anyway to  
mark the submodule revision as "conflicted".  In order for this  
concept to be handled in its full glory, that will most certainly need  
to be handled.

>
>
> Also, someone earlier asked for a link to your work.  I'd like to see
> it too, as I don't know what a "textmate git bundle" is.  I gather
> textmate is a MacOS X program, but I don't know what that has to do
> with git-submodule :)
>

TextMate is an editor for MacOSX.

Here's a link to the bundle.  It's written in ruby.:
http://github.com/timcharper/git-tmbundle/

What does it have to do with submodules?  It's essentially a "GUI" for  
git.  It provides automation for a lot of common tasks also.  My team  
has a need for submodules, but unfortunately in their current state I  
couldn't recommend it to them, so I "smoothed over" the rough edges by  
automating a lot of the awkwardness.  So far, it's been working well  
for us.

> Thanks,
>
> Avery

Thank you!

Tim
