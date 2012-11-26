From: Igor Lautar <igor.lautar@gmail.com>
Subject: Re: commit gone after merge - how to debug?
Date: Mon, 26 Nov 2012 15:15:35 +0100
Message-ID: <CAO1Khk9Y_SC8q4iHnv848Z+dXMaeUOWxzW76yPSj_as317_u5g@mail.gmail.com>
References: <CAO1Khk_eugH--wp3s-gr4HTvuRyL=SaWHWtEXCRZ_Ak7+s5U=w@mail.gmail.com>
	<1353935441-ner-9639@calvin>
	<vpqr4ngsdjl.fsf@grenoble-inp.fr>
	<CAO1Khk9mzJjnysnc1iDFeMgqnRq0z35t0kgC-8nrsjJ-oOvdOg@mail.gmail.com>
	<vpqehjgscv3.fsf@grenoble-inp.fr>
	<CAO1Khk8=nrKknfqY-k6XaGPDbLrHyrK-8fxfB7XXUWeB7L4EUA@mail.gmail.com>
	<vpqhaocqx4k.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 26 15:15:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TczTU-00087u-0N
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 15:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab2KZOPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 09:15:37 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:42596 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab2KZOPg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 09:15:36 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so7659217vcm.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 06:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wHCHplo55k50PAePaNOmcmcGTGRuvV3PMkiHduQzdLY=;
        b=cXFNtW+nOZlTutJvb6VcCx6LVnmUK1c62/rgNB0wrpEBHvYtgWgH6I7gLz0kX0zdKX
         YCj0vc3LPf06LbQt8eunvBuKJVBJZyxdl99M6nyorQa1qPA+BAAmVP4UGS3dT6W/ZKuF
         uNBbPykBkYBF/8CXTBTZYxb3Yf3b39/f7oBL48n6Em7WB/DGAZMooD/iGJ5w7zimVKgF
         MGzA10rBL9tVcFhgyif/uV5IHPV6phOlM3A+T25Lkl8nuFV62lQbEqyV/sIPPKh/7n/7
         oho1nmQqhfNMYfRY7yc+pTEzozTbVonP2ONv1oPWFSUAX34nxeozMcPLWeOmalwjcGr8
         DU1A==
Received: by 10.52.73.226 with SMTP id o2mr13893651vdv.16.1353939335601; Mon,
 26 Nov 2012 06:15:35 -0800 (PST)
Received: by 10.58.69.112 with HTTP; Mon, 26 Nov 2012 06:15:35 -0800 (PST)
In-Reply-To: <vpqhaocqx4k.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210451>

On Mon, Nov 26, 2012 at 3:03 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Your initial message was about the output of "git log". Do you mean that
> the file, on the filesystem, does not have the line introduced by the
> commit?

Yes, sorry if I was not clear enough.

> If so, check the content registered in the repository too:
>
> git show <merge-commit>:<file-name>

Content shown is identical to the one in working copy, ie., it is
missing one line change.

git annotate <file> <merge commit>
 - shows that particular line as if it has originated from when the
file was originally added to repo.
git annotate <file> <merge commit>^2
 - shows line as being modified by a commit done after file was added
- ie., state I would expect after a merge
