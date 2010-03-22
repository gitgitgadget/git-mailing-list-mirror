From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 22 Mar 2010 21:21:42 +0100
Message-ID: <fabb9a1e1003221321o34c6c63n8bf874e4259f19f4@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com> 
	<81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com> 
	<4BA544FC.7050007@gmail.com> <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com> 
	<4BA61CF9.7040104@gmail.com> <41f08ee11003212052p6b0a7495j2e38f24839541ffb@mail.gmail.com> 
	<m3hbo8jr2e.fsf@localhost.localdomain> <alpine.DEB.1.00.1003221910520.7596@pacific.mpi-cbg.de> 
	<fabb9a1e1003221138n50e30adaxe91ac9503932c35a@mail.gmail.com> 
	<alpine.DEB.1.00.1003222025220.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>,
	Bo Yang <struggleyb.nku@gmail.com>, gitster@pobox.com,
	gitzilla@gmail.com, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 22 21:22:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nto8t-0001RP-6i
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 21:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345Ab0CVUWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 16:22:06 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:57937 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab0CVUWE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 16:22:04 -0400
Received: by fxm23 with SMTP id 23so1158958fxm.21
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 13:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=AdGJpC1+k5C2TNn67Ry/Qiq5TX2XQGR/zTT2K+Plc/o=;
        b=gbvPHxWhccDSKCYqkQWFpj9rL0lbpVb+j2Imzu09aqzsWo2FwADri+Yt1/Hu57NV+z
         UGqOi7RjHjJBTBibezWPnGFCVQE0vLu/yOVBfbikZ06WInqj28gvkd401IaXNYiKhvGi
         EKq13u0YbCQCxC2ckybOBGBghxVGI+dyec7q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=U+ghxEbcrbNiBiXzLbM4mTgPS7nu/6hvzt2P6i0XfwgOoZTSN2bgcS8lkj6gNbGt3j
         WMjCssrkRbXegLzqfzYb393b4wAS9irQgy7a0OVPjh/g12g2wQkWphMvORk06mpaiZ97
         jdm+QFBRBpROvzcVmkA8VKVQ7nmN7OC1Sqre4=
Received: by 10.204.4.139 with SMTP id 11mr1946112bkr.27.1269289322268; Mon, 
	22 Mar 2010 13:22:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1003222025220.7596@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142964>

Heya,

On Mon, Mar 22, 2010 at 20:26, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Indeed. TBH, I wanted to ask you to assist in that part of the project.
> You probably can give a good overview over what does not work, and why.

Back then I think we even talked about teaching git log to find code
moves? I have some silly code online on repo.or.cz even. maybe.
Anyway, my main problem there was finding a heuristic that would give
a sensible answer both in small _and_ large moves. It might be worth
investigating two or more metrics instead, one that works for (very)
small chunks of code, and thus require an almost exact match, then
perhaps a somewhat linear function (the longer the block moved, the
more 'fuzz' you allow), and maybe after some size, say practical
full-file moves, use an algorithm similar to what rename detection
does. </brandump>

-- 
Cheers,

Sverre Rabbelier
