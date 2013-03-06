From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: feature suggestion: optimize common parts for checkout --conflict=diff3
Date: Wed, 6 Mar 2013 20:26:57 +0100
Message-ID: <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
References: <20130306150548.GC15375@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, kernel@pengutronix.de
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Mar 06 20:32:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDK4s-0004m5-Bv
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 20:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519Ab3CFTcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 14:32:06 -0500
Received: from mail-qe0-f46.google.com ([209.85.128.46]:34185 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab3CFTcD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 14:32:03 -0500
Received: by mail-qe0-f46.google.com with SMTP id a11so5659576qen.33
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 11:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=j4miy/ryb+cZv2YoNzg2xpx/kon8q4BWkpUOzuWd62I=;
        b=DG1k1fCNa9XhlPsZZVBr8YxAE79+RQpN/hWjglsHEL7wvNtL11BkE3SPjDPyQzkfHy
         tgIOKr5PHSiGitDQv8nEjXUxYGkGxaxXPPmq7MfU17/kzllBFaA6p8wseptsUHwkgDSZ
         5PbRe2YfVXQMyokAjVN29QBiVcMjHVyZGIbfx4MFelwpeQPWvGdnnFGEqNdgtkb4tTjU
         ITcgbx0XqLyjnGWoOEKzLf8CHc+PsFVSVl40e0PqYdUX2jDHZnG8LwlQdLePDf8kNACh
         AhI2RgoGOti2Xm3eDxSHxpX+TrYEj6HPCKmOBgTMjS2ApLUdv2p5dgUEVx0CmWLA/ya2
         wPjw==
X-Received: by 10.229.204.212 with SMTP id fn20mr8287730qcb.52.1362598017803;
 Wed, 06 Mar 2013 11:26:57 -0800 (PST)
Received: by 10.49.70.163 with HTTP; Wed, 6 Mar 2013 11:26:57 -0800 (PST)
In-Reply-To: <20130306150548.GC15375@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217539>

> however the difference isn't that easy to spot any more. I expected
>
>         diff --cc file
>         index a07e697,5080129..0000000
>         --- a/file
>         +++ b/file
>         @@@ -12,7 -12,7 +12,12 @@@
>           12
>           13
>           14
>         ++<<<<<<< ours
>          +15
>         ++||||||| base
>         ++=======
>         + 16
>         ++>>>>>>> theirs
>           17
>           18
>           19

This is not correct, it would mean that 12, 13, 14, 17, 18, 19 are in
base, while they are not.

Cheers,
Antoine
