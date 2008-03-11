From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: [RFC/PATCH] Fast forward strategies allow, never, and only
Date: Tue, 11 Mar 2008 11:09:22 +0100
Message-ID: <8c5c35580803110309q2474c42q4758d618fca3cea@mail.gmail.com>
References: <20080311093553.23191.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: hvammen@gmail.com, git@vger.kernel.org
To: colin@horizon.com
X-From: git-owner@vger.kernel.org Tue Mar 11 11:11:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ1Qp-0000dA-3p
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 11:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbYCKKJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 06:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752207AbYCKKJX
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 06:09:23 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:3627 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbYCKKJW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 06:09:22 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2767740wah.23
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 03:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=WneeneTjpr85f2OAsu9a4QGnJbdZf1yDzqeCRHtk30c=;
        b=B1/DzGAdPLo7ynQY8gBg9H9sNxja5EQ9z1IXSdENfevMpGGZttCPy+6SoGhLj7hBIQx9S6dnzfnzAJlHAdu82blfAkbRjJ6GMYZI6D5iqXb1aIN77QOPU6MD3MDnz3p+YicuJZM3GYS/YtXydvaO1YkUsDfjojswrKHffVAq8vw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=d78nlIIUHRmowMCX3UJAkYrDNW8M+5h+XuC3l8Wnba9iRJHIE34uhZY636ZCph4AD5MVZ/uOfiKFIpNoNHXd2A4/56KvR/95S+tR4kov+vfd5GPrhR3cPJS1xWGNChCNjurF3NrPq8UYVewOufxy9H8wClge8Lxx+tgpgg/YsUA=
Received: by 10.114.126.1 with SMTP id y1mr4617086wac.41.1205230162495;
        Tue, 11 Mar 2008 03:09:22 -0700 (PDT)
Received: by 10.114.241.8 with HTTP; Tue, 11 Mar 2008 03:09:22 -0700 (PDT)
In-Reply-To: <20080311093553.23191.qmail@science.horizon.com>
Content-Disposition: inline
X-Google-Sender-Auth: 6920a03ea997c273
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76829>

On Tue, Mar 11, 2008 at 10:35 AM,  <colin@horizon.com> wrote:
> > What's lacking is "why this is a good idea".
>
>  Seconded.  A long time ago (and I'm too lazy to find a link), Linus
>  explained why disabling fast-forward merges was almost always a Bad Idea,
>  and nobody has come up with a good reason why you'd want one since.

The reason for --no-ff was twofold:
* theoretical: when you want to record the integration of a topic branch
* practical: when merging git-svn branches in git, git-svn dcommit
would update the wrong svn 'branch' if the merge was a fast-forward

I originally needed --no-ff due to the 'practical' aspects (I used
git-svn when working with the day-job svn repository), but now that
we've switched to git (Hurray!) I'm still using --no-ff for the
'theoretical' reason: our topic branches tend to be named after
bugtracker tickets, so by recording the merge of such a branch we get
a very explicit note in our git log about when each ticket was
resolved.

YMMV.

--
larsh
