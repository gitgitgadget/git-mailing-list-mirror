From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Restoring timestamps (Re: Branches & directories)
Date: Mon, 22 Aug 2011 16:01:41 -0500
Message-ID: <20110822210141.GA3880@elie.gateway.2wire.net>
References: <CAMOZ1BtOkwVbC3RyJVQb7K1DRMnJf3_omn7zrkzoE48Ayu7HBg@mail.gmail.com>
 <CAE1pOi0jZT_HCEV8UDzEOQeuCcDeqxoKGUEk3bJm=O2eJSHfkg@mail.gmail.com>
 <CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com>
 <CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com>
 <CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com>
 <CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
 <CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
 <CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
 <CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
 <CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 23:02:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvbdd-00015j-GF
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 23:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096Ab1HVVCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 17:02:25 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:57984 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab1HVVCY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 17:02:24 -0400
Received: by qyk38 with SMTP id 38so1592794qyk.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 14:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xpZdCw0OSUXvLiaM2Tbb6DSSd2j5mTABM1GjDIZISZk=;
        b=Vg1getueTcpBpAMLAsFtxwapy6gSr9kjawB0NPIwCrxeILCaTyStDT/7viDtRyGn+Z
         QI8kLbsCB8iW/aZ6+BiL7GNSrD8NSQCHW1ALg7nCuMZS8wdfSIAiIenI1+SY48kSGeSe
         LiKwxPQHUxkkmqv9a/jFoOZyvmsYXz3lZVgIQ=
Received: by 10.229.37.78 with SMTP id w14mr1669607qcd.204.1314046943295;
        Mon, 22 Aug 2011 14:02:23 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-106-27.dsl.chcgil.ameritech.net [68.255.106.27])
        by mx.google.com with ESMTPS id s9sm314493qcx.14.2011.08.22.14.02.21
        (version=SSLv3 cipher=OTHER);
        Mon, 22 Aug 2011 14:02:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179891>

Hilco Wijbenga wrote:
> On 22 August 2011 12:31, Kyle Moffett <kyle@moffetthome.net> wrote:

>> (1) The GIT data-structures simply have no place for file timestamps, and
>> "git stash" is simply a special way of dumping files into a temporary commit.
>
> That's what I thought. The "intentionally" threw me off. It's not
> intentional, it's just a side effect.

For what it's worth: no, it's intentional.  See, for example:

 http://thread.gmane.org/gmane.comp.version-control.git/1564/focus=1680
 https://git.wiki.kernel.org/index.php/GitFaq#Why_isn.27t_Git_preserving_modification_time_on_files.3F

That said, something being intentional does not necessarily mean it is
always _right_.  So, for example, patches to allow a commit to store
some timestamps, with documentation explaining when this is
appropriate, would probably be welcome.  Maybe a good place to store
such information would be a dotfile alongside the file (so old,
unaware git versions could extract the same information without fuss).

Even if this feature were implemented just for "git stash", personally
I would turn it off so "make" could continue to behave as I expect it
to.  But in principle, I don't mind the idea of it existing. :)

Hope that helps,
Jonathan
