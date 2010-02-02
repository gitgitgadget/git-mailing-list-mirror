From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Git and Amazon S3
Date: Tue, 2 Feb 2010 11:34:49 -0500
Message-ID: <76718491002020834k5a666a2eh935d6aced9f8d216@mail.gmail.com>
References: <501db8661002020556k2f65add2rf06b289f2c9cbcac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Aneurin Price <aneurin.price@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 17:34:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcLiK-0005FN-Qn
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 17:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab0BBQev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 11:34:51 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:46224 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab0BBQeu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 11:34:50 -0500
Received: by iwn1 with SMTP id 1so282457iwn.25
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 08:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=x0LeiKn1NuNsCQTtHYVuCJ2O+GXaVHfP8wZralDof4M=;
        b=nZfRofEROP2ZSOX0SvhFDEuA1N0TN9fu64aAXeecihG2DG+kJjzODptvl5ESU4M4VY
         Nh+7TsXV6nx2n2PqnDyuWW0l0cTPXieU1+xkiv7Xh5scFZpR8mANmJ68hRfvDJYfNXw0
         odeUfPdbSQmdJpQ81d2thceZ4xq7y+m8JgDjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nS6mOzFfPgsSpHUaCsSGLUB+++OEN0cl9o08608/q+mHBrgNWCbKWRNBs1whYyB+FD
         t1W0oEDd6A4K73EobFRpsY5Sza6ewtAnRbPoTERkxpnvs0DOg4q7Kvm4Pt3jzobA0Chs
         bc4POe/owvGO4PHxvQMT5yUefoW5JcjWaS5ls=
Received: by 10.231.146.79 with SMTP id g15mr2222059ibv.49.1265128489676; Tue, 
	02 Feb 2010 08:34:49 -0800 (PST)
In-Reply-To: <501db8661002020556k2f65add2rf06b289f2c9cbcac@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138729>

On Tue, Feb 2, 2010 at 8:56 AM, Aneurin Price <aneurin.price@gmail.com> wrote:
> It looks like the cheapest option from a pure storage and data-transfer point of
> view would be S3, so I'm looking at the best way to use it with git. So far, the
> options I've found are either using jgit, which I've never used but appears to
> have a native S3 transport, or using one of the FUSE options to mount S3 as a
> filesystem.
>
> Does anyone have any remarks about these options? Is there a better option -

I guess it might exceed your costs, but you could use a small EC2
instance backed by an EBS volume. The instance would have git
installed.

When you need to push, fire up the instance, push to git running on
that instance, then shutdown the instance and snapshot the EBS volume
to S3.

Hmm, maybe that's over-engineered. :-)

j.
