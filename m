From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 11:45:17 +1300
Message-ID: <46a038f90801211445g2fa65bd6ida8b59882d60bd78@mail.gmail.com>
References: <478E1FED.5010801@web.de>
	 <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
	 <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
	 <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
	 <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
	 <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
	 <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org>
	 <46a038f90801211306g3dd9a167wb74d06e444b18b93@mail.gmail.com>
	 <alpine.LFD.1.00.0801211334540.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Kevin Ballard" <kevin@sb.org>,
	"Peter Karlsson" <peter@softwolves.pp.se>,
	"Mark Junker" <mjscod@web.de>,
	"Pedro Melo" <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 23:45:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH5Oo-0004R0-7f
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 23:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849AbYAUWpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 17:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754422AbYAUWpU
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 17:45:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:59210 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbYAUWpT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 17:45:19 -0500
Received: by ug-out-1314.google.com with SMTP id z38so970859ugc.16
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 14:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=x4iIpNd5JYawwmhudyWukSJAJoKbPqBDCwWB7sOZy1Q=;
        b=pM2cTNkRmCLNbHHdp9i2goEXVL0GkyaiolRJiOllMrp1EGvpcoi2/jexuqvibG7BBJOIVb9dqzogg166T6otnt5E+YdwEXq7IjmkdnuqoOWqCbY23IbD62vx8Cax8ZmvdW9oDEJI0Pztp838tGfDG8XrqoPnbiUN4BDZmG9Rwsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n37saFXEqKtOvNiO7FYsuD3Kb8tVAZINhZWGY25LdkO6mgMzcb4FGKXYrsknxjeAKsb0hOIahRjOpmsq5HrVXi3KaXM4L1gLPbu2Bie5vWB1JYlg7wqMl/XiASxGmz3i9GYVuXSMOvl49xT8lAcMrfHljW03CVgnGqGY/ut5GOI=
Received: by 10.67.15.15 with SMTP id s15mr4211017ugi.27.1200955517388;
        Mon, 21 Jan 2008 14:45:17 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Mon, 21 Jan 2008 14:45:17 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801211334540.2957@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71362>

On Jan 22, 2008 10:42 AM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> I'm praising UTF-8 (without normalization) as a wonderful format where you
> can do 99.9% of everything without ever caring about all the expensive
> stuff.

*thanks* for these notes. Very useful, and...

...
> And then, the (actually relatively few) things that want to do things like
> show things on the screen, or check for equivalence, or worry about width
> of the characters, *those* can still do so.

I find the above amusing -- different worlds we live in. Programming
webapps means that 90% of the code deals with a bit of metaprogramming
(with lots of string manipulation) to talk SQL to a backend, and then
doing lots of string manipulation on the data the DB returns, which
ends up in humongous strings of goop otherwise known as HTML+CSS+JS.
After waiting for the DB to return data, over 50% of cpu time is spent
in regexes, concatenations, counting words, array ops, etc. So it is
pretty significant.

So now I have to worry about cost and correctness of stuff that I took
for granted in the pre-unicode days - strtolower() can be quite
expensive and... buggy! But that's mainly due to Unicode, not UTF8. I
think the only slowdown I can pin on UTF-8 is in counting chars, and
probably slower regexes. Not that I deal with the C implementation of
any of this stuff -- and so happy about it! ;-)

</offtopic>

(...)

> And that's the beauty of non-normalized (and possibly badly formed) UTF-8.

I had a few issues with Perl v5.6's utf-8 handling that wasn't binary
safe (fread() to a fixed-length buffer would break the input if a
unicode char landed across the boundary - ouch!) -- made me think that
you couldn't do this in binary safe ways. So I tend to tell Perl to
treatfiles as binary, and switch to utf-8 in specially chosen spots. I
suspect that 5.8 is a bit saner about this, but I'm not taking
chances.

cheers,


martin
