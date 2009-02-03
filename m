From: Matt Pearson <404emailnotfound@gmail.com>
Subject: Re: revert committed and pushed tag
Date: Tue, 3 Feb 2009 17:17:25 -0500
Message-ID: <706b4240902031417p1a98f3fdtb2240ea5ae5b31a5@mail.gmail.com>
References: <4988586D.603@cetrtapot.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
X-From: git-owner@vger.kernel.org Tue Feb 03 23:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUTbW-00019Q-3D
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 23:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833AbZBCWR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 17:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbZBCWR1
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 17:17:27 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:8199 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbZBCWR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 17:17:26 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1234960qwe.37
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 14:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iZ59hFSK5GAR5eSQ4G3H0xR7bpvxm6H12YhnXuVLZNM=;
        b=Io0Sa+RAxwOoVcPSDZ7CtBhwEeamiwutVcj09V3cf/gjLTP70EN6fQonzC8fVQGAN4
         t6dvIoKo262Hf2QMe8nZ4ngkXAbfLVCmhSXtEyznAk/g7YHXoLvlJoMICoBsEKeLsZ0/
         y2bWcbkMIvvaNC616xK1rXBBgjY/1kwlp5yLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SjiRlENjMZf+XRw5Kz2rZNWvSH7MPS43VUlm9dgTtxh6jsYwdxVjYK51V9FGKSZtnz
         qx0FcjL6yqqOwAsRObagH8nYLvDcKFsq9qv9HF2SSNfGkeG2ElxkNoHiKaIPnxdpId9m
         j43SV9rpX2/XuUz6ea7KJrnaEGFN+VXCv6lQ0=
Received: by 10.214.80.18 with SMTP id d18mr9295857qab.8.1233699445141; Tue, 
	03 Feb 2009 14:17:25 -0800 (PST)
In-Reply-To: <4988586D.603@cetrtapot.si>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108255>

2009/2/3 Hinko Kocevar <hinko.kocevar@cetrtapot.si>:
> Hi,
>
> Is there a way to 'revert' committed and pushed tag?
> I've noticed that some files were not included in the commit (new files)
> and I would like to squeeze them in before the tag was
> created/committed/pushed to the remote server.

You do it the same way you delete a branch (see git-push(1)):
git push origin :refs/tags/rc3

Note that anybody that has fetched from your public repository will
_not_ have their current 'rc3' tag overwritten with the new version
without them deleting it first and letting fetch recreate it.

Matt
