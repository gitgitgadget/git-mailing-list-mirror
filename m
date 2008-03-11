From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: How to ignore deleted files
Date: Tue, 11 Mar 2008 16:07:13 +0100
Message-ID: <8aa486160803110807m277363d6kaf7e1dd401fc9e2f@mail.gmail.com>
References: <47D68203.10905@bioinf.uni-sb.de>
	 <m3y78pxsf5.fsf@localhost.localdomain>
	 <47D69CE0.3030505@bioinf.uni-sb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Andreas Hildebrandt" <anhi@bioinf.uni-sb.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 16:09:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ65j-0001uC-V6
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 16:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbYCKPHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 11:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbYCKPHY
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 11:07:24 -0400
Received: from gv-out-0910.google.com ([216.239.58.189]:16872 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499AbYCKPHX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 11:07:23 -0400
Received: by gv-out-0910.google.com with SMTP id s4so601257gve.37
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 08:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=o2r+JhJ0t4zXsdl3+QtWgjfr8rO/P0IZBukteqIDaTw=;
        b=RlPeyR7yMUbUh1O4Br05r2iLn3cjuAg92n0S42bxWYM4Xw2XSK/BrIiOOjpnzLhj0Us6aPyJLdeOgx5kiR8kiQ2EBsWmzw7kJWJj5tTznuKmzX6PEqjMvRbXu88cAF2Ur9dnHMfOvDv6C/wWkCnqPrH34o7XXll4ClHIeAVeemQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xt7OmZ84UG8iuN/ukVTUCH/vm+BVakaOrw05YlpCvkFwDYwIzyYC/hxaPhixqdZvpYXvn03YKBhsza8SJrviwgx8lLm+OPzfhYKHYmdu+PW0Yz+OZoepGfInF15axyNWrkARLvHgp2PmkCvPCuF8l79dGHI9aH4X7it429Yll3A=
Received: by 10.150.123.16 with SMTP id v16mr3724073ybc.76.1205248033217;
        Tue, 11 Mar 2008 08:07:13 -0700 (PDT)
Received: by 10.150.199.9 with HTTP; Tue, 11 Mar 2008 08:07:13 -0700 (PDT)
In-Reply-To: <47D69CE0.3030505@bioinf.uni-sb.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76864>

On Tue, Mar 11, 2008 at 3:53 PM, Andreas Hildebrandt
<anhi@bioinf.uni-sb.de> wrote:
>
>  I absolutetly agree that it's strange. The main reason for this is that
>  we have some collections of data files (some of them pretty large) that
>  can be compressed pretty effectively. At compilation time, it is decided
>  if the files are needed or not. If so, they are extracted. In the end,
>  the .tar.gz files are deleted since they are no longer needed. In
>  addition, once a user obtained a checkout, the whole thing is supposed
>  to work without a further net connection, so downloading the files
>  during build is not really an option.

Maybe you can have a look to pristine-tar. From:

http://kitenet.net/~joey/code/pristine-tar/

pristine-tar can regenerate a pristine upstream tarball using only a
small binary delta file and a copy of the source which can be a
revision control checkout.

The package also includes a pristine-gz command, which can regenerate
a pristine .gz file.

The delta file is designed to be checked into revision control
along-side the source code, thus allowing the original tarball to be
extracted from revision control.

---------------------

So you can recreate the tar from files in a git branch.

Santi
