From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: 'Failed to create .git/index.lock'
Date: Mon, 15 Feb 2016 18:06:33 +0100
Message-ID: <5B9871D2-395D-4F0C-94FB-278832FCFD76@gmail.com>
References: <20160209075829.GA12331@inner.h.apk.li>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 15 18:06:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVMbh-0000nr-7w
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 18:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbcBORGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 12:06:37 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38328 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbcBORGf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 12:06:35 -0500
Received: by mail-wm0-f50.google.com with SMTP id a4so64791219wme.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 09:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yozpb9EIrdtknV5W7OVNbHfZawHjMPuzQvVIZjzkAd0=;
        b=NVobps7iL03WH0rPdu+Ij0+J70vCx38MI6HPVuAxDrsAacZlaajEZrMl1NTeiZ1Yao
         wWaUxTcfTKuJZFE5kwsdtOSNp2Mv7H8s5kq+QGSH4uxAelmfYybq0KzsTfCxyMSzrwbu
         b1l/90yhhpWLf7E9c8Uqem9IVlaShnNHzkcR7Ku8ygJgcb418/5k05Rp3mQm5kfLHTOV
         QrbpGA5VVb+fDiO4LJy/KEhOvZnURluT7PRoMAARlXMMGadtiA2xsz/wHidSC0NG7wob
         6iURPJmaRvG2dDxHNrtlHXtPtL9M0qaWKcIsyv1CXnPggWLJoywUIJ6a0xz0YXFN2BcC
         S1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=Yozpb9EIrdtknV5W7OVNbHfZawHjMPuzQvVIZjzkAd0=;
        b=JpVyLt1hRW2dS70IZZEWAeHKAHHltkjkCIcmFWUXGZmEMfdAEcYNpqVvyupYXZ6yWM
         W4Y9QtPukL6nW+dmD/wLz/WPAxBEisWBlOJkF1mdQjozjXYX1dcC0IIH8IHXCj/kYQuX
         6gnlGXzH4odWe9atzXhteN3ksdjWskclHI+WSWzA4i1O3VEJrYgWTTBGSpVxSptlSnYQ
         a1f2QMDNL8CAMDE7nN7LdgqNxIBtOSlB5//kUmWDaV6BfDiVu7ac193wxFskMavyhT77
         xLd+AO5RKmd+Yx9OyXqxsgcf6LMHsZN4LSkSOyr9g/tTsaLPmkSmHm6x8/ZbHJ3+IjTx
         IefQ==
X-Gm-Message-State: AG10YOQxs1Rjsjb5pb/unJFGIywOpRSrVvmQxlIDYyeHhqyWTNi2v+2wMx+CSsf1H1tICg==
X-Received: by 10.28.126.205 with SMTP id z196mr13198690wmc.44.1455555994432;
        Mon, 15 Feb 2016 09:06:34 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id i10sm16583946wmf.14.2016.02.15.09.06.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Feb 2016 09:06:33 -0800 (PST)
In-Reply-To: <20160209075829.GA12331@inner.h.apk.li>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286211>

Hi Andreas,

I am looking into a similar issue with SourceTree on Windows right now. However, in my case it only happens when I switch branches. I investigated the Git commands that SourceTree triggers and it looks like it is doing something like this:

(1) Run checkout command
git.exe --no-pager -c color.branch=false -c color.diff=false -c color.status=false -c diff.mnemonicprefix=false -c core.quotepath=false checkout MY-BRANCH

(2) Run rev-parse command 
git.exe --no-pager -c color.branch=false -c color.diff=false -c color.status=false -c diff.mnemonicprefix=false -c core.quotepath=false rev-parse HEAD^1

My assumption is that SourceTree triggers these two commands in parallel and sometimes (2) locks the repo first which makes (1) fail. Does your Git process run on Windows, too? Is there a possibility that you issue Git commands in parallel? I also have read that certain anti virus software can trigger these errors on Windows.

I looked through the Git code found that increasing "core.packedrefstimeout" [1] might help in some cases that trigger this error [2] but not in others [3]. In my case this seems to help. Maybe it's worth a try for you, too?

Cheers,
Lars


[1] https://github.com/git/git/blob/494398473714dcbedb38b1ac79b531c7384b3bc4/refs/files-backend.c#L2070
[2] https://github.com/git/git/blob/494398473714dcbedb38b1ac79b531c7384b3bc4/lockfile.c#L171-L178
[3] https://github.com/git/git/blob/494398473714dcbedb38b1ac79b531c7384b3bc4/builtin/update-index.c#L1156



> On 09 Feb 2016, at 08:58, Andreas Krey <a.krey@gmx.de> wrote:
> 
> Hi all,
> 
> I have a single workspace where executing merges
> occasionally leads to a left-over .git/index.lock file
> that prevents me from adding resolved conflicted files.
> 
> I'm running a sped-up integration/feature branch process,
> and the merges and conflict resolution are automated.
> But the index.lock thing is happening only in one repo
> of the three that are doing this.
> 
> Any hints as to debugging this?
> 
> (It is not a running background gc, the lock file
> is still around when there is nothing running
> any more, for hours.)
> 
> Andreas
> 
> -- 
> "Totally trivial. Famous last words."
> From: Linus Torvalds <torvalds@*.org>
> Date: Fri, 22 Jan 2010 07:29:21 -0800
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
