From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH/RFC v4 01/16] GSOC remote-svn
Date: Sat, 18 Aug 2012 20:06:14 +0200
Message-ID: <8572000.QUVXl8yetS@flobuntu>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <7v4no0u950.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 20:07:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2nQe-0004w2-Fw
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 20:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab2HRSG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 14:06:27 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54661 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab2HRSG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 14:06:26 -0400
Received: by bkwj10 with SMTP id j10so1561912bkw.19
        for <git@vger.kernel.org>; Sat, 18 Aug 2012 11:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=Flg5inMZ2f95mNIUEay9kaxaRuLxMA88yslx0XUToyk=;
        b=ONwQ/kh4tZmujh0ZkZtZ7L/rpJaNqu08gQyehEfkLr0pfI+KndTm+QkKnnUbqBxECx
         L6ft50lZlR0jhCMhMTvIKd0cJKSFovoPEjmGJIqirLR0gCHD99sNBEyDbzIRAGK7/SP6
         00bOE1IUePyg7Xz0hmg40sgywmR+qGrRJIkwfmWaR2s/o7S+jrzUHh4mVmQmOmWcNerl
         qbw+h6DR/Li7d3Yg9d/MIckCf/8Gtjz1UouiZ1yeWjgECKhAy5ejGwBm1BamOhglP3e/
         x7phWyxkSZ8bTD7xvLjHdQ7Fh8z8jEtjHP9+bUjOtSpAA9KG6yLtGaZk3ONJxGc7b+mR
         Ct5g==
Received: by 10.204.130.146 with SMTP id t18mr3107473bks.65.1345313184440;
        Sat, 18 Aug 2012 11:06:24 -0700 (PDT)
Received: from flobuntu.localnet (93-82-148-70.adsl.highway.telekom.at. [93.82.148.70])
        by mx.google.com with ESMTPS id hg13sm4557632bkc.7.2012.08.18.11.06.15
        (version=SSLv3 cipher=OTHER);
        Sat, 18 Aug 2012 11:06:23 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-29-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7v4no0u950.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203687>

On Friday 17 August 2012 21:16:59 Junio C Hamano wrote:
> Comments from mentors and people interested in remote helpers?
> 
> I did minimum line wrapping, typofix and small compilation fixes
> and queued these on 'pu'; I think I saw one commit whose message
> I didn't quite get what it was trying to say, and another that was
> missing S-o-b (I left them untouched).

Should I provide a better version? I found the commit that I forgot to sign-
off, but I'm not sure which message you mean.

> 
> The result merged to 'pu' seems to fail 9020, by the way.

That's because contrib/svn-fe isn't built automatically if you call make in 
the toplevel dir. 
It dies with "fatal: Unable to find remote helper for 'svn'", because the 
helper is not built. We currently need to run make in contrib/svn-fe 
seperately.
That's a bit awkward.

Just checked how it works for svn-fe. It has a seperate test program (test-
svn-fe.c) which is in the toplevel dir and built here, while for svn-fe 
itself, it's the same as for remote-svn. 

Don't know what to do about that.

> 
> Thanks.
