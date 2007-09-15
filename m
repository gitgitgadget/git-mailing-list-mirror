From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: STG, problem with pop/push of alternative versions of a patch
Date: Sat, 15 Sep 2007 18:31:14 +0100
Message-ID: <b0943d9e0709151031m70b9d03bw4068805e697e97f5@mail.gmail.com>
References: <9e4733910709142049k6dcec6acuf851c21ed6704287@mail.gmail.com>
	 <b0943d9e0709150107o27571446v9bef8e31517777e1@mail.gmail.com>
	 <9e4733910709150725k73bec66bw753c4b3c01244cff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 19:31:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWbUF-0007MH-Dj
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 19:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbXIORbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 13:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbXIORbP
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 13:31:15 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:27860 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbXIORbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 13:31:14 -0400
Received: by rv-out-0910.google.com with SMTP id k20so945461rvb
        for <git@vger.kernel.org>; Sat, 15 Sep 2007 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1Gxyc4DiEd0ImRgVbR0Dc3pRgfH933FmaUWQmOqROCE=;
        b=sz17GNIukk9EV1VB/2cO4q8atMawTLCzWfuBF9BHPOkhla7880P8IUd3xJryXff/w1tW7xIMWSW4bA+FBdo7kpj4ohBMfPljf0JAG37Az2cKIzogFxVKs9+9ymahE4gl+5AphIkEOW9cVhcm+DXVCTax66c4kYrSc5O1t8awxgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bzUHij7Nj0LdBYPRmz5drPq0wlaXFXaNIARRt9H4Cj7ZMSByLr9EtARYQ6LKLpRjLXH9/szsuzlWqfWulettadPiPdAGjBRE+neM5R1c5Su0MH6GafSfy3DkxbBFhvt/4x1xyyce7ZAOC8YpajwZv7nr4YtoiN1J2teJm47h9UA=
Received: by 10.140.207.2 with SMTP id e2mr287277rvg.1189877474332;
        Sat, 15 Sep 2007 10:31:14 -0700 (PDT)
Received: by 10.140.158.1 with HTTP; Sat, 15 Sep 2007 10:31:14 -0700 (PDT)
In-Reply-To: <9e4733910709150725k73bec66bw753c4b3c01244cff@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58265>

On 15/09/2007, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 9/15/07, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > On 15/09/2007, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > I trying to test two different versions of a patch that add files.
> > > These patches create a new directory and add several files. When I pop
> > > a version of the patch the directory and files and not getting
> > > removed. This causes an error when I push the alternative version of
> > > the patch.
> >
> > This shouldn't happen AFAICT (at least for the files, as GIT doesn't
> > care much about directories). What GIT/StGIT version are you using?
> > StGIT simply calls GIT to do the HEAD switch.
>
> I have played around with some more. It is more complicated than the
> simple case I described.  Earlier I noticed a message about applying a
> patch that was empty that shouldn't have been. I checked and the patch
> is indeed empty. The empty patch probably caused the files to be left.
> I had been using hide/unide and reordering with on the patch and had
> encountered a couple errors in stg. I'll try and track down the
> sequence that caused the contents of the patch to be lost.

BTW, you can run 'stg log <patch>' to see how the patch was changed.
It even has a -g option to invoke gitk and see each change.

One way a patch could become empty is if the changes it makes are
already in the repository (in another patch or merged upstream).

-- 
Catalin
