From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: use printf instead of echo to 
	print commit message
Date: Thu, 22 Jul 2010 20:08:25 +0000
Message-ID: <AANLkTinBvIE-nW__qN9XpbWiwhx1C6_FWylWQRLGd2BQ@mail.gmail.com>
References: <MoU2SrLLcYS4J28tNBJjfxYnqoLoX04XwHLgciB5KCUnhqJoXifmNFbSGHS4r8pboBurx-NhZWs@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jul 22 22:08:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc24F-0005jD-P7
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 22:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab0GVUI1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 16:08:27 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52267 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab0GVUI0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 16:08:26 -0400
Received: by gwb20 with SMTP id 20so320456gwb.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 13:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Tld3rNAd+XD+AMkkIPtVobLr+gTw7jGAeblSKVdux9g=;
        b=H+iyQ6wMjvh5j7iIuxehfc/qbeuhAabrIR5I5IBfVvylg3a6ds5P1hNniXf7A94+Yu
         x1EQYAVJZE1tSTfTBTWu8TTz8uub/V6fTqX/8kyyUp+fp70nkrCkFjw5YD3WsjgEnoCD
         /Bzv4Lk07+ZGuIawnWfdZPjj7T4SDn64hPUso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vKA5qCCaswCo4MF3lkTUogupH8AdWnKClyoZh6q3xhxI9HaWcRB4lGPQxZ6LvPLQGz
         9j9wOyhFpFmwRbWGO5bvdN6PtrXZx5/cuRxkWi7qSCgj3uFln1iuAHWErlgBGFOVVHoV
         K069wwGUZ0pppkxBM/SvzdzDgKPs6fxMIsWqg=
Received: by 10.150.68.36 with SMTP id q36mr4762598yba.204.1279829305307; Thu, 
	22 Jul 2010 13:08:25 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Thu, 22 Jul 2010 13:08:25 -0700 (PDT)
In-Reply-To: <MoU2SrLLcYS4J28tNBJjfxYnqoLoX04XwHLgciB5KCUnhqJoXifmNFbSGHS4r8pboBurx-NhZWs@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151478>

On Thu, Jul 22, 2010 at 19:15, Brandon Casey <casey@nrlssc.navy.mil> wr=
ote:
> From: Brandon Casey <drafnel@gmail.com>
>
> On systems with an echo which defaults to the XSI-conformant behavior
> (Solaris, or others using Ksh), echo will interpret certain backslash=
ed
> characters as control sequences. =C2=A0This can cause a problem for i=
nteractive
> rebase when it is used to rebase commits whose commit "subject" (the =
first
> line) contains any of these backslashed sequences. =C2=A0In this case=
, echo will
> substitute the control sequence for the backslashed characters and ei=
ther
> the rebased commit message will differ from the original, or the reba=
se
> process will fail. =C2=A0Neither is desirable.
>
> So work around this issue by replacing the echo statements used to pr=
int
> out portions of the commit message, with printf.
>
> Also, add a test to test for this breakage.

This looks good, especially the test for it:

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
