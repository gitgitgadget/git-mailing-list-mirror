From: Frank Li <lznuaa@gmail.com>
Subject: Re: Git log can not show history before rename
Date: Fri, 30 Jan 2009 20:29:28 +0800
Message-ID: <1976ea660901300429i6d9b3594m91222314c284d184@mail.gmail.com>
References: <1976ea660901300323n384d3650s3bb5a575accb65d1@mail.gmail.com>
	 <adf1fd3d0901300329y53e46d91xda75799ce1244ddd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 13:31:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSsWU-0007wi-RI
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 13:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbZA3M3a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jan 2009 07:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbZA3M3a
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 07:29:30 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:44668 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbZA3M33 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 07:29:29 -0500
Received: by gxk14 with SMTP id 14so340649gxk.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 04:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=vYCxWf1kcRZ/gMkMr/Ct2wo1dhduaNIgE9bi0e60wts=;
        b=jkiYkDxaP1gzn6pakQBqgPPqbBIfoz6W+l2nf/q49KT0aWd2UK/+1nV7SPIz98vU3/
         +VuCiQoRrFjCtDmWnZHNVbapykyWoOeSyLdoEKSk/jcUwPqkjHtmhc+IMNWtpWoeIfrN
         f07EQ671lvS7hEbgo2vBrHHAhJ/NSX+VZ8X74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Kobylb6xcREKyFerfqgooW3NXnGU9UN+lZIR8UghMABMmYeJ3TFeRWm4PNeBN1GpCw
         NOUSwcCdM6cNk1pyij5ZZnMZcHM59ZOYZsrCwIx2tGS3aA13xzp5sqabQCAKSCXCO6tI
         a41v9X3TAjB7SsatORBZeaB2z6mKnh+hmAsTY=
Received: by 10.151.106.4 with SMTP id i4mr1161598ybm.116.1233318568546; Fri, 
	30 Jan 2009 04:29:28 -0800 (PST)
In-Reply-To: <adf1fd3d0901300329y53e46d91xda75799ce1244ddd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107803>

Does it conflict with --parents?
When I use --follow and --parents together,  parents can't rewrite.
without --follow, parent can rewrite.


2009/1/30 Santi B=E9jar <santi@agolina.net>:
> 2009/1/30 Frank Li <lznuaa@gmail.com>:
>> mkdir tt3
>> cd tt3
>> git init-db
>
> "git init"
>
>> touch a.c
>> git add a.c
>> git commit -a -m "test1"
>>
>> git mv a.c b.c
>> git commit -a -m "rename"
>>
>> modify b.c
>> git commit -a -m "test2"
>>
>> git log -C -M -- b.c
> [...]
>> I can't get history before rename.
>
> You asked to restrict the search to the b.c path.
>
> You want:
>
> git log --follow -- b.c
>
> Man git-log:
>       --follow
>           Continue listing the history of a file beyond renames.
>
> HTH,
> Santi
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
