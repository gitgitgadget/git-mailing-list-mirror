From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: "git gc" doesn't seem to remove loose objects any more
Date: Mon, 15 Dec 2008 14:38:56 +0100
Message-ID: <237967ef0812150538n671c22b8gaf7a7b5dcaf68433@mail.gmail.com>
References: <808wqhzjl9.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bruce Stephens" <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 14:40:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCDgH-0004Cl-RK
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 14:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbYLONjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 08:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbYLONi7
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 08:38:59 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:30246 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbYLONi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 08:38:59 -0500
Received: by ey-out-2122.google.com with SMTP id 6so373123eyi.37
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 05:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=62KlXsbKm/+Vrg0HTKmAKDkm3b/OHdgJP0q0ES1kCSs=;
        b=WjqvQuc2YK6x6eV9N8XN8co+CiWKXyWd4H4Wx4VuZA/si92dFHIoxultv8C/2yl7lr
         UL1sPWUUBEFYBzQTWhlUKDY+Ag0o/vynygbwqua+dbXlskougc8MkeFpHT6V5PNPYExt
         uiWTMCcGSKcTvzvS0dXC2Rf4xj79KT1gIecxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mDogjKIjsw43IjMqf18xAtQcHMxv9K/VpUsHsEl1gW8J1WkLA0CVN2tUbUQnuGxhku
         YnxTXVGfzbZVUzVJMe4n65bKOjUQ0ob5b547o8Lhkb+VLPB0RGXJpVbDEYi5rn47PoyW
         UBQxoOt9yS66WO62YWGwU5Gis5gVkrJjkxofY=
Received: by 10.210.58.13 with SMTP id g13mr7745542eba.76.1229348336581;
        Mon, 15 Dec 2008 05:38:56 -0800 (PST)
Received: by 10.210.82.6 with HTTP; Mon, 15 Dec 2008 05:38:56 -0800 (PST)
In-Reply-To: <808wqhzjl9.fsf@tiny.isode.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103162>

2008/12/15 Bruce Stephens <bruce.stephens@isode.com>:
> I couldn't see a test for this, but perhaps I'm just missing it?
>
>    brs% git count-objects
>    161 objects, 1552 kilobytes
>    brs% git gc
>    Counting objects: 80621, done.
>    Compressing objects: 100% (22372/22372), done.
>    Writing objects: 100% (80621/80621), done.
>    Total 80621 (delta 57160), reused 80305 (delta 56884)
>    brs% git count-objects
>    207 objects, 2048 kilobytes
>
>
> And I see lots of directories under .git/objects which confirms
> things.
>
> I don't think I've changed any relevant configuration.
>
> This is with 8befc50c49e8a271fd3cd7fb34258fe88d1dfcad (also whatever
> version I used before, erm, probably
> de0db422782ddaf7754ac5b03fdc6dc5de1a9ae4), and possibly earlier
> versions---I've just started noticing now that the number of loose
> objects has started causing git gui to complain.
>
> (Hmm, I note that git gui reports a larger number of loose objects
> than git count-objects.  Ah, OK, it really is just an approximation,
> so no surprise.)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

IIRC git gc only removes loose objects older than two weeks, if you
really want to remove them now, run git prune. But make sure no other
git process can be active when you run it, or it could possibly step
on something.

-- 
Mikael Magnusson
