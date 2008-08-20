From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Local branch ahead of tracked remote branch but git push claims everything up-to-date
Date: Wed, 20 Aug 2008 17:01:56 -0400
Message-ID: <32541b130808201401l2ad105ccnc37acdacd08d4c3a@mail.gmail.com>
References: <1219263969579-736663.post@n2.nabble.com>
	 <8585F10E-C33C-481E-B044-A7125F3316F2@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ir0s <imirene@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Andreas_F=E4rber?=" <andreas.faerber@web.de>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:03:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVupz-0002bt-FT
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 23:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689AbYHTVB7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Aug 2008 17:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbYHTVB7
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 17:01:59 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:42095 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbYHTVB5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2008 17:01:57 -0400
Received: by gxk9 with SMTP id 9so170955gxk.13
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 14:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3m/V4TNAhjKTAKnVLY3fdyzY4vd2t+CT9VHHvN5LRcM=;
        b=sJ3jzdBCZI8nmtYND/or4HUkAe+2Ud44iF98h5r2uIsm008pUOTWrtsW5KLXCrFXPy
         9bkkUl55dstvRlHl8OLB7Y7ApfeT6R0+/RXthgSEG8LwrtLESifBdOv7bY0jLRFRRqgC
         R0zz2Md3e18FDwy+ibx3MGAm/MQXM4oQdB3Ls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YKamBy1B5rl/AQusOLosCmt03/gpyb3gfeptC3uuvH1M0f57N6bhjmKVlKKVrQs7rP
         67Vsdwb9ukRDwSSYJ/ahWZcODCin2AJrfME3fseX//rLfvT0qHB160mR5ZWx7RGyQD5R
         9/F3VCMP+0OYX7HAjGpG9dNwmChjUd6Lm9s6g=
Received: by 10.150.137.8 with SMTP id k8mr760209ybd.79.1219266116778;
        Wed, 20 Aug 2008 14:01:56 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Wed, 20 Aug 2008 14:01:56 -0700 (PDT)
In-Reply-To: <8585F10E-C33C-481E-B044-A7125F3316F2@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93044>

On Wed, Aug 20, 2008 at 4:40 PM, Andreas F=E4rber <andreas.faerber@web.=
de> wrote:
> You need to name the local branch, not the remote one:
>
> $ git push origin mybranch
>
> It should then push to remotebranch.

Not only that, but the "ahead of tracked branch" message depends on
your local copy of the remote branch, not the remote copy of the
remote branch.  So after pushing, you have to do:

   git fetch origin

I've often wondered if we can't just have push refetch the updated
remote ref automatically.  It's extremely hard to explain to newbies
that after a push, the order of refs from newest to oldest is 'origin
master', 'master', and 'origin/master'.

Have fun,

Avery
