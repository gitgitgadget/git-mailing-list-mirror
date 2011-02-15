From: Adam Monsen <haircut@gmail.com>
Subject: release maintenance vs. release engineering (was: configuring cherry-pick
 to always use -x?)
Date: Tue, 15 Feb 2011 13:03:43 -0800
Message-ID: <4D5AEA2F.9000606@gmail.com>
References: <4D596435.9020605@gmail.com> <AANLkTimi=d0qbO3_-BEnPEJ+iy9B=_fksF7TiBE7HorC@mail.gmail.com> <4D59A39C.9090402@gmail.com> <4D5A401B.1050103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 22:03:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpS3u-0000oQ-KH
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 22:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263Ab1BOVDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 16:03:50 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48523 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab1BOVDs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 16:03:48 -0500
Received: by pva4 with SMTP id 4so86955pva.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 13:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=QbsGnl9VpzYgT0f1x3vfOTuysLh17+pxRhiHYDVIlGg=;
        b=HHqd0pM/XzsQXPIuFxLTDcwHJcSLMUzlR6f+eKU3CQ1Rexry9NSZ4L0YAHp9edSnxn
         qt1zDJ6ka5yMN7QbLqqSbCFoEeGGaWe9wfkDxHKlZjn9bZpi2iaU73BH/7y0rCrEnqxb
         j7dwSuIarAhc3gmULdipiocNBXa1A0oJeOnkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=c7JWKy0niQ++xGi8JgImWlY8BCIVi9Jwm6QDqLpex+lF3XBEKdd4iag1Gx94XcGPyB
         MIpxZx8AOTNDC3zK6ZI7Hf5h8RrY6SXWmIdaWWPLfBJQdl/tibL1oEf6v/xFpudIVRCt
         l6hZqriDk2s4kFbjqNE94kVKHu9tSyDTzlQgQ=
Received: by 10.142.147.13 with SMTP id u13mr4613474wfd.108.1297803828226;
        Tue, 15 Feb 2011 13:03:48 -0800 (PST)
Received: from [192.168.13.8] (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id v19sm6187975wfh.12.2011.02.15.13.03.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 13:03:47 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <4D5A401B.1050103@drmicha.warpmail.net>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166876>

Michael J Gruber wrote:
> I don't quite understand how cherry picks could conflict less then
> merges if the release branch contains fixes only.

The last time I experienced a painful merge from f-release to master, it
was because some files had been culled from master but left extant on
f-release. Not too hard to resolve, actually. But I really only needed
one change pulled into master, and when I cherry picked instead of
merging the whole branch, there were no conflicts, and master ended up
containing exactly what I wanted.

> My impression is that "f-release" actually
> mixes release engineering and maintenance. Two possible remedies:
> 
> - Separate release engineering from maintenance and merge only the
> latter to master

Ah, thank you! This is invaluable advice. I think I'll go with this
option since mixing release engineering and maintenance is exactly what
I'm doing. Hopefully it's worth the added complexity of having another
public branch.

I pushed an example to https://github.com/meonkeys/releaseBranchDemo
that I'll share with my developers.

"git merge -sours" will definitely be something useful to add to the
quiver too.
