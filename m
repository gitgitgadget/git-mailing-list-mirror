From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/2] Update the bash prompt from 'applied' instead of the obsolete 'current'
Date: Tue, 22 May 2007 13:11:13 +0100
Message-ID: <b0943d9e0705220511u2b3ed46fg220af2cce26fef96@mail.gmail.com>
References: <20070520204627.GR19253@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070520211103.17468.21373.stgit@lathund.dewire.com>
	 <20070521074838.GA32510@diana.vm.bytemark.co.uk>
	 <b0943d9e0705210231j75ef2e57o922f7899f4b5814b@mail.gmail.com>
	 <20070521101540.GB32510@diana.vm.bytemark.co.uk>
	 <20070521113915.GA3090@diana.vm.bytemark.co.uk>
	 <b0943d9e0705210817n35e50a6bgb519b693984b3a4b@mail.gmail.com>
	 <20070521153952.GB6474@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Robin Rosenberg" <robin.rosenberg@dewire.com>, ydirson@altern.org,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue May 22 14:11:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqTD0-0000nY-Ly
	for gcvg-git@gmane.org; Tue, 22 May 2007 14:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbXEVMLR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 May 2007 08:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755687AbXEVMLR
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 08:11:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:19540 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755760AbXEVMLQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2007 08:11:16 -0400
Received: by ug-out-1314.google.com with SMTP id 44so257723uga
        for <git@vger.kernel.org>; Tue, 22 May 2007 05:11:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HpqxtbIl2vDCWSi6AGidIf73AkfjYtjFpXTaurbgclhUfX7rClHr5hG5jUcX/XO2GXoc61OutYj6ttPzKsHbKmKwOjBE8T2fzIhf/K4EDPQuL/53749AFdF06Y6gQw889XGOy0yvWi3N3KwkPJshNQ4zIyASyp4G96hKLIzKJEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IYGhtz9AgqQZKos1jXXGyg2MkaDjNjzyvcXpJqL9nvR/BVJEGJTxMhxHZelPc/+0tDjvo6aN9s06iCBhxCJkRQyx8YZ9/g7Y59WL2sdwTYrknlg24/hk/AZUMl/irhHAej4QU5STvpfb3V2Ik5H6X3LVNIwHC6NqPb6vesKpfnk=
Received: by 10.78.124.9 with SMTP id w9mr1393116huc.1179835873808;
        Tue, 22 May 2007 05:11:13 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Tue, 22 May 2007 05:11:13 -0700 (PDT)
In-Reply-To: <20070521153952.GB6474@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48096>

On 21/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> My suggestion was to have a small stand-alone C program that could do
> some operations that need to be really fast, such as
> top/applied/unapplied. It need not have a nice user interface since
> it's only going to be called by scripts (bash-completion and the
> like), and it should only handle those operations that _must- avoid
> the Python startup penalty. And for sanity reasons, it should share
> code with stgit.

There is one more case to consider - people using NFS-mounted
directories. The applied/unapplied commands would be even slower and
the language overhead be negligible.

Another workaround would be to always generate the applied/unapplied
files when the stack structure changes.

--=20
Catalin
