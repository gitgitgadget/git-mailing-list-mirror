From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] git log -g: Complain, but do not fail, when no reflogs are there
Date: Tue, 24 Jul 2007 09:26:48 +0200
Message-ID: <81b0412b0707240026v4321a709wcbbbd7b67a4c506b@mail.gmail.com>
References: <Pine.LNX.4.64.0707240039300.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 09:27:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDEnU-0001p5-6n
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 09:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbXGXH0w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 03:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755110AbXGXH0v
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 03:26:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:15998 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbXGXH0u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 03:26:50 -0400
Received: by ug-out-1314.google.com with SMTP id j3so107939ugf
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 00:26:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UfOxm65Sr3P/e9IhcYEYx6ZzkmlzIYK/gpMP/cRk+zNTIUFXvEsxZDebCnu23oIc+1j7Z/34DHnsoC4vmCG2Bo8Z35wrYZN2VoWwRYOkNtB6pVpKj9EOwM5M8CGjJIska20QQ7nKFcdfBEBAnUHRgGIOlj6M5adacPCfqGT59Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n86y3/IrN2DOTpo4dAjTiU7+gshVufofa4qDlbPKy9rAXpPWROewNX9qvtUi98Xm/jJtoYmXIoXG28kfGUm4ZLeUdZP043Oc5A9gCodTkIMr/z+U2nju85ve2c9AJWK4nF0DahxyMc68HXp2dyXZu1dCwE7kIOyoz5yagHdwctU=
Received: by 10.78.123.5 with SMTP id v5mr986382huc.1185262009007;
        Tue, 24 Jul 2007 00:26:49 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Tue, 24 Jul 2007 00:26:48 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707240039300.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53529>

On 7/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> When asking "git log -g --all", clearly you want to see only those refs
> that do have reflogs, but you do not want it to fail, either.
>
> So instead of die()ing, complain about it, but move on to the other refs.
>

I believe you wont even see these complaints: the pager will start shortly
afterwards and fill the screen with commits, completely hiding the errors.
