From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Re: rebase -i: explain how to discard all commits
Date: Thu, 20 Jan 2011 13:57:26 -0600
Message-ID: <20110120195726.GA11702@burratino>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
 <20110116015941.GA28137@burratino>
 <20110116020207.GC28137@burratino>
 <20110120193923.GA14184@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com, Kevin Ballard <kevin@sb.org>,
	Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jan 20 20:58:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg0dr-0007Kx-4E
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 20:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137Ab1ATT5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 14:57:55 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46378 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab1ATT5y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 14:57:54 -0500
Received: by wyb28 with SMTP id 28so999443wyb.19
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 11:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OTN8psAj/jOiJPsSx2M4qoEktlmotWzgLzvxD8UiQXM=;
        b=XQ4AApM91NKi2nho2DFUDst6B3+jvjG17Iz6N7/ef+X8Jc2FLZEqc5I31oHYh0NC/Y
         RRQtGlpO11DoqYojAH5ensxlrKhjvsEwqO2hk6fWNK5Vk6SyuBMYwxUElCm3/XGj69oG
         6S0Ctp3lzlzrHVnlKn43pUAsnahM/T5Qplf38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=B2hQVnX2JTCjrtFO2qzU24ZT+CLzikQgxp+Fy2YcVNT4OckEXWHtRI5AvoeWv65tJy
         OscZhYq9htwbT5u03BoODcNnIKZYwnbRonTY2LEL6S7qN0bjC+unLZOLFa82dX2VILQA
         psNXmbXgbFJq2ybc8p4wquPO/A/MA8Dcg+xDw=
Received: by 10.227.132.209 with SMTP id c17mr2885085wbt.135.1295553472910;
        Thu, 20 Jan 2011 11:57:52 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id m13sm6272366wbz.3.2011.01.20.11.57.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 Jan 2011 11:57:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110120193923.GA14184@vidovic>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165327>

Nicolas Sebrecht wrote:
> The 15/01/11, Jonathan Nieder wrote:

>> This is a follow-up to v1.6.0.3~21 (rebase -i: do not fail when there
>> is no commit to cherry-pick, 2008-10-10).
[...]
>>  # However, if you remove everything, the rebase will be aborted.
>> +# Use the "noop" command if you really want to remove all commits.
[...]
> Sorry, I think it is confusing. With this help we could understand that
> the "noop" will either
>
>   (a) discard the interactive rebase
>
> or
>
>   (b) _really remove commits_ from that branch
>
> I'm not sure to know how it will act myself. If (a), we could use
> something like
>
>   "However, if you remove everything or use the "noop" command, the rebase will be aborted."
>
> but if we are in case (b), I guess it is not necessary and we should
> point to the 'git reset' command.

Okay.  I agree that my particular wording was confusing.  Are you
saying the "noop" command in general is confusing?

The "noop" is itself a non-operation; if you combine "noop" with other
instructions then the noop itself will have no effect.  Meanwhile if
you have _no_ instructions then the rebase is cancelled, while if you
have a single "noop" instruction, that means "I have discarded all the
commits, but please rebase anyway".

Jonathan
