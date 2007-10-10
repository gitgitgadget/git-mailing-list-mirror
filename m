From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: git branch performance problem?
Date: Wed, 10 Oct 2007 18:17:06 -0300
Message-ID: <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com>
	 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:17:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifivg-0006cP-F2
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbXJJVRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754046AbXJJVRI
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:17:08 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:14166 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbXJJVRH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:17:07 -0400
Received: by py-out-1112.google.com with SMTP id u77so628480pyb
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=b+vE2mmX1MNVVV94e0eV/VihUSvyxgVipHyZbnD9Ezg=;
        b=op1PJ82O0sLY17L8EdGCLGxxCI9mfcdvXDHOPSLRGdwfZwlIrRqwltdi6RiuBx37dxzyEIBNC/ftwj7gxMFu0uJiK/Fjt/pxZqkKhJHmvLzkdJwo4yAn3Xyn8VKeVBM3eT7fcV1qPR1h8R2dP16X8IKdZ14nFBGfm+X7gJ3uDRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tayisZDhAIApljT+NCp5nVexHTLdjTj6c59NKwC5zZePjykHghGTmNrBaURrvx3UMr6BXnP92++HZogDllTCf6VaDGikndU8G7+pAbOfrfY6Q4k6mZKMbDccWbEc3IeUh5QtRfY6ZzE6EUaoht1zTCQKormbrl+FoZMzJ6FnMOw=
Received: by 10.65.180.9 with SMTP id h9mr2448882qbp.1192051026574;
        Wed, 10 Oct 2007 14:17:06 -0700 (PDT)
Received: by 10.65.157.11 with HTTP; Wed, 10 Oct 2007 14:17:06 -0700 (PDT)
In-Reply-To: <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60542>

2007/10/10, Lars Hjemli <hjemli@gmail.com>:
> On 10/10/07, Han-Wen Nienhuys <hanwenn@gmail.com> wrote:
> > I'm seeing very slow performance with 'git-branch'.  Is this the
> > canonical way to find out the current branch?
>
> You could also try 'git symbolic-ref HEAD', but see below...
>
> > hanwen@lilypond:/tmp/z$ find .git/refs/remotes | wc -l
> > 1856
>
> You probably want to run 'git gc' (which will run 'git pack-refs',
> i.e. put all files currently under .git/refs into a single file). This
> should speed up 'git branch' (and quite possibly other commands too).

This seems rather unuseful. After running gc pack-refs --all, I lost my HEAD,

hanwen@lilypond:~/vc/git5$ git show HEAD
fatal: ambiguous argument 'HEAD': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions

Is there a way to only pack refs under a certain subdirectory of .git/refs ?
(I'm thinking of .git/refs/remotes )

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
