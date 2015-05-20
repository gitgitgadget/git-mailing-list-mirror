From: Stefan Beller <sbeller@google.com>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 11:02:14 -0700
Message-ID: <CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org>
	<vpq382rkvzf.fsf@anie.imag.fr>
	<d21002e0fa92b03c3d417c8996328563@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Faheem Mitha <faheem@faheem.info>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 20 20:02:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv8Jv-0007HE-Su
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 20:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148AbbETSCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 14:02:15 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33862 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988AbbETSCO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 14:02:14 -0400
Received: by qkgx75 with SMTP id x75so37133265qkg.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 11:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rNWWKpW6GJzH0jDoK13Een8Kh7s/XoiEhNUX8+9kZL4=;
        b=Fy5mxE8OfXHc5hRPTCL31OdO4d/NXC5S7RdXmhueRgFhVux//uUZFI67rsn2Ebka16
         RJGoxS1kEfnCjJYai6YAeRyLL9MKkPZsXR1qdv3UkWUNIghq9bQPUwOnoCoNQlWCWkgB
         l1hKVAK6TdaIQcbFxwKafTpotA2pvJM9bXdgxue/2Zt33/FiiJVPaq9CExWb7sgcDZnJ
         CW5C5uHm6sAWap/b+I44i58iBiquVBrjpTkUA2xJ0To01L4o+N4VLlBBAqddUT4S/z2Q
         coOD9Q3u1ry4XlJo2pi/uLpDX75w1GbHNhBiG9zpfVj0E55DinLe8QSguyGwmc+hZN1r
         v+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rNWWKpW6GJzH0jDoK13Een8Kh7s/XoiEhNUX8+9kZL4=;
        b=cSPVmfLrfWb6IgUnlAoI7W53zeV/Rvq4GEc/vtTD/LLrOUpGAS3Vmljx/SUpH3LfdM
         LYnF8LABErREGC+ul+vBI69u8fqnuiVvK6Sh7SC7SSOxu1O+GDG8qEJV2bD/VftJrbWW
         C3NpdpkVgSAxc9JEgi1O72+iaY+4XeSQzxHyNyy4uvrJO3eUQJkJBRlPnSMnETOlvhYd
         VoCBDgguc1SeOp24fpNznZbr8WAQvZgbEua33HHgdOFF2/jpk+0shwv/Ti5kGZReeYeo
         9ybqJju9eqgNaJ2b1EsiKl43giuoR2+P/5kMWsxLP2eHw2wEljgZEsoOL60zb0GgRdDz
         wFxQ==
X-Gm-Message-State: ALoCoQkYljONPNnI2F1a1OGLbxdSydkNVxIMh5hfl//9tYuyk2cedIG8a74p8C/cCzOkJQFYPENn
X-Received: by 10.140.23.35 with SMTP id 32mr44941093qgo.106.1432144934139;
 Wed, 20 May 2015 11:02:14 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 20 May 2015 11:02:14 -0700 (PDT)
In-Reply-To: <d21002e0fa92b03c3d417c8996328563@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269485>

$ git clone https://github.com/fmitha/SICL
cd SICL
$ git show 280c12ab49223c64c6f914944287a7d049cf4dd0
fatal: bad object 280c12ab49223c64c6f914944287a7d049cf4dd0
$ git show 12323213123 # just to be sure to have a different error
message for non existing objects.
fatal: ambiguous argument '12323213123': unknown revision or path not
in the working tree.

$ mv .git/objects/pack/pack-d56da8c18f5aa915d7fe230efae7315a0101dc19.pack .
$ rm .git/objects/pack/pack-d56da8c18f5aa915d7fe230efae7315a0101dc19.idx
$ git unpack-objects < pack-d56da8c18f5aa915d7fe230efae7315a0101dc19.pack
$ git show 280c12ab49223c64c6f914944287a7d049cf4dd0
fatal: bad object 280c12ab49223c64c6f914944287a7d049cf4dd0
$ ls .git/objects/28/0*
.git/objects/28/01fef08b1dccf9725dde919a7373748a046cb7
.git/objects/28/03d8c1cb3275979ff2d8408450844f6a78a70d
.git/objects/28/0663a93d702a7fcb0dd36f461397f6b50ba01e
.git/objects/28/068e2656dd4bac61050e870712578032af9144
.git/objects/28/074e890d6ff2bb61eb7796bc500b6d8e344ad2
.git/objects/28/08596ac465cf8a819a9b13ad2f855e9a8a3235
.git/objects/28/098184d1ba97453227c18628cdf13087b6bce2
.git/objects/28/0ba19c68b26ee7c799ef8ca09d540a5ad7a5b2
.git/objects/28/0d66213173f0ae7aaae8684f3efcb1f8790792
.git/objects/28/0da35374c32303cbd726bef9847f18d7428d5e

There is no file 28/0c... however.
