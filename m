From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git svn messages
Date: Tue, 25 Aug 2009 18:49:33 -0400
Message-ID: <eaa105840908251549o6d53fe9fnb1dfc00395ad36f4@mail.gmail.com>
References: <43d8ce650908251531n397ba6e1xe71e80d7b8a08344@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 00:50:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg4qO-0003lx-61
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 00:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244AbZHYWtd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2009 18:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753991AbZHYWtc
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 18:49:32 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:60178 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbZHYWtc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Aug 2009 18:49:32 -0400
Received: by ey-out-2122.google.com with SMTP id 25so876496eya.19
        for <git@vger.kernel.org>; Tue, 25 Aug 2009 15:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=dkItjtHbqM76okPwvvY0/uqPsf+OHyQ0ccGhV+kqpRM=;
        b=Az379/9AigifCCdmRn4qhkIwvP6QEoLoCjm5q45ZwmlzQOQHSB0D/5vHtKDgmwwz1u
         EFBoqwxUU1QTrpsRCCNIFmTQpRHnWkgJFceIeftvz+z38bASTGaZapZU6upOWPeefAjY
         JvB+ZI0Go1fmEWbF30p74oZJ3234SeJ4t3dpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=gCG0AJshcz+98GXoKDjCrw9bg+/lpLLSQQN1KC47fnNh5mDur/7WOiA9BrJiesjcLm
         KjoXhFg66Y1dM873davlk16CTiXNiqdE0ELR02rrloTTOd+TZvlk/YbZcOcHrMVaJicu
         7KUVVN5Jm9vORNjhCVqwOaUi3gELT3e2ZNUDA=
Received: by 10.210.137.16 with SMTP id k16mr5939468ebd.16.1251240573424; Tue, 
	25 Aug 2009 15:49:33 -0700 (PDT)
In-Reply-To: <43d8ce650908251531n397ba6e1xe71e80d7b8a08344@mail.gmail.com>
X-Google-Sender-Auth: ecfcd9a41ea0ef07
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127055>

On Tue, Aug 25, 2009 at 6:31 PM, John Tapsell wrote:
> Hi all,
>
> =A0When doing git svn dcommit, the messages that it gives are, well,
> frightening :-)

Some moreso than others, depending on your level of familiarity with gi=
t. :-)

> It's full of things like:
>
>> No changes between current HEAD and refs/remotes/git-svn
>
> No changes? =A0What's gone wrong? =A0Why can't it find any changes?..

Because you aren't working from a branch-point older than your current
refs/remotes/git-svn. I suppose one could misinterpret that as a
bidirectional "no changes". Still, the message doesn't contain a scary
prefix like "Error:" or even "Warning:". It's just informational.

>> Resetting to the latest refs/remotes/git-svn
>
> That doesn't sound good. =A0Why did it have reset?

Because the newly created svn commits are a different DAG from your
former DAG (which contained git commits that weren't in svn yet), even
though the tree contents are the same. The way git-svn tells the rest
of git about this change is by running the "git reset" command.

You can run "gitk" before you run "git svn dcommit", then hit refresh
(F5, I believe) after "git svn dcommit" is done to get a more visual
idea of what is going on.

Peter Harris
