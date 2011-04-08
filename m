From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Fri, 8 Apr 2011 23:23:29 +0200
Message-ID: <BANLkTi=3LPRzohnZStAogddpL5ZLehb97Q@mail.gmail.com>
References: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com>
 <Pine.BSM.4.64L.1104071923580.4692@herc.mirbsd.org> <BANLkTink-c8JuxnMBCAmXiVwFkBxJrTucw@mail.gmail.com>
 <4D9EDCEA.9010903@drmicha.warpmail.net> <20110408185924.GA25840@elie>
 <Pine.BSM.4.64L.1104081903550.22999@herc.mirbsd.org> <20110408194548.GA26094@elie>
 <Pine.BSM.4.64L.1104081955490.22999@herc.mirbsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>
To: Thorsten Glaser <tg@mirbsd.de>
X-From: git-owner@vger.kernel.org Fri Apr 08 23:24:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8J9o-0003o7-JB
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 23:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453Ab1DHVXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 17:23:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54238 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab1DHVXu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 17:23:50 -0400
Received: by iwn34 with SMTP id 34so3825481iwn.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 14:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=46KUMgUpBAabgzxyBlzQgCA8kdCL3lQvXKfpkkgzZCc=;
        b=S8ilzOVq+aPD2k3J1lN7dqNS91jgJjvbYig1ktEyVaQ2CmV5h42HCNbb9sAwmx8Bz8
         qUgZcWrcZhXdHp0mbc6ed7/3XhiXtOK5NdmD0L378c18hL9YH1rDycf52dRgLEFZUDie
         NSCMBArAPkEkddZe7/K2+kzkrRWHS+LRtc3ig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=EBWIEdC3QpZgWsTYKR99ZvmPKFCU9n6LorSqEnULSbWtjcDLe+KFISbgwoGQBE/xpL
         y2Eq+evAbBPjmKtg72gjVS9wEyhM/djEC466Xqgs3R+Y0vIEKbfEo0aChb3Ats6kc5qK
         u2QjMzAy57rXCXq1P5Z9xTreMiWbjshMsLUSQ=
Received: by 10.231.121.1 with SMTP id f1mr2693562ibr.35.1302297829061; Fri,
 08 Apr 2011 14:23:49 -0700 (PDT)
Received: by 10.231.92.16 with HTTP; Fri, 8 Apr 2011 14:23:29 -0700 (PDT)
In-Reply-To: <Pine.BSM.4.64L.1104081955490.22999@herc.mirbsd.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171164>

Ignoring any potentially flame-ish comments in the shared interest of
factual discussion and eventual consensus followed by progress; please
do the same :)


On Fri, Apr 8, 2011 at 21:58, Thorsten Glaser <tg@mirbsd.de> wrote:

> This might be an alternative. RichiH, what are the requirements?

The main use case from my/our POV is to track mtime etc to maintain
relative and absolute differences which can be extremely useful for
data even if it's not needed for code files.


> I fear that the dotfile way will meet them better, considering
> that they are versioned together, not separately, and what you
> told me quickly about the idea.

Points to consider:

* In most cases I can think of, it would be preferable to track
changes in metadata along with the actual files.

* It should be possible for other repositories to ignore this metadata.

* I am not sure if notes are suitable for this. Using notes.displayRef
to hide those notes is an option, but it would force everyone to set
this up locally. Else, it would be very spammy.

* .gitattributes is too important to fill with potentially thousands
of lines, imo. Using it to define what metadata should be stored would
make sense, though.

* would a .gitmetadata make sense for storage? Alternatively, a
.git/objects/??/*.metadata per object could make sense.


Thoughts?
Richard
