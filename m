From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Navigating remote branches in qgit
Date: Sun, 4 Feb 2007 10:28:19 +0100
Message-ID: <e5bfff550702040128o6283b4f3m91debc45ec6b151@mail.gmail.com>
References: <1170574889.21644.38.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 10:28:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDdfe-00044c-Cg
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 10:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbXBDJ2V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 04:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbXBDJ2V
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 04:28:21 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:60650 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbXBDJ2U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 04:28:20 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1327531nze
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 01:28:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PQrpkRSEhpPRIua7Cq/nkqdw55q4S2YeEsIqY+YTikEsKxqDeRLwCBJjwr0y1Sxe1QOXwx4hDRFx6f1AtRWIV+jVCJhSGA+zqyqsVDgESPxVl4ElwVERFda585lsfZ7ljlB/l7n/UH0+F8dNSp7iL+YNAGd10NmzAo/meNkBfrc=
Received: by 10.114.111.1 with SMTP id j1mr506181wac.1170581299034;
        Sun, 04 Feb 2007 01:28:19 -0800 (PST)
Received: by 10.114.61.6 with HTTP; Sun, 4 Feb 2007 01:28:19 -0800 (PST)
In-Reply-To: <1170574889.21644.38.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38669>

Hello Pavel,

>
> Remote refs should recognized and be shown in a new color.  gitk uses
> orange (#ffddaa) on the left and green on the right.  I think qgit
> should use orange for the whole rectangle and drop "remotes/" in
> addition to "refs/", since the color will imply it.
>

I will post a quick patch, just to get the idea.

>
> It would be nice to have a refs browser that would show both loaded and
> non-loaded refs, but I realize that it's not a quick fix type of change.
>

Well, perhaps is not so hard, we already have

Git::getAllRefNames(uint mask, bool onlyLoaded)

that seems to fit. First parameter 'mask' could have following or-ed flags:

	enum RefType {
		TAG        = 1,
		BRANCH     = 2,
		RMT_BRANCH = 4,
		CUR_BRANCH = 8,
		REF        = 16,
		APPLIED    = 32,
		UN_APPLIED = 64,
		ANY_REF    = 127
	};


> Please feel free to ask for help with testing and design of the
> weirdness indicator :)
>

It should be great :-)

Marco

P.S: Grouped menu items patch will follow :-)
