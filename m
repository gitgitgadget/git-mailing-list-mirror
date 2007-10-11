From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: RCS keyword expansion
Date: Thu, 11 Oct 2007 21:16:48 +0200
Message-ID: <8c5c35580710111216i33ef39e4x46a9050f7f92b959@mail.gmail.com>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Peter Karlsson" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Oct 11 21:17:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig3Wm-00046T-KS
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 21:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106AbXJKTQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 15:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755534AbXJKTQu
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 15:16:50 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:23479 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297AbXJKTQt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 15:16:49 -0400
Received: by wa-out-1112.google.com with SMTP id v27so730132wah
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iozrkWLx50XO+clsnkMnX1LqQyhQkti7bAD+TEi3HeU=;
        b=ioF2wd9aRwjvargOeFYD47TO5IDCBm9qzbNxOMBvtAzxdVa42eFkKccS9/MCMjtCdyPDVt3cpOe/ADORQPO4FHrQbz1M6Vtvqgn3khP51Ia45hU3A9UPe7CLZF69/RGl2/wSX0Tk4pd2JLBmYtL7oOK1SMKjS5FhTKEiis74Pec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o2tpozV1R2e3rd3vU1THdLo7O1dBTNb6nJA7e7FMUCvZ4v80q2TVSpMSAzcuazzjQFDsn7H9w3g2NREOq1PpHBC9e0ggMMhvk2ukNU85uMalq6mHvG3bqEp4e5ALb0e2nOgoQZJ3U5yke6dzM0Or5H8kLYdE2LvtWfDtUwhmY0k=
Received: by 10.114.202.15 with SMTP id z15mr2520963waf.1192130208354;
        Thu, 11 Oct 2007 12:16:48 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Thu, 11 Oct 2007 12:16:48 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60625>

On 10/11/07, Peter Karlsson <peter@softwolves.pp.se> wrote:
> I've looked and looked, but cannot figure out how to do RCS/CVS style
> keyword expansion with Git.

If you look at 'man gitattributes' you'll find a description of the
'ident' attribute which is expanded to the SHA1 of the containing file
 during checkout.

There is also a description of the 'export-subst' attribute which can
be used to expand keywords when generating tar/zip files with
'git-archive'. It supports commit SHA1 and date, among others.

Btw: using git-archive means that you don't need a local repository on
the webserver, you only need a proper git installation. Essentially,
you can update your webserver 'checkout' with something like this:

$ git archive --remote=<url> --prefix=somepath/ master | tar -x

--
larsh
