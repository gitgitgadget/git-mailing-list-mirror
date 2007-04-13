From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFD] Strange patch formats (aka tricks with unified diffs)..
Date: Fri, 13 Apr 2007 19:01:14 +1200
Message-ID: <46a038f90704130001u4161f309k7bb98bb4801ef04a@mail.gmail.com>
References: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
	 <17951.6252.457936.428919@cargo.ozlabs.ibm.com>
	 <46a038f90704122307i76f96029n75425410bc40ad82@mail.gmail.com>
	 <7v3b34hjdh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Paul Mackerras" <paulus@samba.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 09:01:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcFmZ-0007SP-Qk
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 09:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbXDMHBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 03:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbXDMHBQ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 03:01:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:10091 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbXDMHBP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 03:01:15 -0400
Received: by wx-out-0506.google.com with SMTP id h31so794725wxd
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 00:01:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=feFDy5C7XgjtCVxDtMUD0tGpLtfZAApQanTelCL+1EIZMz5FFx+Bqbka1hy4Ua5WIk8ALXaq1Lr3uF9w80qTqv+0l/M041PugkW1hUliLI+ApmRSV69JxdfCOlWV75Z9pPoztEAOTHc3VzwHkBjzlo8AHdEyBwW9tR61Cna1EXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tQWQPevdUAee+NLrhUiQPPxCHs5zzXajK5eCh9qBeCe6vdRuiM3axVTFt/jbGTQ/pjA2vfCYs9GxMWz0i1TJK8M0SMmKZwuevIgRChPzp+vV767HAuymvZbyy5BDTpeUGuQ9IMYLP+lZSlCVNUi7IVH5A91maF/V7GOMKbus9ZM=
Received: by 10.90.65.11 with SMTP id n11mr2736063aga.1176447674544;
        Fri, 13 Apr 2007 00:01:14 -0700 (PDT)
Received: by 10.90.120.11 with HTTP; Fri, 13 Apr 2007 00:01:14 -0700 (PDT)
In-Reply-To: <7v3b34hjdh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44391>

On 4/13/07, Junio C Hamano <junkio@cox.net> wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
>
> > On 4/13/07, Paul Mackerras <paulus@samba.org> wrote:
> >> Side-by-side would be more challenging.
> >
> > <wish>If someone gets started on side-by-side, I'd love to have
> > char-level diff colouring,...
> > icecream too.</wish>
>
> Is it different from the --color-words (whose implementation I
> happen to hate)?

Didn't know about --color-words (goes away, tests...) no, nothing like
that. I don't like --color-words.

To see what I mean, try

   git-show v1.4.4:git-cvsserver.perl  > file1
   git-show v1.5.1:git-cvsserver.perl  > file2
   xxdiff file1 file2

Just press 'n' twice to get to the 2nd "hunk" and you'll see what I
mean. Next is 'n', previous is 'p'. It's useful to visualise subtle
differences, and to spot commonalities in large changes.

Some aspects of xxdiff UI are horrid but this feature... is great.
Probably tries a scan for commonalities from the start and end of the
line. And then perhaps from the middle or from each beginning of alpha
char sequence.

cheers,


m
