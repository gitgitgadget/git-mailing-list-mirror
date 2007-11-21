From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 17:44:49 +0100
Message-ID: <8aa486160711210844jf412bb2pd09aa207ff62f08f@mail.gmail.com>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
	 <Pine.LNX.4.64.0711211554370.27959@racer.site>
	 <8aa486160711210815g5a1973c2see28a6263fc56030@mail.gmail.com>
	 <Pine.LNX.4.64.0711211632090.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 21 17:45:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iushf-0006jL-5a
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 17:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756640AbXKUQow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 11:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754372AbXKUQow
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 11:44:52 -0500
Received: from rn-out-0910.google.com ([64.233.170.188]:22756 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753497AbXKUQov (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 11:44:51 -0500
Received: by rn-out-0102.google.com with SMTP id s46so3593546rnb
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 08:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bDVRMJ4RX8nB1JDWI4jbKe/Q08x3ygPVRieiVDgH4Ko=;
        b=bpKa/9o8TZO3pPaRcFTIEB7oidpujQDMrLuoYUxBIgeFPH9+2DRZJcU9bPt6dXkqqVZk0IIg+fq89WBD1Df6unSYox6huG7DDQsAaiiafEZVJb3bYyKVBbOdq10RiJit5BK0R4dzLXuZwsnlpL6sHLGXnolW7NdTz86uYPmB7QI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UJZuFJdvyN9FMJJbripgD5BOe8CcUYtOTVAWUoL0UhsdtVRJ5OV2NJHt4K8ZQlJ9BecCr6ornGCUJ2zhd1K/K77N46VsoC2CwdkWWA4+N683bXsLw8nNjMU3aHq1y31zj2+aWX26d4jmv9cz98AHe/Z9uExBE/+B7Gzeb9dIt2Q=
Received: by 10.151.13.7 with SMTP id q7mr1345402ybi.1195663489992;
        Wed, 21 Nov 2007 08:44:49 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Wed, 21 Nov 2007 08:44:49 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711211632090.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65677>

On Nov 21, 2007 5:36 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 21 Nov 2007, Santi B?jar wrote:
>
> > On Nov 21, 2007 4:59 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > > On Wed, 21 Nov 2007, Santi B?jar wrote:
> > >
> > > > 1) git-clone does not accept a bundle file, even if git-fetch does.
> > > > I've made a patch to use git-fetch in git-clone for this.
> > >
> > > This, along with rewriting git-clone as a very thin wrapper over
> > > git-init, -remote and -fetch, is a really low hanging fruit.
> >
> > For the basic/normal mode it can be a very thin wrapper but you have to
> > support --local, --shared, --reference...
>
> That is not all that difficult.

I did not say it was difficult, I said it was not a very thin wrapper.

>
> > > > 2) The bundles created with "git bundle" does not record the HEAD,
> > > > they resolve the symbolic name to a branch name.
> > >
> > > It imitates ls-remote output.
> >
> > No, it does not.
> >
> > With a newly created project with one commit:
> >
> > $ git ls-remote git.git
> > b71992713c17c3a29f9566e1b50e8cf402375faf        HEAD
> > b71992713c17c3a29f9566e1b50e8cf402375faf        refs/heads/master
> >
> > $ git bundle create git.bdl HEAD master
> >
> > $ git bundle list-heads git.bdl
> > b71992713c17c3a29f9566e1b50e8cf402375faf refs/heads/master
> > b71992713c17c3a29f9566e1b50e8cf402375faf refs/heads/master
>
> Ah, I misunderstood.

Maybe because of my non-native english :-)

>  I thought you were expecting that the first line
> would read
>
>         refs/heads/master       HEAD

or

ref: refs/heads/master        HEAD

That would be perfect, but it is a different story.

>
> Alas, this behaviour stems from dwim_ref() returning "refs/heads/master"
> as real ref.
>
> I am not quite sure how to solve this, though.  Let me see what I can come
> up with.

Thank you.

Santi
