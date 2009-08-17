From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git http-push and MKCOL error (22/409)
Date: Mon, 17 Aug 2009 12:52:32 +0800
Message-ID: <be6fef0d0908162152o54206acfge43f6ffa012bb307@mail.gmail.com>
References: <200908161557.26962.thomas.schlichter@web.de>
	 <be6fef0d0908160727r7dfa9b46l4d493e3954c21de3@mail.gmail.com>
	 <200908161652.37282.thomas.schlichter@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sean Davis <sdavis2@mail.nih.gov>, git@vger.kernel.org
To: Thomas Schlichter <thomas.schlichter@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 06:52:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McuD5-0005u9-9Q
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 06:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbZHQEwd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 00:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbZHQEwd
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 00:52:33 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:61703 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbZHQEwd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 00:52:33 -0400
Received: by an-out-0708.google.com with SMTP id d40so2667850and.1
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 21:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5XLbpLX61LCO0y5gxpZLNQEY131vBaOHPAPpKKDR4C8=;
        b=JN3b4TDAf3dFi/StdEcRohl6bp44YJj2hmpqa416NNDEtBp7IBpsxNjflUnbr3kKhZ
         I67Y+8QtQTU6edAHP0RrlzWemOaebqZtijamjdUTSa84AUdapI/1PHvVan0ylniigdTc
         XQnJAChjXMtE3ItBzooroEnrEVtQbkui5EQhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nkdaMUdHx4NSrFYNvWw+T2B2wLIjjyjshsW5e8/d9msWFAjBxdoTxCf0xFAEP/AuTY
         0Aryk3DUlQGz1R/D8+OQGcrLtr05bH/PEAlGK0Z0sH3FC3gpwl+wBHipexCw/i5+4X7m
         EsoqWFIqR1hFOFFZ1S9ZRAdf0P3fn73bEirMI=
Received: by 10.231.19.77 with SMTP id z13mr2236359iba.49.1250484752706; Sun, 
	16 Aug 2009 21:52:32 -0700 (PDT)
In-Reply-To: <200908161652.37282.thomas.schlichter@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126115>

Hi,

On Sun, Aug 16, 2009 at 10:52 PM, Thomas
Schlichter<thomas.schlichter@web.de> wrote:
> Steps to reproduce:

before I try this out, I have a few queries:

> =A01. locally set up a git archive:
> =A0 =A0 mkdir dummy.git
> =A0 =A0 cd dummy.git
> =A0 =A0 git init --bare
> =A02. Upload this directory to the server.
> =A0 =A0 I did do this using KDE's dolphin via WebDAV.
>  3. Clone this remote repository:
>     git clone https://webdav.smartdrive.web.de/dummy.git my_dummy

You didn't run git update-server-info before doing the clone; cloning
wouldn't work cos git can't find a info/refs file. Perhaps you did do
it and unintentionally left it out from your procedure listed here?

> =A04. Create a local commit:
> =A0 =A0 cd my_dummy
> =A0 =A0 touch dummy.c
> =A0 =A0 git commit -a

I assume you want to commit dummy.c? But you didn't tell git to track
it in the first place (git add dummy.c).

> =A05. Push this commit up to the remote repository:
> =A0 =A0 git push origin master

I also find it strange that git only pushed 1 object from your git
push output, when usually there would be a tree, a blob and a commit
to push for a new commit.

--=20
Cheers,
Ray Chuan
