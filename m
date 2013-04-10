From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 08/20] remote-hg: split bookmark handling
Date: Wed, 10 Apr 2013 14:14:32 -0500
Message-ID: <CAMP44s3VcUyQUNBw+19O-_nf9HPWt=2uc35Keh6Z0jcgFF=Y7A@mail.gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
	<1365441214-21096-9-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 21:14:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0Tg-0001XB-Bz
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759240Ab3DJTOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:14:35 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:45258 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab3DJTOe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:14:34 -0400
Received: by mail-lb0-f172.google.com with SMTP id u10so894198lbi.17
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=mG1B1QoFim16fKswpeVwB//T8LtAb5mUlTR2JtCjH/o=;
        b=ORduBVPAp0Qi647nsoBcCFL5wWCG3QwCnUS7ndl6B+TbOFbZbGcnK9vEcCMx6moQD3
         q/Cy7e6Sm/M5Q6vw3TzDaYIVURgB95v4fBCgQrRU3SzdgDRARTSpg8+rWA1oSj/MuTIb
         +bJIToHNRdsc/4nQDW5mniOkbVBzTHDbuPPI7zxkg1zegKeOVZxEDcivgo+yT3PZC+6o
         /FcV552UJNmKpnJxzDZqJ6iyX5tanVlWFrRD4Y9pkMXiY4Z7UgPCN53vhzrvkNyJCMMR
         jWvFHlAbN7MsIkKCUbuVZJSBop3yAHnq4i0htsXB/DxBpz+pr45MZXEaF2oy0zuwv7mA
         LtFg==
X-Received: by 10.112.59.68 with SMTP id x4mr1765772lbq.121.1365621273155;
 Wed, 10 Apr 2013 12:14:33 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Wed, 10 Apr 2013 12:14:32 -0700 (PDT)
In-Reply-To: <1365441214-21096-9-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220729>

On Mon, Apr 8, 2013 at 12:13 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg

> @@ -731,6 +722,26 @@ def do_export(parser):
>      if peer:
>          parser.repo.push(peer, force=False)
>
> +    # handle bookmarks
> +    for bmark, node in p_bmarks:
> +        ref = 'refs/heads' + bmark

This should be:

ref = 'refs/heads/' + bmark

Should I reroll?

--
Felipe Contreras
