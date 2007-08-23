From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 11:55:41 +0100
Message-ID: <e1dab3980708230355x1d5d2febw6814e8f24d745ddd@mail.gmail.com>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
	 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
	 <alpine.LFD.0.999.0708221154150.16727@xanadu.home>
	 <Pine.LNX.4.64.0708221713540.20400@racer.site>
	 <86mywjcwv7.fsf@lola.quinscape.zz>
	 <3f4fd2640708221434i4f5650e0u9adb523742666f40@mail.gmail.com>
	 <Pine.LNX.4.64.0708231006220.20400@racer.site>
	 <20070823102036.GG7267@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Reece Dunn" <msclrhd@googlemail.com>, git@vger.kernel.org
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 23 12:55:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOALu-0000IT-Jw
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 12:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbXHWKzr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 06:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbXHWKzr
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 06:55:47 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:4074 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbXHWKzq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 06:55:46 -0400
Received: by wx-out-0506.google.com with SMTP id h31so435595wxd
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 03:55:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=imW07Ntx7ioTlsxG7m3rUgyZWLsGA5HEFhnPc43t3WMVJzQgUsFitl/BGIcVu5fyI6rG8m6SIMCdCq0kuwU86Nbw8FHUWlYBgVn0V+3qlAhBIgM5HZp5o1m9JOVOw3nCS65Q9TIn74xRYQyuegzFwjyX7K0Q/kEUggOE6ghMrDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YcgwipD3f6pzBg29KdQW/+qdf6VRjrHVX2PSIPaIyEPFYW+6A2zQQtfIvpzg1wCI6mQAF6jq1Cq6MGhapgtU0L33YXASpTs2IGoTryV666UnUBedZYgYeOQELE2ZfzYwbpUmfvHhlVkJ/gRWkDxgJlvKEqRI5LMUOusEF3dNRI8=
Received: by 10.70.32.2 with SMTP id f2mr2865900wxf.1187866542224;
        Thu, 23 Aug 2007 03:55:42 -0700 (PDT)
Received: by 10.70.26.12 with HTTP; Thu, 23 Aug 2007 03:55:41 -0700 (PDT)
In-Reply-To: <20070823102036.GG7267@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56493>

On 8/23/07, Theodore Tso <tytso@mit.edu> wrote:
> (To accomodate those Windows users who for some silly reason refuse to
> install Cygwin, bash, and perl on their Windows development box.  :-)

I know I'm really going to regret entering this discussion but...

_If_ your goal is widening git usage (and you could validly argue it should
stay a system for "code hackers"), the big worry is if you want to
accomodate on projects that you (as an upstanding traditional *nix person)
run where you've pushed for using git and are working with people
who work prefer working on windows and they only want to use your git
as the SCM for and don't care about git beyond that. The scenario goes:

Windows user: "You want me to use your git repo for development.
Ok. Install all those pre-requisites for me if you want me to use SCM
regularly."
...
Windows user: "Git isn't working. Come here and tell me what's wrong?"

*nix person: "Dunno, I've never seen that before. I wonder what's
causing it: is it a git thing I've never seen, is it a bash/Perl-on-Windows
weirdness, is it something implemented not as expected in the cygwin
libraries, is it native Windows behaviour that's actually "right"?
Or is it some mixture of the four? And given that I've never
used cygwin and other tools on windows, I'm ******** if I know...."

Windows user: "That's ok, I don't need to commit in this work-in-progress
so I won't commit until you've solved the problem."

I personally don't care exactly what's used implementing git on non-unix
platforms, but I get nervous as more and more "layers" are added so
it becomes more and more difficult to figure which layer a user problem
is occurring at. If it looks to difficult to "help out with" issues on Windows,
that would be a big enough reason for me not to use git on such projects.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
