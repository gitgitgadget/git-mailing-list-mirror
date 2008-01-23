From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 20:39:06 +0300
Message-ID: <37fcd2780801230939q6d30488bwc78eaeb9eb01989f@mail.gmail.com>
References: <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org>
	 <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
	 <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
	 <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
	 <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org>
	 <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
	 <20080123094052.GB6969@glandium.org>
	 <769D0E1A-8399-458B-8328-FF3642D833BC@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mike Hommey" <mh@glandium.org>, "Theodore Tso" <tytso@mit.edu>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 18:40:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHjam-0002A6-JQ
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 18:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757926AbYAWRjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 12:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756482AbYAWRjM
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 12:39:12 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:53112 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757926AbYAWRjK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 12:39:10 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1736102wxd.4
        for <git@vger.kernel.org>; Wed, 23 Jan 2008 09:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=c8U11OqSwq+HiX4JAyaj7QXkX/YxVwTLydeN0Ww3JW4=;
        b=sF6ZJYcF0JVovtg/xcwMJMFBSc6vHh21ggjMkBb95NeA+w/wl9OOg0zH066bi3tbYsL5EVc8XmLt14XtTqYsx08BewfpGHXFs03ombdhN2bZIGRkbCO5ZJXatb6oubQ76RDOWm0wfhQ7pCU72CIQKOWzP9wTxZZhB3/FJdZUuDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rs0+wDlaDO/Ouz7Ykhaqc+kdFcLCZaklQaWY+KAsWBoUln4f/qnapuVml1HD7zS8neobb8ka+lKjBjn0zIDkduPXNEd00RJWduvwX2vqWAAkp/M11cnbbB5JPD8x10VyQwB7iJMbuel79cvbqqRO3tyIbpCsFw0MvJ/rMK2H5rY=
Received: by 10.142.246.8 with SMTP id t8mr5080526wfh.220.1201109946843;
        Wed, 23 Jan 2008 09:39:06 -0800 (PST)
Received: by 10.143.157.20 with HTTP; Wed, 23 Jan 2008 09:39:06 -0800 (PST)
In-Reply-To: <769D0E1A-8399-458B-8328-FF3642D833BC@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71563>

On Jan 23, 2008 7:58 PM, Kevin Ballard <kevin@sb.org> wrote:
> On Jan 23, 2008, at 4:40 AM, Mike Hommey wrote:
> >
> > That's the point. It's stored in NFC, but what applications see is
> > NFD.
>
> I was actually asking for you to show this instead of just asserting
> it, but I realized I have access to an SMB share myself so I just
> tested.
>
> And you're right. That's very curious. I guess they did that because
> the entire Carbon stack was written assuming NFD (back at the same
> time HFS+ was created), and they wanted to provide a consistent
> interface to applications.

Wait, did you tell us some time ago that normalization does not
matter and you just need to treat strings "as text"? Now, it looks
like the Carbon stack does not treat strings "as text". How come?

Maybe, you should stop lying and admit that changing Unicode
strings does matter even if they remain equivalent.

> Since the filesystem already uses NFC,
> renormalizing to NFD shouldn't lose anything (want the original
> representation back? just normalize back to NFC).

On Windows, you can create two *different* files -- one with NFC
and the other with NFD name. I wonder, how it is going to work
with your renormalization back and force.

Dmitry
