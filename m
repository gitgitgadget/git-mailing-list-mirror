From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH/RFC v1 5/6] combine-diff.c: remove a call to fstat() 
	inside show_patch_diff()
Date: Tue, 27 Jan 2009 09:35:43 +0000
Message-ID: <e2b179460901270135j6e4cb887radbe664ac98f39f1@mail.gmail.com>
References: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
	 <1233004637-15112-6-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Tue Jan 27 10:37:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRkNo-0004PX-PC
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 10:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbZA0Jfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 04:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbZA0Jfp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 04:35:45 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:42817 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbZA0Jfo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 04:35:44 -0500
Received: by qw-out-2122.google.com with SMTP id 3so3054802qwe.37
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 01:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hIQU6WoS+RANRYeH+zjC5RMbAraaDUOXYYuuDKQXLvY=;
        b=eyJpT5wLixLb3fQwybGZpQmlqCLSCN12vP0wQljyPQbdp593YaR5RP4yndYSxlwIO6
         Wo55QH/LOh4H0P6EDzjj0YgcP/HX2kWyI2ad2mrRKRhul5n/FMCJigmIFFB8xtAEMsKb
         kPUtmzyD6rvykqMSIUY0u7HzcLkTOjIN/W42s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FnzixFzsvGIcAnlPz6ezn2t/+FVcejLKHIWojJ5uDCHdf1EOsmvA5Zzlc0zTcIk2vF
         Zfsu2ouXzZFn8jG1b+fAUR+nFx6z5xpFkQ+BZnszIbHt/GYVoUhWdc+M5uoSXyunnE6Y
         mbS2LeN4f8RIKlgIASbrHBTRugMhLP3O082oQ=
Received: by 10.214.79.3 with SMTP id c3mr3532360qab.370.1233048943077; Tue, 
	27 Jan 2009 01:35:43 -0800 (PST)
In-Reply-To: <1233004637-15112-6-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107327>

2009/1/26 Kjetil Barvik <barvik@broadpark.no>:
> Currently inside show_patch_diff() we have and fstat() call after an
> ok lstat() call.  Since we before the call to fstat() have already
> test for the link case with S_ISLNK() the fstat() can be removed.

s/have and/have an/ ?
