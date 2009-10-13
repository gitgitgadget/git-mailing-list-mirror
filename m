From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: Supressing sorting of trees
Date: Tue, 13 Oct 2009 21:49:22 +0100
Message-ID: <efe2b6d70910131349n4cab61d0h9a9c8099830095f9@mail.gmail.com>
References: <loom.20091012T152113-874@post.gmane.org> <20091012142032.GG9261@spearce.org> 
	<loom.20091012T171550-239@post.gmane.org> <alpine.DEB.1.00.0910121803360.4985@pacific.mpi-cbg.de> 
	<loom.20091012T182258-9@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Sal Mangano <smangano@into-technology.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 22:58:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxoRw-0006dS-E6
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 22:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934055AbZJMUuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 16:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760815AbZJMUuU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 16:50:20 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:34112 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760731AbZJMUuT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 16:50:19 -0400
Received: by fxm27 with SMTP id 27so10701204fxm.17
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 13:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=2wVqFLOvmHKK0Zk9bj4EL5ZPs229HOpAWXBtiPJ4/jA=;
        b=EBqd4RIjPMxkPHU29ZbrI2kRtd35Fp2VE7lnH0A7M7IwBCeua/WH/Sopj4TpilJIdw
         mLz2GebGS8XB2AYch3/GTk4/goM9goDvR8xMyFQMs4PI0J1+DKDBvMa3ChvNRWEhdkzN
         9FcUJCuy0SguZg2ep2EOCVf15kGUftMooqUkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=A4ay74HX83Zj4yNSEtayPEbu36/vjMYvMzqTjChL1HiJWh0+v1FfSX1b1PdbVtSDUY
         5+ma4NY9FLaOGUC4CM7APjYJawFNihIo6J+yJXkn5qjm+/vq99kav4YAtx/oiDVV5drr
         gnl11JQoJEIzXrcjvkajgDxwvQrmkfZBH02IY=
Received: by 10.223.5.25 with SMTP id 25mr1466330fat.38.1255466982695; Tue, 13 
	Oct 2009 13:49:42 -0700 (PDT)
In-Reply-To: <loom.20091012T182258-9@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130210>

On Mon, Oct 12, 2009 at 5:51 PM, Sal Mangano
<smangano@into-technology.com> wrote:

> 1) I can write by repository from scratch.
> 2) I can use Git unchanged but preserve order by storing some information in
> each sub tree (e.g. an extra blob) which retains the real order. I can also
> store this information once for the whole "chunks" of the repository.
> 3) I can change Git to suite my needs understanding that it is not Git
> anymore.
>
> For me, (1) makes no sense at this time. I started with the hope that (2)
> would work but realized it is very awkward and will cause performance problems
> because it means most updates where ordering matters will have to update the
> Git trees and my private ordering blob(s). So, after a quick look at the
> source code it seemed like hacking Git into what I wanted was easier than 1
> or 2.

You could add a prefix to the names so you get the order you want. Eg:
a-foo
b-bar
c-baz

If you need to move foo to between bar and baz, you just rename it to
ba-foo, etc.

Ealdwulf
