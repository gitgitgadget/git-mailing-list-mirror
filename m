From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 15/18] the beginning of the signed push
Date: Wed, 20 Aug 2014 08:57:51 +0200
Message-ID: <CAKPyHN0Q2bCiNy0goxZ7YnmPjbU9fyjpWYmPF8gKz8T862jvAA@mail.gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	<1408485987-3590-16-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 08:58:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJzqh-0007hr-PK
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 08:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbaHTG5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 02:57:55 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:38520 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbaHTG5w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 02:57:52 -0400
Received: by mail-vc0-f178.google.com with SMTP id la4so8680669vcb.37
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 23:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1X3DHH3oCqKBM01T5Lnzyc9QkvQ8lAm8Z6Ml3NQcVDY=;
        b=UAI03qECabilswpCMx7mDlDNpctMup9vMnR7Ip3B0YvQ3uMV/rtnSO8Zge+f070sPe
         m3FCIUmQY8RaxFxOnf0TuX7kGa7uyJ6/kpZNiDh5ZuJRrXrCEFOlsaaYVpIBdP3nEBEr
         6o+AW2LKEmeil4d77OIMsAICko5co4cujDcJFmy/2hu5tJskOMjDq/oCgGggJTm2LkxR
         ugIXa+ma6A/znUCDX8LEUMi9DWb7v67rWvIDv4xNlJdwSNBAmAvAxpGisBDvXSPUq5Xr
         qEMRkthWe1/33HAUIWKx5/cOP75csL7F9SwT4hlGGLM7kk/CrViG0vz4scbOGfRRnnnL
         Zlbw==
X-Received: by 10.52.61.136 with SMTP id p8mr4904911vdr.15.1408517871595; Tue,
 19 Aug 2014 23:57:51 -0700 (PDT)
Received: by 10.220.177.72 with HTTP; Tue, 19 Aug 2014 23:57:51 -0700 (PDT)
In-Reply-To: <1408485987-3590-16-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255554>

On Wed, Aug 20, 2014 at 12:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The basic flow based on this mechanism goes like this:
>
>  1. You push out your work with "git push -s".
>
>  2. The sending side learns where the remote refs are as usual,
>     together with what protocol extension the receiving end
>     supports.  If the receiving end does not advertise the protocol
>     extension "push-cert", the sending side falls back to the normal
>     push that is not signed.
>

Is this fallback silently? If so I think it would be better to abort
the push, if the receiver does not support this but the user requested
it.

Bert
