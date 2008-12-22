From: "Jean-Baptiste Quenot" <jbq@caraldi.com>
Subject: Re: Git with Hudson
Date: Mon, 22 Dec 2008 10:34:58 +0100
Message-ID: <ae63f8b50812220134ibcc400fs4bf29a02828c60d3@mail.gmail.com>
References: <D2F0F023-862A-4BAB-88B9-BFEFC5592D10@strakersoftware.com>
	 <20081218160734.b1992eb8.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 10:36:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEhDC-0001jy-1u
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 10:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbYLVJfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 04:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbYLVJfB
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 04:35:01 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:16721 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbYLVJfA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 04:35:00 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1110569fkq.5
        for <git@vger.kernel.org>; Mon, 22 Dec 2008 01:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=Upk4LaFsY0PJC5FY8+KoNCe9ifpwIvp273Nx3rm4mXw=;
        b=ZC4EK2V/9k9mfFpaxiq+nOr6HtRwykAyaSgekbr9SYAmmTeb44vbsSPluev5BFqGUD
         RitN77NqpwzxVOL3JqqIN/xgrgXO4vjS5G5tbpU5GhA67VyDPiqoDtTwGprOBhD4aRyD
         xVowLhsBEtvMTY8lXUjxJOQS50fPYwSm2g4zg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=IaKSezC9HwO08KTqLfNkylXUxxWnsWQE2BJeG+tt7tlS3hBnp1aIigTinLK+aa22Hr
         ILoCSR07OnufephqTLinGTMDO5gZc1G50N8uhKCu7aS1cLVR49wsJ25LOR8q3q4XRUWs
         KxZWceA+P+Gsf1z5f2jQ/4qNyFTWP/ObeaWxw=
Received: by 10.86.79.19 with SMTP id c19mr3520867fgb.66.1229938498832;
        Mon, 22 Dec 2008 01:34:58 -0800 (PST)
Received: by 10.86.95.6 with HTTP; Mon, 22 Dec 2008 01:34:58 -0800 (PST)
In-Reply-To: <20081218160734.b1992eb8.stephen@exigencecorp.com>
Content-Disposition: inline
X-Google-Sender-Auth: b37222048088bdbd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103752>

2008/12/18 Stephen Haberman <stephen@exigencecorp.com>:
>
> We tried using the Hudson git plugin that you can download from the
> Hudson site and ended up with problems--whether we had too many branches
> or something, the plugin has some funny "figure out what needs to be
> built" logic that issued near-constant git rev-list commands. To the
> point where our own "git fetch" calls would get starved for 20-30
> seconds.
>
> We eventually wrote our own Hudson git plugin that is simpler and
> doesn't do any funny rev-listing/walking. It just stores last hash
> built and rebuilds once that doesn't match the branch tip. Once that
> was in place, it worked great.
>
> I've got permission to publish it if you're interested--just haven't
> yet.

Good idea!  I'm also affected by this problem, although the
git-rev-list is not an issue anymore since version 0.5.  Simplifying
the checkout() is still in my plans though, so your contribution comes
at the right moment.  Once the code will be made available we'll be
able to take the best of the two Git plugins and merge them into one.

WDYT?
-- 
Jean-Baptiste Quenot
http://jbq.caraldi.com/
