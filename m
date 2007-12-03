From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Re: git-svn: .git/svn disk usage
Date: Sun, 2 Dec 2007 22:53:08 -0800
Message-ID: <94ccbe710712022253t3b1834bcs9facbf34717c7faa@mail.gmail.com>
References: <65dd6fd50712022217l5f807f31pf3f00d82c3dccf5c@mail.gmail.com>
	 <4753A43F.9060303@obry.net> <20071203064603.GA18583@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Pascal Obry" <pascal@obry.net>, "Ollie Wild" <aaw@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 07:53:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz5BL-0005Xb-K0
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 07:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbXLCGxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 01:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbXLCGxK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 01:53:10 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:58482 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbXLCGxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 01:53:09 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4897561wah
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 22:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=gkTA2emTgyIK4Cu6UqmUDUmnBcRJbpjJwcuyxaRxREg=;
        b=cAH8aTUL3uRZd+DcWnpMBZEEGNXHKV8lK4vDCXYh8UzYPYNNqKj8UREuGK410Um71ofk1PLt0vj4ghzIO3VMqFG3N7txeqQXxa1w1ZXLh5Qcn8PvT+ErdzWee1QUZXHt0NSlvemWKnDNt08w1gZEyxW546Q1pIrj4drV974Pu5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Xqekg9bIUsZ5D12Ci2n7ZlQ93FpkXdSd8Un51Xa4r5kBYkEvzH4mrnmH95o2aDqOoH3zXXAxuHef40MsQzA3Y03J46fpVlfkpbNX3CuewlxmYw+snJd0J1Ul52gkEn1tIDbZZiuxIZF8ugutznhTe69+tZCr/94d0fqcEsCB3Zo=
Received: by 10.114.95.1 with SMTP id s1mr2993913wab.1196664788615;
        Sun, 02 Dec 2007 22:53:08 -0800 (PST)
Received: by 10.114.149.15 with HTTP; Sun, 2 Dec 2007 22:53:08 -0800 (PST)
In-Reply-To: <20071203064603.GA18583@old.davidb.org>
Content-Disposition: inline
X-Google-Sender-Auth: 944887b365d33b89
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66878>

I'm going to have to say this is due to the unhandled.log as well.

Just gzip -9 it (AFAIK it's not used for anything, but keep it just in case).

On Dec 2, 2007 10:46 PM, David Brown <git@davidb.org> wrote:
> On Mon, Dec 03, 2007 at 07:37:51AM +0100, Pascal Obry wrote:
> >Ollie,
> >
> >> I'm curious if other developers have run into this issue.  If so, are
> >> there any proposals / plans for improving the storage of git-svn
> >> metadata?
> >
> >Did you run "git gc" after importing code form the subversion
> >repository? On my side I found that it has reduced drastically the size
> >of the local Git repository.
>
> I think the original poster is probably finding the space in the .git/svn
> directory.  'git-svn' keeps an index file for every branch in SVN.
>
> I suspect it does this for speed, at least on a large import, since the SVN
> commits will come across numerically, affecting the branches out of order.
>
> However, the index could fairly easily be extracted from git (since that is
> what it normally does).  In this case, where all of the indexes take
> significant space if this is worth it.
>
> Ollie, if you look in these svn branch directories, is most of the space
> taken up with files called 'index'?
>
> Browsing through the few svn clones that I have, the space seems to be
> roughly split between 'index' files and 'unhandled.log' files.
>
> Dave
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Kelvie Wong
