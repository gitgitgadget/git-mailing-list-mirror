From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] get_ref_states: strdup entries and free util in stale 
	list
Date: Tue, 1 Dec 2009 10:05:41 +0100
Message-ID: <36ca99e90912010105r428a7bfdw63928e8a5515bd1d@mail.gmail.com>
References: <0458f16c6ce906997aaf357c0c7368841ae83c36.1259625072.git.bert.wesarg@googlemail.com>
	 <alpine.DEB.1.00.0912010934120.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 01 10:05:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFOg9-0006Nv-L2
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 10:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbZLAJFi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 04:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbZLAJFh
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 04:05:37 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:42481 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbZLAJFf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 04:05:35 -0500
Received: by fxm5 with SMTP id 5so4634462fxm.28
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 01:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HTFN0g7b2IBAl079C/q5Ng0WztMOjz0e7SwXBe5fpq4=;
        b=KAElmsPrke0Y2TB2aWes0Ig3ZzaVxNVly1zTC4S2PapBbWCC6pcKUC3t84KdJEf7ld
         qC/0a1EUWMYDamoFr+im9L7gOKy3IZt23TVKkrGeTWpZsOtY20BXMPP7U9fuPhHdVIGN
         YWD6CemoOHt7wuqN5w4eDA6Y/lTKfaD0js8lc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AUJEWRno6ceyd6vSCbT4yv1HTwwYVU18SmWv5SVbyn1r+Qz8fQGGINJ/pz9HwxmcqL
         JiS00SbqTO6KvY6KqLG7sXs6dytry6dGYm3kNSyzou9PFdRjQOAxJvAW8VxFhrMraz1Z
         c7X3Llnybh59/TjRVDGNdonyUDufj2gRWmXq8=
Received: by 10.223.161.215 with SMTP id s23mr907346fax.44.1259658341377; Tue, 
	01 Dec 2009 01:05:41 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0912010934120.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134183>

On Tue, Dec 1, 2009 at 09:35, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 1 Dec 2009, Bert Wesarg wrote:
>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> Thanks. =C2=A0I trust you ran the test suite with valgrind just to ma=
ke sure?
Not the test suite. But my use case where I found the problem (Ie.
cut-off branch names) which was 'git remote show <remote>'.
There are still invalid reads of size 4. I think the problem is the
flex array member of 'struct ref' and strlen(). If its worth I can
look into this.

Bert
>
> Ciao,
> Dscho
>
