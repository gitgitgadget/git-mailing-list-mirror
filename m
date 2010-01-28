From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Questions about branches in git
Date: Thu, 28 Jan 2010 17:13:24 -0500
Message-ID: <76c5b8581001281413v361e4bd8w5a74129c2ce1f05b@mail.gmail.com>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
	 <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com>
	 <69b754db1001281317o69f8c3f9y412a8524407bacbf@mail.gmail.com>
	 <alpine.LFD.2.00.1001281656440.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Linck <mgl@absolute-performance.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Jan 28 23:21:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NacjY-0003Zq-Vh
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 23:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab0A1WU6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 17:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754043Ab0A1WU6
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 17:20:58 -0500
Received: from mail-iw0-f172.google.com ([209.85.223.172]:44980 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab0A1WU5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 17:20:57 -0500
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2010 17:20:57 EST
Received: by iwn2 with SMTP id 2so600693iwn.19
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 14:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tJi1zseNk0l+cBeP30+L/9hc0WySlo/QGMSzmZsXi/Q=;
        b=XERWgaDV5V309bnyL7dPx9eadk4tfxG7j5Dln50Q7NXVeH1Y5QxyIVFG07zzxFkHlF
         4wop6tCRF/7U/b0U5uvcEqIVn+l4e+vYYjs3/TKv02uo5HimpFJ6bDfK+RhGsf5k7EEj
         t1Df21Cz3J0NPMPzhwQwwjNfGTA6pDxPxty8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S4UZM3ZXdLUfjL4F8sbERnSDVn7LYgb3X84nO9/TFuA8VPSwgCoEFTXVCUjHqzUdb1
         YOGosDoLNt5pLZbxwggfRxxwk+1QoUH1YGJZOwDDWDYdSpShx+CtDiIFqR4K37EKOJYA
         Nd+nWFQ80u5jZAyHOnMi+nKIqtQITnd/lfsvQ=
Received: by 10.231.59.75 with SMTP id k11mr5384359ibh.87.1264716804523; Thu, 
	28 Jan 2010 14:13:24 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001281656440.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138280>

I agree with Nicolas here - i was also thinking about using
lightweight tags in this case. If you really, really need to port
changes to multiple branches, tags would show you exactly which
commits you should work with.

git log tag1(branched)..tag2(brnach_ready)

In addition to that i shold say that most of the time branches are
supposed to be created from the latest stable master, i.e. released
code. Each release should be tagged. So, in this case you don't need
to have to have the first tag, as you branching from a tagged commit.
As soon as you have first point, second tag may be not necessary until
you can operate with the last commit. As soon as it is not possible -
you can create lightweight tag.

On Thu, Jan 28, 2010 at 5:04 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
>
> On Thu, 28 Jan 2010, Mike Linck wrote:
>
> > Well, even gitk can't show me the information I'm looking for if th=
e
> > parent branch ended up fast-forwarding to include the changes made =
in
> > the topic branch. =C2=A0As far as I can tell there is *no way* to t=
ell what
> > changes were made in a particular branch after a fast-forward has
> > taken place, which seems to make it hard to organize fixes for
> > specific topics/bugs/tickets.
>
> You should consider using tags in conjunction with your bugs/tickets
> system. =C2=A0The fork point for a bug fix may be tagged, as well as =
the last
> commit representing the bugfix completion (not the merge point though=
).
> This way you can always retrieve the exact set of commits forming up
> that bugfix, regardless if it was merged back into the main branch wi=
th
> a fast forward or not.
>
>
> Nicolas
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
