From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Mon, 17 Dec 2012 22:24:53 -0800
Message-ID: <CANiSa6ioKVo5VHht_5R4YwQOoWK8rXPLVFTqMq8J-jBEe2OaRA@mail.gmail.com>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
	<vpq4nxvusty.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Dec 18 07:25:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkqc4-0005JK-Bi
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 07:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214Ab2LRGYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 01:24:54 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:64500 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab2LRGYx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 01:24:53 -0500
Received: by mail-ie0-f175.google.com with SMTP id qd14so304723ieb.34
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 22:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nm5Bazs1LvAexOfPXRGzPqNi9nWfVTTcMxFyIRsKrPA=;
        b=cHtfavmkaCaxAE+7SaIC/eL8BsuBjjq1W9dR/NgBRVmsg+3HHnDFvWBTp8q9B9wuzg
         6P9rd/9ruk1CPBBWX++XsBu901dHqII2H9oB3sN0OoDXv86ErTYU75NVihyU5nIyc/TG
         QxhePbR15E6Ra7cjJcwJI5PWys8/LRHadgWQV4GseBd1aVsi8apuy0eqeu8YutAb9zTj
         ycvGv4qbF3Fwx9HP7XDL0LkqVGuxq/3Ml0kuxJGCpMEiQnHTmD3JIkoJ4g+E41LDfml2
         kQvSkjZ3E8Ht6DEWsvR2l8yy5ns826/4+vyh77CJFN+tKTJBSsFLDj3yg5DKDwtwPeZ1
         xksA==
Received: by 10.43.124.130 with SMTP id go2mr954755icc.8.1355811893260; Mon,
 17 Dec 2012 22:24:53 -0800 (PST)
Received: by 10.64.91.99 with HTTP; Mon, 17 Dec 2012 22:24:53 -0800 (PST)
In-Reply-To: <vpq4nxvusty.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211736>

On Wed, Nov 23, 2011 at 12:49 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Philippe Vaucher <philippe.vaucher@gmail.com> writes:
>
>> Optional: a new mode would be introduced for consistency:
>> --worktree (or maybe --tree): only updates the worktree but not the index
>
> That would be an alias for "git checkout <rev> -- path", right?

Not quite, in two ways, I think. First, it _would_ update the index,
wouldn't it? Second, "git checkout <rev> -- path" doesn't delete files
that are deleted in <rev> as compared to head.

I'm considering implementing support for an operation that would do
what I expected "git checkout <rev> -- <path>" and "git reset --hard
<rev> -- <path>" to do. I'm currently planning for it to be exactly
"git reset --hard <rev> -- <path>" (which is currently simply not
allowed), but perhaps it would be more natural as an option to
checkout (--also-deleted or something)?
