From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Don't do status in submodules if status.SubmoduleSummary 
	unset
Date: Thu, 20 May 2010 21:34:18 +0200
Message-ID: <AANLkTikQDEwA7Iih9hniYzLfSGnPvZ9PTDNtSKfJPa9d@mail.gmail.com>
References: <AANLkTil1QHA3G2VaITdm7DkDmN1IhZ_u2SWLrelyxkF2@mail.gmail.com>
	 <4BF57538.5040204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu May 20 21:34:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFBVu-0007iP-G7
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 21:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757003Ab0ETTeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 15:34:21 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64501 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757006Ab0ETTeT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 15:34:19 -0400
Received: by gwaa20 with SMTP id a20so102203gwa.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 12:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=q2eAK06AraYm9kcZd3iu9/GmaTMuxyXeV5AADPP1nWw=;
        b=lh53dLwa08FI+8TqaKURwPMUUd7avwcBtxOyuj31vTxeNZINWrYc7UW1YYRofw2z0x
         OET2VhtlkiuKG/sTCMmc+QPrGdh/WGlVw5Ks4/tcDO/1sN0h9hDMyhviM96z7juGaXQq
         WV1v6xzaDzwGx9jxli3u+Xfqo7G9Q5YeUof/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fXit3xXrb1dghTEbf4YjZguqjqfykJoShCjWxJtdxTMolg/ckOEk+gxs7h0Kqa7uHt
         6Yvemtfy2AIyRkRxGDyFfkiMH65WeuXXNE8DeD94ace+q3/ExqIiHOTMEJyk3hSRFgeu
         z5IjAhLbtJiy69X0D+UujjQGeNMlo43RsQMGc=
Received: by 10.101.105.22 with SMTP id h22mr719555anm.35.1274384058399; Thu, 
	20 May 2010 12:34:18 -0700 (PDT)
Received: by 10.100.154.8 with HTTP; Thu, 20 May 2010 12:34:18 -0700 (PDT)
In-Reply-To: <4BF57538.5040204@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147413>

On Thu, May 20, 2010 at 19:45, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 20.05.2010 16:12, schrieb Alex Riesen:
>> Maybe because we do a (kind of) gentle status run on submodules
>> whether the status.SubmoduleSummary set or not.
>
> Yup, because checking a submodule for its dirtiness has to be done
> no matter if the summary output is also wanted.

Yeah. Why?

>> Usually a background
>> run of "git status" for every submodules goes unnoticed, just
>> sometimes a submodule is a little too big.
>>
>> I tried this, but feels like a bit of overkill.
>
> This patch seems to disable submodule output completely for the default
> case (when status.SubmoduleSummary is false) and breaks 17 test cases.

That's why I said it feels like overkill
