From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: Apply commits from one branch to another branch (tree structure
 is different)
Date: Fri, 14 Mar 2014 15:18:47 -0400
Message-ID: <CADeaMWpw4gx00QpUJ7u49sQvu7KbhvhH14TMdHXBRXq4wCNDZA@mail.gmail.com>
References: <CAD6G_RTZaaYBP0MrmRYhce2v+A+WwvY=97Do3LoWW-SYzkHM2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Brandon McCaig <bamccaig@gmail.com>
To: Jagan Teki <jagannadh.teki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 20:18:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOXd7-0005lQ-HT
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 20:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905AbaCNTSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 15:18:48 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:48767 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbaCNTSr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 15:18:47 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so3022848pab.22
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 12:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=t7nBP+dVxovH2N9NU6SLjT9cwv+hjsDTyLNM3xrrdVY=;
        b=a9wbZRCBdanuUBXkJL16rM1EKZ7xrN30KowKASCWkoLIdPS6YtB/PTntrztDYJwt7K
         gZWMXiv/Kb9JAbaM4/9wZH7wktpOp/J6e7Wof7akjWN/exD2ioQWmHf0nAh+IpNJzc3D
         fPpUbDTNUiM94hBXh20Mm5KUdJ43irS+MDlprRreEjP9d0cljHmXYT3+85Vw3oifjkmM
         0oSUedRZHfPtSfkFkqm8d1Iv/jqMlAF37DrpxYRXr8qtEicE9lpgSrr7qiVkUPsVs0/C
         NVG8LeCeLjgQEM5MB1aFzcMZUXJhe3POk2pymnWhIexBrg6PdHNTHQqEDP9El6tJl4WI
         E9Jw==
X-Received: by 10.68.201.97 with SMTP id jz1mr10797371pbc.26.1394824727209;
 Fri, 14 Mar 2014 12:18:47 -0700 (PDT)
Received: by 10.68.34.40 with HTTP; Fri, 14 Mar 2014 12:18:47 -0700 (PDT)
In-Reply-To: <CAD6G_RTZaaYBP0MrmRYhce2v+A+WwvY=97Do3LoWW-SYzkHM2g@mail.gmail.com>
X-Google-Sender-Auth: EUcBM9qISfe8Bqd6GZWhFxFupa4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244105>

On Fri, Mar 14, 2014 at 1:39 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> Suppose developer send 10 patches on branch1 where are changes in terms
> of <dir>_<version>/ then I need to apply on my local repo branch1, till now
> is fine then I need to apply same 10 patches on to my branch2 where source
> tree <dir> which is quite question here how can I do.

You might be able to use the subtree option in recursive merge. Try
something like:

    git cherry-pick -X subtree=foo <commit>

This tells git to apply the changes to the "foo" directory in your
current branch (branch2).
