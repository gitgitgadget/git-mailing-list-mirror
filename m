From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Efficiently detecting paths that differ from each other only in case
Date: Sat, 9 Oct 2010 17:00:10 -0500
Message-ID: <AANLkTinzH3EWy=E2H9hQJzCdPB3Epu5WQkmuv2CWKFtc@mail.gmail.com>
References: <AANLkTimGAbosbD0pprROu_g-UW38faotYA2dTxj9scsP@mail.gmail.com>
	<20101008135034.GC5163@sigill.intra.peff.net>
	<AANLkTik6pSJFUkY9sooSH7iANaKLhxdN+ouKRXJn1B9G@mail.gmail.com>
	<20101008195120.GA10810@sigill.intra.peff.net>
	<AANLkTimAhjHm5Z4ekTOBaxwzyw2YD6MrRnB1O8E6nAtw@mail.gmail.com>
	<20101008200657.GA10954@sigill.intra.peff.net>
	<AANLkTi=YQOVYsK6Brq5pMiAdrH3Un7RgrWvYf_pymT=d@mail.gmail.com>
	<m3aamng3dt.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 00:00:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4hSm-00045X-5T
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 00:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056Ab0JIWAN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Oct 2010 18:00:13 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41513 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab0JIWAL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Oct 2010 18:00:11 -0400
Received: by vws2 with SMTP id 2so250061vws.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F4fPpIp/ypnIICslIlg8GmOroBWA0AUH1X8hZzL+h3c=;
        b=czljI0sbUM+esEbbLxwdhOU/ts03ri9JESy8Rt72qkIv6fYVZYNcJEAmHYmUcrzcsP
         dwnnPKdgpPtGqRgnhdf3tIv/mr7t5A39+s8H9ed75NCE7WJX7bQAyo5+iwmfJEoBONJO
         JotPH57D1ZqoBBEDJgTvZB4uFLuaV//IaSS0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GOIhsiw774rUqz8+oR3K+yXwwOXbXg8fxZzYi6Fr/r3V6Dtzpr0ZmgUlu+gxvMhWqn
         IL+Qv0o9CC23hzl06ZZ6KrkZjFm7Z7Dz140yuHj+ejdSVggyPKv2bqpZViUVSc/7UROC
         cvZlUMDex4xGmCAeKjnMQ7lBGrW4cF5/hhnT4=
Received: by 10.220.195.196 with SMTP id ed4mr397742vcb.168.1286661610740;
 Sat, 09 Oct 2010 15:00:10 -0700 (PDT)
Received: by 10.220.187.9 with HTTP; Sat, 9 Oct 2010 15:00:10 -0700 (PDT)
In-Reply-To: <m3aamng3dt.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158630>

On Sat, Oct 9, 2010 at 3:47 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> Sidenote: why not detect violation earlier, by having pre-commit hook
> in each developer repository check for such violation? =A0It is not a=
s
> time sensitive on the local side (when creating a commit, you have to
> take some time to write commit message anyway).

That's a solution, but as you surely know hooks are not automatically
cloned with the repository. There's no way to ensure that all of our
many users install that hook, and we can't allow an incorrect state on
the central node.

A pre-receive hook on that node seems like the only way to really ensur=
e that.

D
