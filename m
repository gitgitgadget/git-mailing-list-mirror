From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v3 0/2] gitk: changes for the "Tags and heads" view
Date: Thu, 28 Apr 2016 08:42:11 -0400
Message-ID: <CANoM8SXZjcDxrNoosk2agzq=nq_MnenoRtDMbY414o50OtzWig@mail.gmail.com>
References: <1459091168-46908-1-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Rappazzo <rappazzo@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Thu Apr 28 14:42:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avlHB-0000iv-2S
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 14:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbcD1Mmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 08:42:33 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34551 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbcD1Mmc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 08:42:32 -0400
Received: by mail-io0-f194.google.com with SMTP id d62so11821720iof.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 05:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ycfvOSe3LmqulvgkjnX2xWBd9kvkc3IHIKh9nMmfO7s=;
        b=kH83nGL2ljHEcJfvPEOprzrk5PaxbqgwQDioW4EXRKuDXDHyCBDqvLr3xSeZih6h3I
         PhWzFCJ4Yc2o9yZesmmX3RcPeXxmXnMEojAjDaElinpY4sLj65NCj80FzlbgVIibu7Op
         +3/fsGpVkBBPYYOEeF7ijRjsNMPExxZd5DEfsFoQRY7/TGYUdy+07mNWzLfDnj7aZJdr
         FzWpXr9og8+s/vsMEWjM48KDqMypA6ChyI5qLSBNYAlRzJZCw3vDtfyqhpPnDH+302I7
         ddm2eUbHwSr5hKbssG7IjTcGDuez6pYBVSIAwa8Z98mUrVUFnAP5Vo3QDoYW9XiTa94b
         LG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ycfvOSe3LmqulvgkjnX2xWBd9kvkc3IHIKh9nMmfO7s=;
        b=e1Qzoe+vuKkZfrtuNnl3Jk6iPkDwUeow3fT571qE0O2Yrspa07CZ1DPdrzfqgzIUz1
         1hvqNFx8GS5axDit+Xno+Vqe1Zt0rx3lbQ/L4q+e+wZvV5mF1E94nJcJnJoPJzi428MQ
         MFpOlnsKlchonrpXBTC1rDw3BBbbSaFUM1f27ex9B7Lkhqdh8xmDVbAiFxTOD99d+zbj
         NZkW1++oSJHelI1Fhmt5/Zh7BSb/WHJSRtGmULHcMsCEHxYWIpIiUAJHaNLh9K2E0hbm
         p/T8z+6Gw2CNnu0uKGmjYgVrELN522uhQrLjf7erCAsIiGQFhTJp5aawC4CUO/Fd7/6w
         uVuQ==
X-Gm-Message-State: AOPr4FUywnQAGjxsuURQxdkDUPs88OjTwEArQv7hK5ctfrK7V6pQmvoCOfEmyIZoWX5gXi23Ff6ER55bGY7pKQ==
X-Received: by 10.107.136.223 with SMTP id s92mr19451770ioi.109.1461847351245;
 Thu, 28 Apr 2016 05:42:31 -0700 (PDT)
Received: by 10.107.7.220 with HTTP; Thu, 28 Apr 2016 05:42:11 -0700 (PDT)
In-Reply-To: <1459091168-46908-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292873>

On Sun, Mar 27, 2016 at 11:06 AM, Michael Rappazzo <rappazzo@gmail.com> wrote:
> Changes since v2[1]:
>  - Instead of getting the remote info for each local branch individually,
>    grab it all at once and store the result
>  - Instead of a command line option to enable the new sorting option,
>    enable it with a preference which is stored in the config.
>
> v1 can be found here[2].
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/289244
> [2] http://thread.gmane.org/gmane.comp.version-control.git/288544
>
> Michael Rappazzo (2):
>   gitk: alter the ordering for the "Tags and heads" view
>   gitk: add an option to enable sorting the "Tags and heads" view by ref
>     type
>
>  gitk | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 66 insertions(+), 13 deletions(-)
>
> --
> 2.7.4
>

I am still looking for comments on this patch.

Also, is there a 'pu' repo for gitk?  Currently, I am only tracking
git://ozlabs.org/~paulus/gitk
