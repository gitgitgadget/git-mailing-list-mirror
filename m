From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: 'git status' is not read-only fs friendly
Date: Fri, 9 Feb 2007 21:35:17 +0100
Message-ID: <e5bfff550702091235x74e44362gad5b9b6076a5ea53@mail.gmail.com>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	 <Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org>
	 <7vr6szt71j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"GIT list" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 09 21:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFcSt-00013b-Ky
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 21:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992803AbXBIUfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 15:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992811AbXBIUfY
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 15:35:24 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:22080 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992803AbXBIUfX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 15:35:23 -0500
Received: by wr-out-0506.google.com with SMTP id i21so1022736wra
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 12:35:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pDHqmeTw13rIFRRKnN7AHTxRtZo61akYROsTtcXER6jOK6poxz/o4zBrguHuFIxiyJW+/fffT0TMSgrOa9eStZx4qS0C6nnNVp2keZ6f1WsyeRTmE89J3/D8R2uW1hv6tFjRTGWLrDPr++8ehLQb1EuWpp1CukMjB7GaSYAZGuo=
Received: by 10.114.193.1 with SMTP id q1mr5306265waf.1171053317310;
        Fri, 09 Feb 2007 12:35:17 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Fri, 9 Feb 2007 12:35:17 -0800 (PST)
In-Reply-To: <7vr6szt71j.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39198>

On 2/9/07, Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > "git status" doesn't "pretend" to write stuff. It really does.
> >
> > You *can* just use "git-runstatus" instead. That's the command that
> > actually does all the heavy lifting. But you can see the difference by
> > doing this:
> >
> >       touch Makefile
> >       git runstatus
> >
> > vs
> >
> >       touch Makefile
> >       git status
> >
> > Notice how the "runstatus" one claims that Makefile is "modified:". That's
> > exactly because it doesn't do the index refresh.
>
> Running refresh internally in runstatus without writing the
> result out _might_ be an option, but that would largely be
> a hack to only help qgit.
>

Yes, I agree.

If I modify qgit in running 'git runstatus' as a fallback in case 'git
status' exits with an error (without checking what kind of error
exactly) could be an acceptable path or could hide subtle
side-effects? I have no the knowledge to answer this by hand.

Thanks
Marco
