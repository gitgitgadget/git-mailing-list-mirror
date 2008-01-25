From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: stgit: managing signed-off-by lines
Date: Fri, 25 Jan 2008 08:34:53 -0500
Message-ID: <9e4733910801250534s7ab11b15uff3c782165a8e2ea@mail.gmail.com>
References: <9e4733910801241227n659a5b34x7f77f25101aa225f@mail.gmail.com>
	 <20080125083853.GA5804@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 14:35:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIOiL-0006NS-VP
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 14:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbYAYNez convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 08:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754511AbYAYNez
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 08:34:55 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:61841 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501AbYAYNey convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2008 08:34:54 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1076149wah.23
        for <git@vger.kernel.org>; Fri, 25 Jan 2008 05:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7L3y/tY43wrlP+ve73itLNITv2vjxsqHBBtsoqbOTKU=;
        b=eejb0o2wOdTo+LS/0utfEEyAmfZG5JULa5KUVMH4WO4V+EDbJixWuWLvYgAOpjIq9tqDkuNbZxbdNNbwFkGkUaiXUN79B7btQC00JscMXsfnyV6KliKSNpRbMQSV5maPfcWWxIsLmDBIN4fYuNcDwURAyCA2oVIn2QBJg2utqbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CHiGhQDPWDyEYXqm6zT3u7mQ9DQUuzSLB5+DsQ9T9ApSQHGAZSRI3+uIcJi9TRDEJYE16Ts8Wjy8USYIbw435VsJ6Wrmg9BpmFbkyXyrlksIpFH/iPaJpeS+vahiQSq1INTQ86NIw+xCI60tyjqgbcAMBIhyHcMcaFOtwpqP/M8=
Received: by 10.114.157.1 with SMTP id f1mr268519wae.13.1201268093919;
        Fri, 25 Jan 2008 05:34:53 -0800 (PST)
Received: by 10.114.93.14 with HTTP; Fri, 25 Jan 2008 05:34:53 -0800 (PST)
In-Reply-To: <20080125083853.GA5804@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71707>

On 1/25/08, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-01-24 15:27:17 -0500, Jon Smirl wrote:
>
> > If I import a series of patches from one of my trees into another,
> > stgit preserves the signed-off-by lines like you would expect it to=
=2E
> > When I export these patches it adds a signed-off-by line for myself
> > again like you would expect it to. But adding this line on export
> > needs to checks and make sure that my name isn't already in the
> > signed-off-by list, without this check I have to manually remove my
> > name when it gets duplicated.
>
> What command are you using to export patches?

I am using "stg export" from one branch and then "stg import -s" on
another. After I import the patch and do 'stg edit' on it, it has the
signed-off-by line in it.  When it is export from that branch the
signed-off-by get added again.

You don't want to strip the signed-off-by lines on import, they may be
from other people. I would think that on export you could look and see
if my signed-off-by line is already on the patch before adding it
again.

I might be able to handle this better by rebasing my master from both
linus/master and my branch containing these i2c patches that are
taking so long to get in. That would avoid the import/export step. But
then I can't edit the patches directly on my master branch.

>
> IIRC, all commands that have --sign and --ack flags already to check
> for duplicates. But if you do something like have your sign-off line
> in the template the export command uses, that would lead to
> duplicates.
>
> --
> Karl Hasselstr=F6m, kha@treskal.com
>       www.treskal.com/kalle
>


--=20
Jon Smirl
jonsmirl@gmail.com
