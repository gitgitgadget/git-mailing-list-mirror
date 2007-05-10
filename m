From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Optimized cvsexportcommit: calling 'cvs status' only once instead of once per changed file.
Date: Thu, 10 May 2007 18:53:51 +1200
Message-ID: <46a038f90705092353x107c738foa7db547ab29b1748@mail.gmail.com>
References: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de>
	 <200705092230.16027.robin.rosenberg.lists@dewire.com>
	 <380B28A3-5CD0-4371-A717-1D2629E6302D@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu May 10 08:54:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm2XG-0007Pz-5Z
	for gcvg-git@gmane.org; Thu, 10 May 2007 08:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbXEJGxx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 02:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755237AbXEJGxx
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 02:53:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:55044 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbXEJGxw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 02:53:52 -0400
Received: by wx-out-0506.google.com with SMTP id h31so439719wxd
        for <git@vger.kernel.org>; Wed, 09 May 2007 23:53:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=okVpjDSdDp0nuF0B7/9SsV1Li8QVDGio+yjlTUBVwVqso0quASdpcjSvQGYWstPpk1l0CoJ7w9P2cC7qbE6hquwsfFMgs8BTMWAUawnCfzMMFnlQoyxLx29NRONlcuphRhVrUCz4xSwKNPwPmX+vOfH92MpGhCEVvO1OMqFDCtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cU9Q2xmbpsqauyR8qsGuN3PFFyUDNRifyG2yMwHR6MMQF+HKm+rDkzXuKNmwE/NkL0KNeQQlf5dT9oYIrGYlMOmIcl0fNFIFTtKvpgzag7zQtRCNzamKPjOphWoeQs0yTSEQtQ0nUylVLGN9Ii5+FeBlgBjLOlT5dXBVPkLghu0=
Received: by 10.90.88.13 with SMTP id l13mr1213572agb.1178780032035;
        Wed, 09 May 2007 23:53:52 -0700 (PDT)
Received: by 10.90.53.18 with HTTP; Wed, 9 May 2007 23:53:51 -0700 (PDT)
In-Reply-To: <380B28A3-5CD0-4371-A717-1D2629E6302D@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46830>

On 5/10/07, Steffen Prohaska <prohaska@zib.de> wrote:
> I'll post a patch soon that takes the best of both: Call cvs status
> once with the list of touched files and parse the output. Only one
> connection is needed and only the minimal amount of status data is
> transferred.

Yes, please :-) I wrote cvsexportcommit originally, and use it on a
huge cvs checkout that is hosted on SF.net (slow!). My commits are
small (3~5 files). I agree with using only one connection so commits
with many files are sanity-checked faster, but status needs to ask
explicitly about the files it's about to touch.

cheers,


m
