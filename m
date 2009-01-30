From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 11:17:49 -0500
Message-ID: <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
	 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 17:19:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSw5N-00008O-4v
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 17:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbZA3QRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbZA3QRw
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:17:52 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:3214 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbZA3QRv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 11:17:51 -0500
Received: by rv-out-0506.google.com with SMTP id k40so503654rvb.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C9xUgrtI9jWKghXWP4wIOaQ93+K3egNtG4KJsVpuvlo=;
        b=gAepcleZiAwgTg4VXvsNNU7NLB8fDs+R0D1Q48uT51BLm9V5X2meqIPTTpeSaXbOSi
         H+nGProoVlo5OdhwyB+B6KAhOIFcy1mI2poyOAMeD8shs/KN2OCOZCq8ozbDEq3xVATU
         ubq+Ny5UWYxueYV9u6/HzaGEM7F2gMexjJDUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oKaaztEnN2HyBnM7bKjTv91o5QHQP+Tfv/dXXaYn8ulfIml2c2lfCKuHYobUZF/nk+
         aR6nHQgda4biN3oP2LSaFaDEKtlU1fNoenvj78D873DiMsFVVrYUqijNSLCxdYaEgQgL
         UMKeTgJbmWoDuwoAJxQG7pMndfDtxkdssQN8k=
Received: by 10.141.107.13 with SMTP id j13mr715958rvm.65.1233332269995; Fri, 
	30 Jan 2009 08:17:49 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107839>

On Thu, Jan 29, 2009 at 7:34 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Many, many users set up non-bare repositories on their server, and are
> confused that the working directory is not updated.

This comes up on the list from time-to-time and is even in the FAQ. It
has even been suggested that HEAD be detached when pushing into a
non-bare repository, but I am not suggesting that again.

I wonder if it might be helpful to teach clone to setup a push line in
the cloned repo. i.e.:

[remote "origin"]
	url = ...
	fetch = +refs/heads/*:refs/remotes/origin/*
	push = refs/heads/*:refs/remotes/origin/*

This could be a configurable default behavior when cloning from a
non-bare repo (can that be determined?) and/or as a switch
(--satellite perhaps?).

j.
