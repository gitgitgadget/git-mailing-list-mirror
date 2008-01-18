From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: What's not in 'master' but should be
Date: Fri, 18 Jan 2008 15:19:47 +0100
Message-ID: <8c5c35580801180619ub44a795tf4d8e2e12e02811a@mail.gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	 <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	 <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	 <8c5c35580801180215s2c980b4kbc66fbb05778ff67@mail.gmail.com>
	 <7vwsq7fn2e.fsf@gitster.siamese.dyndns.org>
	 <8c5c35580801180253x9022e62qf1ec515e101fb294@mail.gmail.com>
	 <7vzlv3e6fy.fsf@gitster.siamese.dyndns.org>
	 <8c5c35580801180354w74774fe2u1d96a8d12f513811@mail.gmail.com>
	 <alpine.LSU.1.00.0801181226130.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 18 15:20:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFs54-0001Vi-5A
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 15:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758962AbYAROTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 09:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758982AbYAROTw
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 09:19:52 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:43700 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758644AbYAROTu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 09:19:50 -0500
Received: by nz-out-0506.google.com with SMTP id s18so828353nze.1
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 06:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lsToYtLyf2GalTHSDQtpVhq2QhPcklr9g09WKIy09MA=;
        b=uAZJLFXoCOZvoor76oqgnTHZ3Xs36e7fIM8W0aPtlkraU2Ch3h2sQufbKQw2GcOWlPa/zU+0QXnewXAUmQTb8nZvxAlPoeB0/5M1JaxiPYkY7VMXuoPNpGWlrYfmfQNbQiA/FmKWtKJUIwCo7o6PKhpL2+p0bbkCF6iV100JSLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M2kqGRyJc2Ly0gUH+AVRGynFkxhTr1AHfG3+S1Igq0TV6evzcu/2COPxp3FX1ZhUDH1hu/7S1NPb9cjSbaHK4TrqYNwyhjRlOI4PS8GWMz52+DyZ7UbU/nJnU3Wlx5Hrtji1TmnZ4Ow59yCeOly8GDslSLhNbbqS6jt5pmlfz/k=
Received: by 10.115.75.1 with SMTP id c1mr1173026wal.84.1200665987149;
        Fri, 18 Jan 2008 06:19:47 -0800 (PST)
Received: by 10.114.241.8 with HTTP; Fri, 18 Jan 2008 06:19:47 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0801181226130.5731@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71021>

On Jan 18, 2008 1:34 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> So you did something that is unsupported, and now it breaks for you.
>
> I'd almost say: you should have expected that.

Yeah, it was bound to happen. The sad thing is that I didn't notice
earlier; I should probably add a test branch to cgit and run something
like this in a cron-job:

git checkout test && git fetch && git reset --hard origin/master &&
(cd git && git fetch && git reset --hard origin/master) &&
make clean &&
make test &&
git commit -a -m "Updated to latest git" &&
git push --force origin test

This should help catching this kind of "breakage" a lot earlier.

> [snip]

Thanks for the review and the kind words!

-- 
larsh
