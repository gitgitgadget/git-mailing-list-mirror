From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Publishing "filtered branch repositories" - workflow / recommendations?
Date: Thu, 5 Dec 2013 17:06:14 -0500
Message-ID: <CACPiFCJ3mkOj=E+siideBpPfgS1tSicVQ46KqPK+Tha0DbkZHw@mail.gmail.com>
References: <CACPiFCJPq0fqOQrJD-8CHH405Xw61ZDynqqfN+_aZb3ZBgV2VA@mail.gmail.com>
 <52A0D199.1010403@web.de> <CACPiFCKHprB_oO_eXMYkey_CGbT7WOn5VDDjBdHbLRzcDpHnZw@mail.gmail.com>
 <52A0D9F5.3030101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 05 23:06:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Voh4D-0006Xg-6D
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 23:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654Ab3LEWGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 17:06:37 -0500
Received: from mail-vc0-f169.google.com ([209.85.220.169]:44430 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab3LEWGg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 17:06:36 -0500
Received: by mail-vc0-f169.google.com with SMTP id hu19so14081119vcb.28
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 14:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=auAiP2C1g3BXO3f0aC8pru4amsAPPVrv09zw/yXTZs8=;
        b=b3L3DdFdbBtohbMWA6n+IUuNR+mNwPiHi8ZfLPqQ8MF+rbIA2cWuxai/660bBlo1YK
         erqoR2SRuN8sxU0LmQGQGxBD8deI/1xlCmAm1o1MbA84A1HGknkL3XjNEauYgfQH3ngj
         g+O1OI/SEBXRWiL/LxJmzmNvBta3ik+JCz9rnQ093daIAEw3azJ/IjXLd1n6lrttQIz4
         0YvjXkMuatEirwaGQgPuCitYl3FurRABKKMkcZRU5uoYG5CNtIsuv5I0Y5sxp3UYBWtt
         KaUL7YuLntvlWbLVoTsVGZdXuZuI5j/s0ZD4AO9AMv58N12SVWPC9TUil2yg6fYBWfl+
         5aQg==
X-Received: by 10.52.241.105 with SMTP id wh9mr135421vdc.83.1386281195083;
 Thu, 05 Dec 2013 14:06:35 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Thu, 5 Dec 2013 14:06:14 -0800 (PST)
In-Reply-To: <52A0D9F5.3030101@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238915>

On Thu, Dec 5, 2013 at 2:54 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 05.12.2013 20:27, schrieb Martin Langhoff:
>> On Thu, Dec 5, 2013 at 2:18 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> Without knowing more I can't think of a reason why submodules should
>>> not suit your use case (but you'd have to script branching and tagging
>>> yourself until these commands learn to recurse into submodules too).
>>
>> The submodules feature is way too fiddly and has abundant gotchas.
>
> Care to explain what bothers you the most? Being one of the people
> improving submodules I'm really interested in hearing more about that.

Very glad to hear submodules is getting TLC! I have other scenarios at
$dayjob where I may need submodules, so happy happy.

I may be unaware of recent improvements, here's my (perhaps outdated) list

 - git clone does not clone existing submodules by default. An ideal
workflow assumes that the user wants a fully usable checkout.

 - git pull does not fetch&update all submodules (assuming a trivial
"tracking repos" scenario)

 - git push does not warn if you forgot to push commits in the submodule

there's possibly a few others that I've forgotten. The main issue is
that things that are conceptually simple (clone, git pull with no
local changes) are very fiddly. Our new developers, testers and
support folks hurt themselves with it plenty.

I don't mind complex scenarios being complex to handle. If you hit a
nasty merge conflict in your submodule, and that's gnarly to resolve,
that's not a showstopper.


While writing this email, I reviewed Documentation/git-submodule.txt
in git master, and it does seem to have grown some new options. I
wonder if there is a tutorial with an example workflow anywhere
showing the current level of usability. My hope is actually for some
bits of automagic default behaviors to help things along (rather than
new options)...

Early git was very pedantic, and over time it learned some DWIMery.
You're giving me hope that similar smarts might have grown in around
submodule support ...

cheers,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
