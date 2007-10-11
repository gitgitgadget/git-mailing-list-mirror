From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: git branch performance problem?
Date: Wed, 10 Oct 2007 23:26:24 -0300
Message-ID: <f329bf540710101926vedf8b19p52e3eeb193203d03@mail.gmail.com>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com>
	 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com>
	 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com>
	 <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
	 <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com>
	 <alpine.LFD.0.999.0710101610230.20690@woody.linux-foundation.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Lars Hjemli" <hjemli@gmail.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 04:26:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifnl1-0004fJ-35
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 04:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbXJKC01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 22:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbXJKC01
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 22:26:27 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:26875 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbXJKC00 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 22:26:26 -0400
Received: by py-out-1112.google.com with SMTP id u77so743711pyb
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 19:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yyRFjDW8/7kMIgjrKU6NchaDCyF3PCm/zYYjfHleweg=;
        b=pT3XT3V7epOkcxJuNvk4X1euMSzFuF6+nZSmqw9Mpf18QnKKkblw83oNzz6l32WzMF1lpsx0pzSDYhPx24o9EXxwkyD+ERN39iYqz7CLKfZEQuP4og7d6l56ofoSSz4Vn1aDDrmJvJsYJKbOgApZgPIBVGF67fxofg5hA5UIW2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WQWaVW7OqQE92Fln7H1azQ2Byzf2DGeLF86QHHUPzib+r3vrHV8Tku7YmVY90YWqHNVQxbHWkM/jqWL91dvScYEeNur1Nv34X5Ek4zmkapxzI/ZawNJJNRk14IuL+JcAL58/fptjbaQ1gWa7pj5trOszA2dvoE8k6IFZg4HSfZw=
Received: by 10.65.251.17 with SMTP id d17mr2908979qbs.1192069585056;
        Wed, 10 Oct 2007 19:26:25 -0700 (PDT)
Received: by 10.65.157.11 with HTTP; Wed, 10 Oct 2007 19:26:24 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0710101610230.20690@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60578>

2007/10/10, Linus Torvalds <torvalds@linux-foundation.org>:

> IOW: alternates are dangerous. A shared object directory is dangerous. You
> should basically only do it under very controlled circumstances, and
> otherwise you should use either hardlinks or if you want added safety,
> totally separate repositories.

I recall reading a few months ago that it was "clone -l" that gave you
the jeebies, rather than "clone -s".


> So the rule really is: never *ever* do anything but fast-forward in a repo
>[..]

Methinks this is all too difficult. I will use clone -l henceforth. Is
there any reason to prefer -s over -l? Given your lengthy exposition
on the dangers of alternates, I would say this is a features that
deserves to be buried or at least deemphasized in the documentation.

For cherrypicking convenience, I would still appreciate it if there
was a mechanism similar to alternates that would allow me to view
objects from an alternate repo; objects found through this mechanism
should never be assumed to be present in the database, of course.


-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
