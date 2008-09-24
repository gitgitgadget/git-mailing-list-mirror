From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: clone fails: Could not get the current working directory
Date: Wed, 24 Sep 2008 13:30:45 +0200
Message-ID: <81b0412b0809240430y682d6dd9wef801c33a6ee2f85@mail.gmail.com>
References: <48D59A30.5020403@cs.tamu.edu>
	 <81b0412b0809230539x340bd579q3489d5e257b9740@mail.gmail.com>
	 <48D8EDDA.3050804@cs.tamu.edu>
	 <81b0412b0809230712u4a1cbe0fo69f558cbe9a26aae@mail.gmail.com>
	 <48D90125.3090703@cs.tamu.edu>
	 <81b0412b0809230801l2e6b1a71v1210317fe636aeba@mail.gmail.com>
	 <48D95C96.4030906@cs.tamu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John Freeman" <jfreeman@cs.tamu.edu>
X-From: git-owner@vger.kernel.org Wed Sep 24 13:32:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiSb7-00011v-OC
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 13:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbYIXLas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 07:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbYIXLar
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 07:30:47 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:60699 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbYIXLar (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 07:30:47 -0400
Received: by gxk9 with SMTP id 9so5443391gxk.13
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 04:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=M9h3hKzzYQCFwClc3O3FBZQo6EZrJWzFOsUt8CEJNcA=;
        b=UUnBZV2/d65UKLwrvfATRFFzzberiqa9sS5o1sBuAbcUs6R/INwCQ5JT9wOnmpqaXt
         g9wIXdN0gejNdCRPvVdxj08tk3M9QbSiJXEOeFQpruCih4C/sR23oybdwjfxifTv46CU
         fq58ioANZwj/I2V/vYZ4umcJ9jtttQ7SlS3fA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rjikbg2bxWahVZjGCaq8u3jMp+ZHDcZcyoc8b8OEkmBbE3KpGPqWRdbBpfOog+mNlp
         naF1Qkxr6nfHwiwPCHOPzRxYBGdq747wBp6CRmrGB29PUGOxlihQ4iOY97Sr+yNfsff+
         KC1cOROPxp93bRZV5cs6I5YEmZopV+yxD4myI=
Received: by 10.150.152.17 with SMTP id z17mr10806733ybd.242.1222255845585;
        Wed, 24 Sep 2008 04:30:45 -0700 (PDT)
Received: by 10.151.107.13 with HTTP; Wed, 24 Sep 2008 04:30:45 -0700 (PDT)
In-Reply-To: <48D95C96.4030906@cs.tamu.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96631>

2008/9/23 John Freeman <jfreeman@cs.tamu.edu>:
> Alex Riesen wrote:
>> Again: try a simple program which just does getpwd for this pathname
>
> From what I gather, getpwd() is in libiberty, which I didn't feel like
> messing with for this example.  I ran a small test program that called
> getcwd() in the repo directory, and it failed.  errno was set to EACCES,
> indicating insufficient permissions.

So there we are...

> http://www.opengroup.org/onlinepubs/009695399/functions/getcwd.html

It suggest a rather dubious workaround (calling pwd).

> I may get around later to patching this, but for now we're moving ahead with
> a workaround.

...but that's a system-inflicted workaround. We just have to do it or something
like what it does.

General question: What does Sun's pwd do?
