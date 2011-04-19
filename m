From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: rebasing branch with reverted patches
Date: Tue, 19 Apr 2011 11:39:24 +0200
Message-ID: <BANLkTim_QNFhChme=nxGf1_Dw8LedTS3Ag@mail.gmail.com>
References: <BANLkTim5mf6okFN8V5V+B=Ns1JORD47a5A@mail.gmail.com>
 <4DAD4B0F.9030908@drmicha.warpmail.net> <BANLkTimbSes-B8zK2a2t1Jp1v+29HdNvqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 11:46:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC7Vh-0001xA-Bl
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 11:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828Ab1DSJqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 05:46:12 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:59996 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab1DSJqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 05:46:11 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Apr 2011 05:46:10 EDT
Received: by pzk12 with SMTP id 12so3930609pzk.11
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 02:46:10 -0700 (PDT)
Received: by 10.68.49.169 with SMTP id v9mr2258710pbn.363.1303205984170; Tue,
 19 Apr 2011 02:39:44 -0700 (PDT)
Received: by 10.68.46.134 with HTTP; Tue, 19 Apr 2011 02:39:24 -0700 (PDT)
In-Reply-To: <BANLkTimbSes-B8zK2a2t1Jp1v+29HdNvqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171788>

On Tue, Apr 19, 2011 at 11:09 AM, Francis Moreau <francis.moro@gmail.com> wrote:
> On Tue, Apr 19, 2011 at 10:42 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Francis Moreau venit, vidit, dixit 19.04.2011 09:32:
>>> Hello,
>>>
>>> I'm wondering if it would be a good idea for git rebase to allow not
>>> rebasing reverted patch which are part of the rebased branch.
>>>
>>> For example I'm currently rebasing my branch 'devel' onto master. This
>>> branch have several commits and specially one called A and another one
>>> called A' which reverts A.
>>>
>>> When rebasing 'devel' branch, rebase could try to drop both A and A'.
>>>
>>> What do you think ?
>>>
>>> BTW is there a way to do this currently ?
>>
>> You can do this with "rebase -i" by removing A and A' from the commit
>> list (or squashing them or dealing with them in whatever way you like).
>
> Of course, but my point was to make this automatically...

You can also change the A' commit title to "fixup! original_title"
while reverting (there is no --fixup argument like "git commit" has),
then git rebase -i would reorder the todo file for you.

git revert gets confused by the resulting empty change but you can
"git rebase --continue", or now that both are next to the other just
remove them.

HTH,
Santi
