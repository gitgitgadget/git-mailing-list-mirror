From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Rebasing stgit stacks
Date: Mon, 22 Jan 2007 23:12:05 +0000
Message-ID: <b0943d9e0701221512g377b26b9rf6eabdcdd24853ff@mail.gmail.com>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com>
	 <200701191040.17476.jnareb@gmail.com>
	 <20070120131716.GA4684@nan92-1-81-57-214-146.fbx.proxad.net>
	 <200701202016.16333.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Yann Dirson" <ydirson@altern.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 00:12:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H98Kl-0000Oa-4j
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 00:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbXAVXMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 18:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbXAVXMI
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 18:12:08 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:65273 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbXAVXMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 18:12:07 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1050734nze
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 15:12:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MLTmQYgbLKPoVoAxGJrd4RJGKizFpMW6sk+sySBMubB3/KCX89AzXDVoX8n4mElpIo/phiVghu5sv82vxvxHRSBMh9e8qZ7N1uYp6TtpcC6v9oyt9m2cMnAwL4uxmk3BjVgs6jawW+9dKWnSNjyNRrrCzP9eiRFp1k9XQJXbz2k=
Received: by 10.65.154.10 with SMTP id g10mr8536264qbo.1169507525733;
        Mon, 22 Jan 2007 15:12:05 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Mon, 22 Jan 2007 15:12:05 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200701202016.16333.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37467>

On 20/01/07, Jakub Narebski <jnareb@gmail.com> wrote:
> Well, I haven't thought this through. I was thinking about situation
> where there are no applied patches, and some commits were done without
> StGIT (pure git), i.e. we had
>
>                   ..1...2...3  <-- unapplied (deck) [ branch ]
>                  /
>     a---b---c---d   <-- HEAD [ branch ]
>
> There were some git commits (for example fetch, or cherry-pick, or ...)
>
>
>                   ..1...2...3  <-- unapplied (deck) [ branch ]
>                  /
>     a---b---c---d---e---f   <-- HEAD [ branch ]
>
> And after "stg rebase" I want to have:
>
>
>                           ..1...2...3  <-- unapplied (deck) [ branch ]
>                          /
>     a---b---c---d---e---f   <-- HEAD [ branch ]

StGIT currently doesn't care whether the base of an empty stack has
changed. To get to the above graph, just use "stg push 1..3" and "stg
pop 1..3".

The unapplied patches may be disconnected from the current graph and
StGIT doesn't care about them until pushed (applied) on top of the
stack when they become part of the linear history graph. I'm not good
at ASCII graphics to show an example but, for example, as long as they
are unapplied, 1 above can have b as a parent and 2 can have e as a
parent (it all depends on when they were last pushed).

-- 
Catalin
