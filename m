From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Creating objects manually and repack
Date: Fri, 4 Aug 2006 10:40:50 -0400
Message-ID: <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
	 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>
	 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>
	 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>
	 <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 16:41:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G90r9-0007Kv-PY
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 16:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161232AbWHDOkw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 10:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161234AbWHDOkw
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 10:40:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:22598 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161232AbWHDOkv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 10:40:51 -0400
Received: by nf-out-0910.google.com with SMTP id x37so1073694nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 07:40:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cm18/yo5TkmgnT5rNTI1iFh+O8WZnGUfIwbm31w532EGrmOdnV6CCYXvMBGDlIJJ7mB6qKmIY/l+zkgt3zpz7EpYkjg/skHUkdT1xVFqiqFgjQs3+c/MslKmgwJk50omAWdRkWoNvYdzdCr3+3AHUY7xeaN4y91NGfEZ2KWGTS0=
Received: by 10.78.133.10 with SMTP id g10mr1579946hud;
        Fri, 04 Aug 2006 07:40:50 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Fri, 4 Aug 2006 07:40:50 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24791>

One thing is obvious, I need to tune the repacks to happen before
things spill out of the cache.  git repack-objects has been chugging
away for 2hrs now at 2% CPU and 3000 io/sec. It is in one of those
modes where it went back to get the early stuff and in the process of
getting that it knocked the later stuff out of the cache basically
rendering the cache useless.

I'm making good progress with this. I have hit two bugs in cvs2svn
that I will need to get fixed. cvs2svn is claiming two of the ,v files
to be invalid but to my eyes they look ok.

-- 
Jon Smirl
jonsmirl@gmail.com
