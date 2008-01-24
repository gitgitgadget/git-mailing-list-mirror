From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [STGIT PATCH] replace "git repo-config" usage by "git config"
Date: Thu, 24 Jan 2008 15:31:40 +0000
Message-ID: <b0943d9e0801240731q856925al267d81548f5e2091@mail.gmail.com>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com>
	 <200801162147.33448.kumbayo84@arcor.de>
	 <200801162158.26450.kumbayo84@arcor.de>
	 <20080117074559.GB25213@diana.vm.bytemark.co.uk>
	 <20080118042447.GA13178@diana.vm.bytemark.co.uk>
	 <b0943d9e0801230335m4a2d1855uf465d0d134f3ef39@mail.gmail.com>
	 <20080123161014.GA5850@diana.vm.bytemark.co.uk>
	 <b0943d9e0801230842w250ab963t16a1ab3c8024487e@mail.gmail.com>
	 <20080124070125.GA19653@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Peter Oberndorfer" <kumbayo84@arcor.de>, git@vger.kernel.org,
	"Pavel Roskin" <proski@gnu.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 16:32:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI43r-00024X-Iv
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 16:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbYAXPbn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 10:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbYAXPbn
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 10:31:43 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:62513 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbYAXPbm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2008 10:31:42 -0500
Received: by rv-out-0910.google.com with SMTP id k20so317215rvb.1
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 07:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=n+XwL7lveyf8CpQz7K5j/nwj5/3jr7hRNJIPRgqSvZs=;
        b=OhCwRq/tHBudBW/pX4MNd+FeMPG7/n9z4dIvGMHBOoYK5oj3SlEP/bPNnLfICKyZCmEdqm57ac4Lt8eUkY1LmN8Wmgusv1G8R2Hb99UpQhbeGWGJuE+nhqI2N1WZ8vCssUK/22vqB+mU/4Xtmfunt0ZYltE1lcb4D7CuLMZoLZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ew7lVhKaog+ExkTniLg0yy6HfOOEvkBHlgksDimEndBSmCV42UIXUovZSeJp/qvvZsXg8w0QsteqlqUvFMQFRRKQZVZ+UejDt7FfuoVvcSFYlkZM0+PZ4aplC65YXQXqc+3IAG3g5zejXnZM0pI9UNmXpUdLSVJcYgZ7tc/BScA=
Received: by 10.140.177.15 with SMTP id z15mr568344rve.128.1201188700951;
        Thu, 24 Jan 2008 07:31:40 -0800 (PST)
Received: by 10.140.193.5 with HTTP; Thu, 24 Jan 2008 07:31:40 -0800 (PST)
In-Reply-To: <20080124070125.GA19653@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71622>

On 24/01/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-01-23 16:42:41 +0000, Catalin Marinas wrote:
> > $ stg goto realview-eb-header
> > Popped realview-pb1176 -- realview-ioaddress
> > fatal: Entry 'arch/arm/mach-realview/realview_pb11mp.c' not uptodat=
e.
> > Cannot merge.
> > stg goto: Command aborted (all changes rolled back)
> >
> > It worked fine after running 'stg status' once (and not showing any
> > changes). In the old GIT interface, we use to call refresh_index (i=
=2Ee.
> > 'git update-index -q --unmerged --refresh'). Does this still happen=
?
>
> Ah, no, I guess it doesn't. And I guess it should. We should probably
> have a test for that ...

Yes.

Another thing, can the '--keep' option be added? Can it work with the
new structure? I use it quite often as I make some minor modification
and I'd like to pop patches without affecting the local changes.

> And there should probably be an explicit "Checking out files ... done=
"
> stage when we run git-read-tree, since that tends to take relatively
> much time.

Yes, that would be useful as well.

--=20
Catalin
