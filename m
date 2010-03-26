From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Rebasing with merges and conflict resolutions
Date: Sat, 27 Mar 2010 05:11:01 +1100
Message-ID: <2cfc40321003261111x5a500ef4q9b0caea65a48b21f@mail.gmail.com>
References: <20100326031111.GB27737@kiwi.sharlinx.com>
	 <4BAC5C14.4060903@viscovery.net>
	 <20100326171603.GA12592@kiwi.sharlinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 19:11:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvDzy-00061a-Fd
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 19:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab0CZSLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 14:11:04 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58463 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056Ab0CZSLB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 14:11:01 -0400
Received: by pwi5 with SMTP id 5so5273001pwi.19
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type;
        bh=0MFQXg3GiX+BbtAuM8w7BlkRnfSuJ5dz5qzYPm6ZDn0=;
        b=A+KrcBuHwYNYYzLELJWlMJQaDhep4WZNurDaXnuJC7pnegRGipEvhOA5OrQA3JsZiX
         qixSbt1Rz1NKdp4mtHnDpb4Ady+olUblX8uADUZIddHZAvMINJpz+Wy2+sic3/eQ5D5+
         OfnL5UAUQjzjNqKpmbOfQM42p9ArZjflyjg40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=Y2qCTt11fImXNq8Nws9nyx/CCz7S5kglj3b5GBgFNeEu379DSsOeR9Ssk+HYA7yWuo
         y+Z0+ILQMDbTo9REUofR6i6zuwmFp4dg3Uu0LzgvER+aqdRMjZQgKOTdwZSXkmwlEAg9
         Xjwd0YYoF6r2yZa6ZvOdfZK5kA8219rL6VfcM=
Received: by 10.115.89.7 with HTTP; Fri, 26 Mar 2010 11:11:01 -0700 (PDT)
In-Reply-To: <20100326171603.GA12592@kiwi.sharlinx.com>
Received: by 10.115.133.12 with SMTP id k12mr1791419wan.6.1269627061162; Fri, 
	26 Mar 2010 11:11:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143263>

> > > In the future, is there a better way for two developers to work in the same
> > > back-and-forth fashion (code ping pong!) without leading to *heavily* merged
> > > histories that are unpossible to untangle?
> >
> > Discipline. Keep developers focused on their topic. Merge only after a
> > topic is completed. Do not give in to "oh, *your* feature is cool, *I*
> > want to have it now, so I merge it".
>
> I think that's easier said than done, with backend work I'm able to clearly
> define topics, whereas the front-end developers (as it is in this case)
> typically overlap ever so slightly in their work
>

If two developers are working together, then set them up so that each
has a public and private repo.

The rule should be:

1. before publishing, A fetches from B to ensure that A has B's latest
public tip
2. A confirms that B's tip includes A's public tip
3. A rebases own private changes (between A public and A private) onto
B's public tip
4. A pushes her rebased private tip to her own public repo
5. B then repeats the cycle with the roles reversed.

This will work provided that B doesn't republish after 2 and before 4,
so does require that A and B talk to each other before performing step
4.

jon.
