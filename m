From: David Lee <davidomundo@gmail.com>
Subject: Re: Separate default remotes for pulling and pushing
Date: Mon, 9 May 2011 12:01:53 -0700
Message-ID: <53DAF1E7-9906-4BF4-A64B-FE16BF5977F5@gmail.com>
References: <1FDDE878-C81A-4318-836B-7F8BED51A981@gmail.com> <BANLkTinJDUa7sXjKHo81bG7KbnspxZ88oA@mail.gmail.com> <20110509081708.GA5871@sigill.intra.peff.net> <D0FA0C3F-8DA8-4607-A0A6-F9AFAB3EC3CE@gmail.com> <20110509111019.GD9060@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 21:02:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJViU-0007rS-FX
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 21:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab1EITB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 15:01:57 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:61302 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab1EITB4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 15:01:56 -0400
Received: by pxi16 with SMTP id 16so3763421pxi.4
        for <git@vger.kernel.org>; Mon, 09 May 2011 12:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:mime-version:content-type:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to:x-mailer;
        bh=DaVCb0FUB7HWoQS+RJrYILopitHwPIsPP7XIdWnsCPY=;
        b=wOh0v9RnWAOvAjV2JGMyNGfSlMDu4NcSkRwug3ig9fjXFM9T3j96RVbFlLWNJbSEtG
         2GGNvfL3N4Exx84CsaEgRHwv+qeKm2lGfJMGXpF4D3jCg+SHc47QZqjaX/2gtCwLoEvK
         XVbBDphkhW80Qmxdwo4xmi2HwAZGah7jvkA0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=jKEKp35Mb6Ul+gl4RV0J23vBiVzuhV9Q5bHZuPpiPpAY0G52k7k9xOI0YTXt/FJnU7
         d9ukGl/r6XjGx0/LEgrR81wHiW5PzHZVvKavd4+Zyqd8PuzJf27r5fOHp39yLrkHN7Jq
         E1njvo9eBWK6mMCqrwfw+PDbOX5R8L3uA6v40=
Received: by 10.142.61.33 with SMTP id j33mr3841955wfa.368.1304967716279;
        Mon, 09 May 2011 12:01:56 -0700 (PDT)
Received: from [192.168.104.235] (207.47.25.98.static.nextweb.net [207.47.25.98])
        by mx.google.com with ESMTPS id p40sm8444394wfc.7.2011.05.09.12.01.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2011 12:01:54 -0700 (PDT)
In-Reply-To: <20110509111019.GD9060@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173249>


> But now we have precedence questions. If I have config like:
> 
>  [push]
>    defaultRemote = my-mirror
> 
>  [branch "foo"]
>    remote = origin
>    merge = refs/heads/master
> 
> which remote should be the default for "git push"? Obviously if I'm not
> on "foo", it should be my-mirror. But if I am, should push.defaultRemote
> take precedence? Should there also be a branch.*.pushRemote config that
> takes precedence over branch.*.remote?
> 
> I have to admit that I have never found the branch.*.remote config to be
> useful for any of my workflows, so I am not really sure how people use
> it.

What about removing the branch.*.remote config by default, and if it's not set, then it defaults to whatever the repo-wide setting is for defaultRemote? Then a branch.*.remote would override the defaultRemote, and a branch.*.pushRemote would again override that.