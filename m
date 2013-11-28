From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: How to resume broke clone ?
Date: Thu, 28 Nov 2013 15:50:02 +0700
Message-ID: <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com>
 <5296F343.6050506@gmail.com> <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com>
 <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com> <5297004F.4090003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: zhifeng hu <zf@ancientrocklab.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 09:50:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlxJ4-0007KB-AU
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 09:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756824Ab3K1Iuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 03:50:37 -0500
Received: from mail-qe0-f50.google.com ([209.85.128.50]:38447 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756591Ab3K1Iud (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 03:50:33 -0500
Received: by mail-qe0-f50.google.com with SMTP id 1so6592217qec.23
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 00:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=f9MnS1qFxKfGAtA+K7XdgREfFcfRNtTVvjqAGpEgA1o=;
        b=c5URU/Dyj+Ov/ndy577HOpVBfuoSPnObxYyiZmuzDJrOyxWyUj447k2DOf40GvnnBx
         L4uKyRYyazZ9OIAwwDqjB5Ihlcg++nMAbSaBxYxd8pgGQSs+ZqNNMAWMJdVvT9lPG1Fm
         bVXO15YOp2O7lUfch9HWvaxpjOPghGJ8ASvmqQQ45d0tJIPiZb8jKy7irdJXRoln3L4k
         uKtsQHX3PWJPsCarJ2yFLwJBYUAjHskexsd9NUrMv2gUDRgGuO37cQol64QRuFPdlDEG
         rhR56KlKOUYcjtTlpz4f3+ytLy+HbwQcfIxwk+qgo36D1MO7zuZnuWV8aQIl02/FfAkm
         BbbA==
X-Received: by 10.224.171.196 with SMTP id i4mr75223696qaz.38.1385628632266;
 Thu, 28 Nov 2013 00:50:32 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Thu, 28 Nov 2013 00:50:02 -0800 (PST)
In-Reply-To: <5297004F.4090003@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238481>

On Thu, Nov 28, 2013 at 3:35 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Or simply download the individual files (via ftp/http) and clone locally:
>
>> wget -r ftp://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>> git clone git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> cd linux
>> git remote set-url origin git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Yeah I didn't realize it is published over dumb http too. You may need
to be careful with this though because it's not atomic and you may get
refs that point nowhere because you're already done with "pack"
directory when you come to fetcing "refs" and did not see new packs...
If dumb commit walker supports resume (I don't know) then it'll be
safer to do

git clone http://git.kernel.org/....

If it does not support resume, I don't think it's hard to do.
-- 
Duy
