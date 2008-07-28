From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: New mailmap file for the kernel
Date: Mon, 28 Jul 2008 08:47:53 -0400
Message-ID: <9e4733910807280547w70256962o6f51b48f66cdd0b1@mail.gmail.com>
References: <9e4733910807272145y5b67112er4b90cc36141663c1@mail.gmail.com>
	 <alpine.DEB.1.00.0807281251000.2725@eeepc-johanness>
	 <bd6139dc0807280411k3a283c5dr4b874342aab167dc@mail.gmail.com>
	 <alpine.DEB.1.00.0807281321540.2725@eeepc-johanness>
	 <bd6139dc0807280453rbfc28ffid8314e74cc19b7f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: sverre@rabbelier.nl,
	"Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 14:49:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNS9o-00050t-Ds
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 14:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbYG1Mrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 08:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbYG1Mrz
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 08:47:55 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:8124 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbYG1Mry (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 08:47:54 -0400
Received: by an-out-0708.google.com with SMTP id d40so903325and.103
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 05:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PVEpn5ADmjcrbhJVXl0oU2QrXcXqZ+Kvu2mwp02Ypm4=;
        b=PLBoyNVuW5CPzoquf7W5DefGM5Amjjk6wrziKyXwoWHPe9np+J0des535ypzvy+aV8
         xFy0bM3hBrKhY0aHjsY1nbHWwzjdNFBd7zXt0sPvKW7ANJoX5KaBrnMkTlPs7X1839XR
         k1uQPNzs3dWhLOrgC8F/LVFuJZQoIeWdtgfQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JLaoOup2Sz0rF0J1nJ/kSV4kgH0UCynuQ/lco7uoq9v1IIuX4Q1nMExfI/IwbFvk1r
         PzWrNK+UqQKo8U6ne6266kIGMwIRNhZ9BHdbtaNWJ3Hu+PMJpSlbn0wMQWOV0yAeQHIG
         1QnJfdOm8qt7CqVTcagXpyuvsegRgRM/6fNrc=
Received: by 10.100.165.13 with SMTP id n13mr8248447ane.32.1217249273363;
        Mon, 28 Jul 2008 05:47:53 -0700 (PDT)
Received: by 10.150.205.1 with HTTP; Mon, 28 Jul 2008 05:47:53 -0700 (PDT)
In-Reply-To: <bd6139dc0807280453rbfc28ffid8314e74cc19b7f7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90455>

On 7/28/08, Sverre Rabbelier <alturin@gmail.com> wrote:
> On Mon, Jul 28, 2008 at 13:23, Johannes Schindelin
>
> <Johannes.Schindelin@gmx.de> wrote:
>
> > And how exactly do you plan to make sure everybody has that hook
>  > installed?
>
>
> It needn't be installed with everybody, only at the people that form
>  'upstream' (in the git case that'd be Junio, in the Linux case that'd
>  be Linus and his lieutenants).

That's the idea. The lieutenants would have the hook and stop anything
that introduced new errors into the file. checkpatch.pl would get the
same hook. And we'd make it available to all developers too. Someone
want to help out are write the hook? My hands hurt from editing the
mailmap file for too long.

We really need a hook to start the validation process. Putting all of
the existing names in the file makes it easier to write the hook. I
was surprised that 12% of all names in the log had errors in them.
That's a terrible error rate.

Making sure nothing slips through is not that bad. Use git log to
extract all email addresses. Run a script to ensure that they are all
in the mail map file.Add the missing ones, there should only be a few.
If the commit validation process works there shouldn't be any.

It's not just statistics, what it we had to contact everyone because
of some licensing or patent mess? Mozilla has had to contact everyone
three times now.

Bottom line this is Linus' call. Does he want a validation mechanism
for names and email addresses in the log?


>  > Also, it would be a major hassle, just for the benefits of statistics
>  > (which, funnily enough, not everybody cares about).
>
>
> Hmmm, I'm not sure if it would be a major hassle once it's set up?
>  Once everybody has their name correctly in the mailmap nobody will
>  have to care?
>
>
>  > But we are not truly distributed.  Our community is small enough, and our
>  > maintainer good enough, that we do have a single upstream essentially.  We
>  > do not even have lieutenants through which new developers could come (and
>  > therefore would be old developers once they hit master).
>
>
> Ah, I did not realize that. Thanks for explaining.
>
>  --
>  Cheers,
>
>
>  Sverre Rabbelier
>


-- 
Jon Smirl
jonsmirl@gmail.com
