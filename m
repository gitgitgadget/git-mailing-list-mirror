From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: Re: git svn's performance on cloning mono's branches/tags...
Date: Fri, 26 Jun 2009 10:59:49 +0100
Message-ID: <3ace41890906260259o3be005fq6be9d0e2c3f9af66@mail.gmail.com>
References: <3ace41890906251739r45b3eae9oe1b7e32886defc0f@mail.gmail.com>
	 <4A445959.6090403@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Jun 26 11:59:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK8Ds-00083U-UD
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 11:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbZFZJ7t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2009 05:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbZFZJ7t
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 05:59:49 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:34721 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbZFZJ7s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2009 05:59:48 -0400
Received: by ewy6 with SMTP id 6so3160143ewy.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 02:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=twJZWupzOPutcUofl2+rkTiVXfpS/Phm9TA74HzhLCc=;
        b=oC1qCgkkO8+9G3aoxFZPeuzjfnRz9yM59SuH/cdfG9A0fzyLnBYR0I9+np84uqpmxP
         DSymsxeHYXpgy+sOsHbQDoSlhWnefdHBU83N6m+21ZdAD/AKe3fuOMdrF5fI6OZO2DpQ
         fxbxIFMB6mc9yTzDPJIrwZi6kXSM0e8yIhlTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tOb0vDULjJ5Q9NiIKNAMOZDk1k24IOhw6ilhIrAoSyM4UhkqzWzkuTjk/8meCqb99G
         +ZwXV2ZY5iDeH1ikZfMVXlc22yuVA5Mv4Lgo9mhQ/jSqs35xoJJeVQVAr4W2VRxTU08t
         rA4d5P+7sPk38TFQeDTn4Pr5EKapsz0a7aHMk=
Received: by 10.216.13.210 with SMTP id b60mr1117425web.97.1246010389664; Fri, 
	26 Jun 2009 02:59:49 -0700 (PDT)
In-Reply-To: <4A445959.6090403@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122286>

On Fri, Jun 26, 2009 at 6:15 AM, Andreas Ericsson<ae@op5.se> wrote:
> Hin-Tak Leung wrote:
>>
>> (I'm not on list so please CC) - I am trying to git svn clone mono's
>> repository, and for some strange reason it is doing a complete check
>> out from revision 1 all the way to each branch/tag . Is this normal =
or
>> am I doing anything wrong? I have git svn clone a few other things
>> recently (R, ghostscript) and I don't remember git doing this, but R
>> is quite a normal svn layout and I think I only have ghostcript trun=
k
>> (no branch/tag).
>>
>> What I did was this: I started out with just git-svn clone trunk
>> (which generated the first two [now-commented out] lines), then I
>> thought I also want 2.4 branch so I added the next commented-out
>> section, and ran 'git svn fetch --all'. Then I thought I like the
>> whole thing - so I commented out most of it and added the 4 lines as
>> blow - which is also my current git config.
>>
>> The problem is that it seems to treat every tag as a branch,
>
> This is normal. SVN makes no real distinction between tags and branch=
es,
> so git-svn has no way of detecting which is which. SVN also allows
> committing to "tags", so it doesn't make sense for git to store what
> SVN calls tags as git tags.
>
> As for your other questions, I don't know.
>
> --
> Andreas Ericsson =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 andreas.ericsson=
@op5.se
> OP5 AB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 www.op=
5.se
> Tel: +46 8-230225 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Fax: +46 8-23023=
1
>
> Considering the successes of the wars on alcohol, poverty, drugs and
> terror, I think we should give some serious thought to declaring war
> on peace.
>

I guess my question is two-fold:
1) what is the correct/recommended way of adding tags/branches *after*
already cloning trunk?

2) the current way of cloning svn repository is quite inefficient -
for every tag/branch, it does:
r1 -> rX branch 1
r1 -> rN tag 1
r1 -> rY branch 2
r1 -> rM tag 2
r1 -> rZ branch 3
etc

but I think it is possible to track branches to the point where it
branches off (when 'svn copy' happens), rather than all the way to r1?
And in that sense tags are just very short branches.

The current behavior is quite bandwith consuming for projects with a
long history and lots of tags, like mono...

Hin-Tak
