From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Sat, 21 Jan 2006 18:20:07 +0000
Message-ID: <b0943d9e0601211020k20e2b18fy@mail.gmail.com>
References: <1137144291.20073.104.camel@dv>
	 <b0943d9e0601160018x206faf9ck@mail.gmail.com>
	 <1137517300.20556.26.camel@dv> <20060117215752.GH32585@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>,
	Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Sat Jan 21 19:20:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0NLX-0006uz-LE
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 19:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWAUSUK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 13:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWAUSUK
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 13:20:10 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:15420 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932224AbWAUSUI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 13:20:08 -0500
Received: by xproxy.gmail.com with SMTP id i30so456610wxd
        for <git@vger.kernel.org>; Sat, 21 Jan 2006 10:20:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=syRoVafTEQ+WrNEA8bwiqKQ0EonbgrH954bUafiG+442daG7DrX0D52KglEvx8AScVvrg1pjjiadNNGHU9RtaHoeIG97DVGUwfosZwYMMFufherVn/Mbqk5y1NyagwH8JHcEVab4BYMaixueJXYd0DGef0PlPDYksrJh66m7XEs=
Received: by 10.70.74.19 with SMTP id w19mr3828167wxa;
        Sat, 21 Jan 2006 10:20:07 -0800 (PST)
Received: by 10.70.53.11 with HTTP; Sat, 21 Jan 2006 10:20:07 -0800 (PST)
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060117215752.GH32585@nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14998>

On 17/01/06, Yann Dirson <ydirson@altern.org> wrote:
> It would even be useful sometimes to dispatch changes to a single file
> into several patches.  When they are distinct enough to be in
> different diff hunks, it is pretty easy to split an existing patch,
> but it could also be useful to only refresh a patch with specific diff
> hunks.  A possibility would be to add a filterdiff-like "-#<n>" flag,
> in addition to the above-suggested "refresh <file>" (and possibly only
> allow to specify a single file together with this flag).

Limiting the refresh to a set of file wouldn't be hard but doing it
per hunk it's a bit more complicated because StGIT only handles the
changes to the current tree over to GIT so that a new commit object is
created. It doesn't control the individual hunks.

What I usually do is create a dummy patch from the current changes,
pop it from the stack and only apply parts of it using emacs. Pushing
the dummy patch back would also show what changes were left to merge
in a proper patch.

--
Catalin
