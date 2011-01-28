From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] merge: default to @{upstream}
Date: Fri, 28 Jan 2011 20:46:15 +0200
Message-ID: <AANLkTi=iMJv+Jtj8YdYhQ_sxu+jBht5YqvSnkS2LUerz@mail.gmail.com>
References: <1296231457-18780-1-git-send-email-felipe.contreras@gmail.com>
	<1296233099.12855.14.camel@drew-northup.unet.maine.edu>
	<20110128175609.GA27118@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 19:47:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PitLl-0003so-8l
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 19:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab1A1Sqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 13:46:46 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38230 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039Ab1A1Sqp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 13:46:45 -0500
Received: by bwz15 with SMTP id 15so3505773bwz.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 10:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qfi+1+a093aE/9XUyJ1koQH4gV9TrnPAWO9lbzj8XbE=;
        b=oNYNdfEz7baghFr3iQKuDjPOYkDumYCj3agQ1nmvmM5+XRSKj5gAjzt2o1Fq3sm3BR
         ZpZr8MNpZJub5ikdHFswQGDoy65ybRC/TT7ydsKOUuwedyHB2xO767/G9+KkigUVdL0b
         bXPUtevrHpBYqn4Rup2BZwENdBLXpO7y6stAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JPNy5WKl+zw6Pb1JnIgQNA98cHFaKNKO04P1y/+4Q8Ylmh/VswLQaDBEWBSW4uJebB
         eKUHbzUy06sN4EbLzXIuzdYG/gG4Wct6WImiM9dlnwIUgPtCRh3j2PlfUNlEwhuVIThN
         wKQ9q0KTF57olSdggxodm3MAbKEWQpfnKyPb4=
Received: by 10.204.56.3 with SMTP id w3mr2784675bkg.60.1296240375814; Fri, 28
 Jan 2011 10:46:15 -0800 (PST)
Received: by 10.204.102.9 with HTTP; Fri, 28 Jan 2011 10:46:15 -0800 (PST)
In-Reply-To: <20110128175609.GA27118@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165633>

On Fri, Jan 28, 2011 at 7:56 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Other nits: documentation? =C2=A0tests? =C2=A0The rest of cmd_merge d=
oes not
> rely on argv[argc] being NULL, but it might make sense to set argv[1]
> to NULL anyway for futureproofing.

Sure, I need to add documentation and tests. I should probably have
sent this as 'RFC'.

Anyway, I don't think we can set argv[1] to NULL, because it's
possible that this is "char *argv[1]", so that would crash. The only
thing the standard ensures, is that the last one would be NULL, so
argv[argc] =3D NULL, and therefore we can override it, as long as the
rest of the code checks for argc instead of NULL, which AFAIK in the
whole git code it is the case, and certainly in builtin_merge.c
AFAICS.

Cheers.

--=20
=46elipe Contreras
