From: "Elijah Newren" <newren@gmail.com>
Subject: Re: git-cvsimport bug with dates
Date: Sat, 17 Nov 2007 08:39:08 -0700
Message-ID: <51419b2c0711170739p1a2bf6c7g87f615676f72aedf@mail.gmail.com>
References: <51419b2c0711152059q55ced86gd224310c8c4a1851@mail.gmail.com>
	 <7vr6iq207f.fsf@gitster.siamese.dyndns.org>
	 <51419b2c0711160612r1a80bd5o686040f945e8d9c3@mail.gmail.com>
	 <200711171112.23150.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 16:39:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItPlY-0008Os-Ki
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 16:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbXKQPjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 10:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753889AbXKQPjK
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 10:39:10 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:19595 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbXKQPjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 10:39:09 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1379464wah
        for <git@vger.kernel.org>; Sat, 17 Nov 2007 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=beH4itVEWntJuVyeb6nhAxbGfEG7WG4qolAmZ6LlXng=;
        b=ugfw852GHTNDGaC3t9t1FWUMeuvHwP76jZ6VCc6Qe9Qd2yd3kS6EIgpHclxQG6AcinGqEHEMavS0pWdNXy3Mt0dGw8E+f4ypPzcfq55gW5qS5e81J6/Q+R+MorFwPOAYVlbkzCVhgbI2+979GDCGc79lKtP2cArA4wULEgC4PE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a4JJm9ma3Te9/bi6Z27zJ2+BRUBT6wM5OfIyOoQnTi0h3fElGE1mUss76LLZvLs6L78+QoKtEeEfyaXKAlKDJ3Fa/PX7onBlocgdHzCKjDeKwZUOazXNRYM+5whitac3H9QLZ20Oi4Z/kzhDjS68qwXd/z2zHDhNeQ0xJ3/tuag=
Received: by 10.115.46.9 with SMTP id y9mr884150waj.1195313948227;
        Sat, 17 Nov 2007 07:39:08 -0800 (PST)
Received: by 10.114.211.8 with HTTP; Sat, 17 Nov 2007 07:39:08 -0800 (PST)
In-Reply-To: <200711171112.23150.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65284>

On Nov 17, 2007 3:12 AM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> fredag 16 november 2007 skrev Elijah Newren:
>
> > On Nov 15, 2007 11:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > > When you use "branch@{date}" notation, you are not asking a
> > > question on the project history, but a question on the local
> > > view from _your_ repository on that project.
> >
> > Interesting; that makes sense from a merge or pull viewpoint, but
> > wouldn't it make more sense to have cvsimport ensure the commits are
> > treated as though they actually existed in master as of the date
> > specified in CVS?
>
> Reflog do not work that way. They don't say when a commit entered a repo,
> only when a ref changed. For a CVS import things could work as you suggest
> but I think the confusion among newcomers would be massive if people start
> using reflogs  'as if' it said anyting about when a commit entered. It can be used
> as a hint.

Okay...so I guess my suggestion could be translated as: don't worry
about when the commit entered; instead make git-cvsimport mark the
refs as changed as of the CVS date mentioned instead of as of the
import time.

I guess there would be reluctance to do this whenever git-cvsimport
would be used for incremental commits on a repository that also had
local commits?  Sounds like the issue is deeper than I first realized
and this probably isn't worth the effort it'd take.

Thanks for the explanations.

Elijah
