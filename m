From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 00/11] Sequencer Foundations
Date: Mon, 11 Apr 2011 00:38:19 -0500
Message-ID: <20110411053819.GA6502@elie>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
 <201104110518.04413.chriscool@tuxfamily.org>
 <alpine.LNX.2.00.1104110031530.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 07:38:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q99pj-00021M-MA
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 07:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651Ab1DKFi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 01:38:29 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49299 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab1DKFi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 01:38:28 -0400
Received: by gyd10 with SMTP id 10so2035717gyd.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 22:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=H7HTWJgibGlcUXWwXCE/2PCti2wOIR6uUHQE0Oqghpo=;
        b=rTf8wfTi95RsfuYi1UhnjBjs+iyYOosjduFx2DWryqhZkgqRLUfwfzibuOGIBaQSH9
         RJ3YFY2uDxFr4ztCj20kG6HCqiu+9pyDuv/oeTpLe2Ql/MWio08zsTFG3V1+uz50Krix
         36mJogMkUrGENVEfUv+axF3Y+sFAeIYVS101c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qr4NETaBtbXOZL3uG9xz9pfiYUkAIlXn9bj2JU0C3DtddW5xChMcBF1rv7xeV6PAmj
         8rRGIOOqB0o8f+KyGId1s1i8R8UFUhSNnIlWsCCor5PM+y5NLE1gbHRxvpXZivhRrHDE
         ZMya87SUdVyxDsUAqdVtD+XfuO6x8kPZdhM7c=
Received: by 10.151.18.4 with SMTP id v4mr4136653ybi.265.1302500307225;
        Sun, 10 Apr 2011 22:38:27 -0700 (PDT)
Received: from elie (adsl-69-209-51-92.dsl.chcgil.ameritech.net [69.209.51.92])
        by mx.google.com with ESMTPS id t16sm2515684ybe.19.2011.04.10.22.38.24
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 22:38:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1104110031530.14365@iabervon.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171305>

Hi,

Daniel Barkalow wrote:

> But it's annoying that, in order 
> to finish a conflicted "git cherry-pick <branch>", you currently need to 
> go back and find the instruction that says to commit it yourself, with the 
> option "-c <sha1>" to retain authorship and message.

You might like v1.7.5-rc0~88^2 (Teach commit about CHERRY_PICK_HEAD,
2011-02-19).

> And if you want to 
> abort it, you need to remember "git reset --hard HEAD" (and maybe you also 
> want "git rerere clear").

Hm, I had assumed reset --hard (or "git reset --merge HEAD") would
take care of the "rerere clear" but it seems that indeed it doesn't.
