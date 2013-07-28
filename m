From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sun, 28 Jul 2013 14:46:44 +0530
Message-ID: <CALkWK0mFj3fy7k=LirZ9LotGAxt7ptSpzZpR0sCg4OPmPb1WjA@mail.gmail.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
 <CALkWK0k-23rTohYvNWP_XbuUCSGUE+G_e_7cBbPP5C9OzsJ4XQ@mail.gmail.com>
 <CALkWK0kBesC2=kyygMCt61Fm5GGqX+yF6sbkCRcGYZ=ovgtTAQ@mail.gmail.com>
 <CACsJy8C5Du8zcqVeN7EGuyUxgSZaRq-X8y_hQvqQedYWfP8p+A@mail.gmail.com>
 <CALkWK0kWnge7fVtTXRgTiK1NbyN8X=bmqfPTc+Mp=BCssPc1og@mail.gmail.com>
 <CACsJy8CDg2ORKrpwiph=WdW5GPUYEwT1CSCttQ4fagQoMP4QGA@mail.gmail.com>
 <CALkWK0=xuNGM54=Kodfi9L8_yUOaXrWvqiMHbx2SRTH1CmZxLA@mail.gmail.com>
 <CACsJy8AuAy7PnEU20k23gVRQoFrLhJrM6hfESZKshUA578c3Ew@mail.gmail.com>
 <CALkWK0nFDyFqBPatsbQ-0mGXQ-6N5Xs9gKioknuGX9a7UiD4Fg@mail.gmail.com> <CACsJy8CAfCVtTmgtEaix6RwYm4Sj7Ot_BjuObS+qvQ=QNnQ0OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Xin Jiang <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 28 11:17:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3N6Y-0005QI-T5
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jul 2013 11:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab3G1JR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jul 2013 05:17:26 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:56445 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab3G1JRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jul 2013 05:17:25 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so7190205obc.12
        for <git@vger.kernel.org>; Sun, 28 Jul 2013 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5sPQAVsgZZcU87KNz0PbFO3s92J6mVMw9mVSJZu2fuI=;
        b=roco8UqB5t2yJzFUcTmhAxfMHZ+0goAShjk8DfnIB/m24ImA7a4HGiixiw0UssWZCt
         /JitD+dRf4owD+LUQIlI9ZAkY5ABeqSi7FpoQBzwIUPOGek00MZRHM3ZraUHn/ctqrTc
         gtjDDPDEQV15k0qVUad/pfN+WkJkjqymUqqI9fj+tkIT4iTkCQ+WipHNIAK9jm33jvCV
         JsseVbJW78MSZYYKGYAkUsyEtfJOSvzDE2qTjZB0Ky4AKBtTF1QTXqE5DJKRLR/H2IR+
         mcWg1UZX2PvCdXqfIwjG4SikBb9+DtqbDMbNA8YDBSbbo9apLY48upwYgOJ2LRnhuXcM
         LoHg==
X-Received: by 10.50.72.73 with SMTP id b9mr537933igv.50.1375003044915; Sun,
 28 Jul 2013 02:17:24 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sun, 28 Jul 2013 02:16:44 -0700 (PDT)
In-Reply-To: <CACsJy8CAfCVtTmgtEaix6RwYm4Sj7Ot_BjuObS+qvQ=QNnQ0OA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231264>

Duy Nguyen wrote:
> In the no-submodules symlink test case, the path given to the editor
> is .git/COMMIT_EDITMSG, no following ".." back in the symlink target.

Thanks, and sorry about the stupidity.  I just patched
builtin/commit.c to check this.

> This bug can be reproduced without git involved:

I'm taking this up with Emacs-Devel; you are CC'ed.
