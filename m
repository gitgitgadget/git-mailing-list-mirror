From: Junio C Hamano <gitster-vger@pobox.com>
Subject: Re: is it just me, or does --all ignore --no-tags?
Date: Wed, 22 May 2013 14:31:11 -0700
Message-ID: <CAPc5daU_q8ScUXr=C_SPy4mSJBjY8Ue9GKbcW02=os5Yk6i0QQ@mail.gmail.com>
References: <CAKSmPgYFLZ59uAek8=GMXZE2tgGMo40s=y8X87m2GJbPVJo9WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Geoff Thorpe <qc.libre@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 23:31:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfGdG-0001cP-7M
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 23:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768Ab3EVVbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 17:31:34 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:50635 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab3EVVbd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 17:31:33 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so2617707lbi.4
        for <git@vger.kernel.org>; Wed, 22 May 2013 14:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=zdzkr3spL8Q05xfr10q3WpSfRAnrvxTKvqr/2/dXPuE=;
        b=C4tsfkrS71TSigDSPvNEbeeWf0+qWkCO8enXufTeKYO8zSQbVtUdfErtB6EwyzQrtg
         4rs6IUHMU8C4gAXoLcVrLnLvDkr9vo+CZqA8gi0Od9OZ7+BPn1XSC51vbwx83pDT5e/4
         gVMSxPrdzpxH20FUUdhky0+NqewHCL0sGIohi33ZB47FHVmhnjOsSG3dsNLwYtENacBK
         /Vs1E8VRpYBfkVgRTIUQH3BiF5XZWo913iMewDbHwjIJI2ULWIvkCJH5QZREuO2IVzxe
         v/6X+XT6b2DdbjLb4xvpyfyBf9o6lln7PEjk5cAvSBOvsj4P10GQWica72ClVFJvbY4a
         mrRw==
X-Received: by 10.112.166.101 with SMTP id zf5mr4921949lbb.59.1369258291969;
 Wed, 22 May 2013 14:31:31 -0700 (PDT)
Received: by 10.112.134.230 with HTTP; Wed, 22 May 2013 14:31:11 -0700 (PDT)
In-Reply-To: <CAKSmPgYFLZ59uAek8=GMXZE2tgGMo40s=y8X87m2GJbPVJo9WQ@mail.gmail.com>
X-Google-Sender-Auth: 5jB7BgnkwglNLGIGgz1z1U0Qzz4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225193>

> So instead of doing;
>     git fetch --all --no-tags
> I'm now doing this to avoid the problem;
>     git remote | xargs -n 1 git fetch --no-tags

I suspect that this is 8556646 (fetch --all: pass --tags/--no-tags through to
each remote, 2012-09-05) which is in 1.7.12.2 and upwards.
