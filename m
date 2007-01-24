From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Remote git-describe ?
Date: Wed, 24 Jan 2007 14:01:11 +0100
Message-ID: <8aa486160701240501t3f6919b0tcd19da131a196dbb@mail.gmail.com>
References: <38b2ab8a0701240231v5ec4acfasd838ececb316500d@mail.gmail.com>
	 <Pine.LNX.4.63.0701241201410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <38b2ab8a0701240313w64c2df57w2542b63eba2294e0@mail.gmail.com>
	 <7vps94fweq.fsf@assigned-by-dhcp.cox.net>
	 <7vlkjsfvro.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 24 14:01:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9hkc-00071v-7s
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 14:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbXAXNBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 08:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbXAXNBP
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 08:01:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:36999 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbXAXNBO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 08:01:14 -0500
Received: by ug-out-1314.google.com with SMTP id 44so157567uga
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 05:01:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XKOohrUdS5mh4qN8y7v8HSMfaZy59thKGrFjB5fJH5IeUe0kFGr7LyIk9RtU7jruZ39JjaYQPcnKVmbDOUT6UWXhxFeN+lZuVvYHtOiZA9ZxkA7OzFg+7NGRsXcBat3lslLPE6HeJKbWRwNwIdxUS13w/hfNgcvp7MAMglOHynk=
Received: by 10.82.120.15 with SMTP id s15mr163898buc.1169643671919;
        Wed, 24 Jan 2007 05:01:11 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Wed, 24 Jan 2007 05:01:11 -0800 (PST)
In-Reply-To: <7vlkjsfvro.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37635>

On 1/24/07, Junio C Hamano <junkio@cox.net> wrote:
> Also the commit object names (hence "describe" output) do not
> tell you how far they are from the tag used to describe them.
>
> However, I suspect that we could do better with Shawn's new
> fangled describe implementation that actually counts the
> distance between what is described and the tag.  We could add
> "number of commits since the tag" somewhere, to describe:
>
>         v2.6.20-rc5-256-g419dd83
>         v2.6.20-rc5-217-gde14569
>
> to say that the first one has 256 commits accumulated since the
> given tag "v2.6.20-rc5" and the second one has only 217
> commits, to get the sense of how busy the development activity
> is.
>
> Is it useful?  That is something I am not sure.

I find it usefull. I even suggested it in November:
http://marc.theaimsgroup.com/?l=git&m=116246596012422&w=2

Quote:
One problem I see with this scheme (either 'g', 'git' of '+') is that
it does not provide an increasing version number, even for
fast-forwarding commits. Then it is not useful as a package version
number (deb or rpm). I've already seen deb packages with
version+git20061010.
End Quote:

The "either 'g',..." was something it that thread, but applies to the
current scheme.

Santi

>
> Side note for side note.
>
> This should be obvious to people who know git, but the above
> does not mean we can remove gXXXX part from the describe output,
> becauses there could be infinite number of commits that are 256
> commits away from v2.6.20-rc5 tag.  v2.6.20-rc5-256 alone does
> not uniquely identify the commit 419dd83.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
