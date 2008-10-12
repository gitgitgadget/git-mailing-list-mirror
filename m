From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: tip tree clone fail
Date: Sun, 12 Oct 2008 14:04:05 +0200
Message-ID: <8c5c35580810120504o4423560aodd8d58e9e9ae322c@mail.gmail.com>
References: <48EEA714.4010205@cn.fujitsu.com> <20081010072951.GB16016@elte.hu>
	 <20081010083720.GA32069@elte.hu>
	 <alpine.LFD.2.00.0810101040200.3271@apollo>
	 <48EF14FC.1000801@cn.fujitsu.com>
	 <alpine.LFD.2.00.0810101046260.3271@apollo>
	 <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com>
	 <48F1DF6A.4000900@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@elte.hu>,
	"FNST-Lai Jiangshan" <laijs@cn.fujitsu.com>,
	"FJ-KOSAKI Motohiro" <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Wang Chen" <wangchen@cn.fujitsu.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 14:06:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kozhg-0005Xe-Hm
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 14:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbYJLMEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 08:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbYJLMEJ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 08:04:09 -0400
Received: from rn-out-0910.google.com ([64.233.170.184]:38734 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbYJLMEI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 08:04:08 -0400
Received: by rn-out-0910.google.com with SMTP id k40so658923rnd.17
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 05:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=qlnyxDB79hnoGcKPMgq63/K/mBZIbUL4tVBgPRhWb6U=;
        b=npQJxtTCzn1FW+UF3BDvA2BNR2U+XFQ69GeWzrSMU+SxMeXfOiTMCL5xZ7/SolAfMC
         0Dn6s3tXLts/6OxH5S2XQ2gQNrMSZlUBaRustfCnUHDERspUaH470bY3Su9RZXhIjwDa
         UKVu+iwgtxjRslb4EDMP+rYVm4tj46PaYgg6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=Cd8Znkl7smal0wpFQDMXxpeQZDz4o7rr88yPJ8tu3lgIz7sCdtZW8nZv3xaMj58vuV
         TzvKTPi1RswtZY27pmorYlawAdf7GcLYBIjwB4f6E8m2H30LKJgykFYC3l1t/R5DYK+k
         VilAeHjEUzbqfm/8o52RyRW23sbbukxPI/2yI=
Received: by 10.151.42.10 with SMTP id u10mr5748495ybj.93.1223813045800;
        Sun, 12 Oct 2008 05:04:05 -0700 (PDT)
Received: by 10.150.96.16 with HTTP; Sun, 12 Oct 2008 05:04:05 -0700 (PDT)
In-Reply-To: <48F1DF6A.4000900@cn.fujitsu.com>
Content-Disposition: inline
X-Google-Sender-Auth: ca5dcc6b42e54b5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98015>

On Sun, Oct 12, 2008 at 13:28, Wang Chen <wangchen@cn.fujitsu.com> wrote:
>
> H. Peter Anvin said the following on 2008-10-10 23:58:
> > Wang Chen wrote:
> >>>
> >>> So http transport is wreckaged. (git version 1.6.0.1 here, Wang is using
> >>> 1.5.3.x)
> >>
> >> My git version is 1.5.5.1, although it doesn't matter ;)
> >>
> >
> > http transport requires that "git update-server-info" is done after each
> > push.  Otherwise, it ends up in a trainwreck.
> >
> > Shawn Pierce at Google is working on a long-term solution, but in the
> > meantime, if you have to use http transport, murder your IT people.
> >
>
>
> So, the current solutions are:
> 1. Waiting for Shawn fixing it.
> 2. Asking Ingo to "git update-server-info" after each push.
> 3. Murdering our IT people.

4. Install cgit, which removes the need for `git update-server-info`

--
larsh
