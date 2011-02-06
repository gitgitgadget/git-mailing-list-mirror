From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: ignoring file modes completely
Date: Sun, 6 Feb 2011 21:10:37 +0300
Message-ID: <AANLkTikCKZetZXRCZSLiM73engBcyxNfCtBN5yWdEgRs@mail.gmail.com>
References: <4D4D6BC2.90101@io.com>
	<1296921829.5467.1.camel@localhost.localdomain>
	<4D4D7636.7090608@io.com>
	<4D4D81C9.5080002@op5.se>
	<4D4DA4C1.5050501@io.com>
	<4D4E9EAC.4030508@drmicha.warpmail.net>
	<4D4EC3FD.5010000@io.com>
	<4D4EC8E6.2090200@io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: rkitover@io.com
X-From: git-owner@vger.kernel.org Sun Feb 06 19:10:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm94P-0004Em-Nc
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488Ab1BFSKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:10:40 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38247 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab1BFSKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:10:39 -0500
Received: by qyk12 with SMTP id 12so3407343qyk.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=T08o8qwnsM7M1OvjUT9/cpPy+IlGSmQweqcPkko/pt4=;
        b=as0zfXsZWkRjODt5uBdxqUwO5m5UFeO45pnv+mjUPMUcm+nMPus01C1kaFKD8QkEJi
         TFaeeRPIIwUn1uLdOyXb+2LCsIlIiHQCsEoIS1gYICitOgfiIs1y1K0MkHiRVmRPEwfS
         2pK0l0DSfRTRyZ+cPaajcCZlwywcMzYeD/KuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VkPZjFmID+RlCJhOAh9lh+4JmjFfs3mkzXd9RauelgPs0xctS4SdzqgxAc8TNEGt3Q
         rdRxzCgkfhfKDg/x4Lwp9bejvYpwfkVIzjvl/M2cIXRzEubClDXrhQTAsY0q+zPYl0Qi
         BXU9k6BvUp1zqJcQHlfTOnTTybwhcch2U3OMw=
Received: by 10.229.220.133 with SMTP id hy5mr12069672qcb.269.1297015837851;
 Sun, 06 Feb 2011 10:10:37 -0800 (PST)
Received: by 10.229.213.4 with HTTP; Sun, 6 Feb 2011 10:10:37 -0800 (PST)
In-Reply-To: <4D4EC8E6.2090200@io.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166160>

On Sun, Feb 06, 2011 at 11:14:30AM -0500, Rafael Kitover wrote:
> $ git diff HEAD
> diff --git a/README b/README
> old mode 100644
> new mode 100755
> $ git config --global core.filemode
> false

This is because core.filemode is set in the local configuration:
$ git config core.filemode
true

Git automatically detects if chmod(2) is supported on the current file
system and sets core.filemode to the corresponding value. Because cygwin
emulates chmod(), git sets core.filemode to true.

Dmitry
