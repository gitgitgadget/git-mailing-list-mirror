From: David Aguilar <davvid@gmail.com>
Subject: Re: Propagating config to clones/pulls
Date: Tue, 7 Sep 2010 13:05:58 +0200
Message-ID: <AANLkTikbCTRKpN7w=-xoj8uKvSV1X2U8fnhXgva=oA=8@mail.gmail.com>
References: <A8F08AD5-6DB5-4A4D-9A8F-79DDBD93E666@getgosu.com>
	<201009071123.21011.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Douglas Tan <douglas@getgosu.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Sep 07 13:06:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osw06-0002qM-Ov
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 13:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab0IGLGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 07:06:01 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64786 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753611Ab0IGLF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 07:05:59 -0400
Received: by qyk33 with SMTP id 33so5184712qyk.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 04:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=SzuWRRpIwp633RZfKLdNM4hSA28g3CJ4KdOSSI80Ov8=;
        b=N0TWI+CRVDz9cR5pHhNOhQBJcUWow/tnq7+gxr9G09SpjTLWX6w8KaIcRewjazAaEL
         DTM9BawEb3YfvUwkAS9ZRLqz1Nguoz6UrfH2Cz3eJoBVEI2JIugI1OA+dQcDe+8qzgQ2
         XND8tFquLa1+clGDeu3P8UVeg5JDH7qgibL2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Txh0snbEKY4yZexz/G337tDqfF+vqgY3Hzc4+ZXQv8LgrLml+bNkuZrByXSjVd9seB
         uPd4IDCsyzEHHqV2m2ArveDStFXM1rD2C1tJO/+VuypZ9Qen4/VjiXZ7c29Fv/JYWOLg
         LBqcOtJ0L0cYpJfD1Iq0/wt9p+Tm8dYX1C0/g=
Received: by 10.224.36.207 with SMTP id u15mr651987qad.332.1283857558753; Tue,
 07 Sep 2010 04:05:58 -0700 (PDT)
Received: by 10.229.237.68 with HTTP; Tue, 7 Sep 2010 04:05:58 -0700 (PDT)
In-Reply-To: <201009071123.21011.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155695>

On 9/7/10, Thomas Rast <trast@student.ethz.ch> wrote:
> Douglas Tan wrote:
>  >
>  > I have some config settings that I'll like to make default for
>  > anyone cloning/pulling from the central remote bare repository. I've
>  > tried to do this by editing the config file in the bare repository
>  > on the server but the change doesn't appear when cloning. How can I
>  > go about pushing default config settings to anyone cloing or pulling
>  > from the repository?
>
>  You can't, since that would open a whole range of security issues.
>
>  You can put some config defaults inside the repository itself, but it
>  is up to your users whether they apply them.  Perhaps it's best to
>  write them as a shellscript that adds to the configuration file(s) so
>  that it is easy to apply it later, e.g.,
>
>   #!/bin/sh
>   git config diff.jpg.textconv exiftool
>   cat >> .gitattributes <<EOF
>   *.jpg diff=jpg
>   EOF
>
>  --
>  Thomas Rast
>  trast@{inf,student}.ethz.ch

Also.. if you happen to have administrator access to their machines
(or if they do) then you can roll an .rpm/.deb/etc. containing an
/etc/gitconfig and install it on their machines.  That'll apply these
settings globally without them having to run a script everytime a repo
is cloned.
-- 
    David
