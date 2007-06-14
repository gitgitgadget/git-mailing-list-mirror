From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: tags and patches
Date: Thu, 14 Jun 2007 12:20:57 +0930
Message-ID: <93c3eada0706131950y7a27cf39i1326d34535e7f5e9@mail.gmail.com>
References: <93c3eada0706130352h3ad6857eie01e1171fdda3991@mail.gmail.com>
	 <Pine.LNX.4.64.0706131313550.4059@racer.site>
	 <93c3eada0706131715oa84eff7kc0b477a3b80e9d66@mail.gmail.com>
	 <Pine.LNX.4.64.0706140201400.4059@racer.site>
	 <93c3eada0706131905i1cd43fd2xcc44ce47dca8ce00@mail.gmail.com>
	 <20070614021939.GA18325@segfault.peff.net>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 14 04:51:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyfQO-0002gV-JT
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 04:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbXFNCvA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 22:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbXFNCvA
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 22:51:00 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:15166 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbXFNCu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 22:50:59 -0400
Received: by mu-out-0910.google.com with SMTP id i10so544656mue
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 19:50:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l8/KvEqgD0Ho1ydvmZG18E8tirSV4e03fURQsqYHJNqITU30UKj/xMpzykS0kN0LRPI7Hp4KPDJCPExs+6aMMQz4vCMd6I/EN0v1OXg4xU7YdLQVPv5GchWRXsE8trDr99NabNNMXb70wyg64pWVC6SRIlaBrxFmsFaZp1gckCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sz4rGQIIAWAY+7+qpqQ+QShOgQ5xaOpidZehsCJlbXZZdQJawUgsjHnVwYqH0+4sbGDwxlkVIP82UMf2iW0hFD8RBIpWZeOwjymlWGlR7i82xp+erVB1SA254ik7gGAVE83Kwq+r8YwssezQrXM7LYDBI/daI6XOKmp51Ce8/AU=
Received: by 10.82.126.5 with SMTP id y5mr2446181buc.1181789457760;
        Wed, 13 Jun 2007 19:50:57 -0700 (PDT)
Received: by 10.82.141.14 with HTTP; Wed, 13 Jun 2007 19:50:57 -0700 (PDT)
In-Reply-To: <20070614021939.GA18325@segfault.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50161>

On 6/14/07, Jeff King <peff@peff.net> wrote:
> On Thu, Jun 14, 2007 at 11:35:35AM +0930, Geoff Russell wrote:
>
> > I'm trying to work out if I want to use git to manage a software
> > distribution problem. I distribute release v1.0 to people then later I
> > want to email them a patch to take them from v1.0 to v1.1.  I can
> > probably live without the tags, but am just surprised that patches
> > don't send them.
>
> Patches represent differences in _content_, but they don't show history.
> So while git supports a somewhat extended patch format (supporting
> things like renames and file modes), patches don't know anything about
> branches, parent commits, or tags.
>
> If you are trying to take people from v1.0 to v1.1, the best way depends
> on their setup:
>
>   - If they are all running git, then you can have them 'pull' from your
>     repository
>   - If you don't like that for some reason, you can send them a bundle,
>     which is the moral equivalent of pulling (except that you've pushed
>     through a non-interactive medium, but the end result in their
>     repository is the same)
>   - If they aren't running git, then you can use git to prepare the
>     patch by tagging your own repository, and then creating either a
>     patch series (git-format-patch v1.0..v1.1) or a single big patch
>     (git-diff v1.0..v1.1). But either way, what would it mean to have a
>     tag in the patch, since they don't have a tagging system at the
>     other end?
>
> I'm not really sure what you're trying to accomplish; if you can be more
> concrete, we might be able to offer more concrete solutions (or maybe
> the answer you were looking for was simply, "you want bundles, not
> patches").

Ok (in english we have an expression "the penny has dropped" :)), I understand
my confusion and no longer am surprised that patches don't have tags!
I think that we will ensure everyone is running git (but we will ssh into their
machines and do the appropriate pulls).

Many thanks for your help and patience,

Cheers,
Geoff



>
> -Peff
>
