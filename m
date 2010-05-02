From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] blame: add a range option to -L
Date: Sun, 2 May 2010 04:14:34 -0500
Message-ID: <20100502091433.GA1854@progeny.tock>
References: <1272662989-563-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
X-From: git-owner@vger.kernel.org Sun May 02 11:14:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8VG7-00078f-U7
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 11:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133Ab0EBJOl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 May 2010 05:14:41 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:58359 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890Ab0EBJOj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 05:14:39 -0400
Received: by iwn12 with SMTP id 12so2024053iwn.15
        for <git@vger.kernel.org>; Sun, 02 May 2010 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cW81sya8ESZblamUCBqQf29D+6riMtKhMWELWogNTuo=;
        b=D75nyzJH5xMZ+t9VV1QjB51OTw4v7NmaGHHv06xtDo7+8IzD1hAa3w6R++kq6xawcd
         ZzB/XqHz8teDvcr8jON+b7X38aJxIy1a2IG3h7gHznVjxTSnSDyEZnOwXqeLMMS0LO3y
         60Ov9GCiv9AAFIw2evabtX7nOlztBhKl1kb+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VF0OSJzqCXUah6L+kbga0NBIMt3fllnWxCx7iEVljeYEFPDR30q3AHdDUZooHMzDF7
         HwajHljrTep1pVUgjcQil+Iaik82u+ESThyacBLqB0Gum5Oyw9vxVDZmwtZx3HsVZD5q
         SJx2vXVpvc83Fg2itft7NhdbxlUpTShpFODuc=
Received: by 10.231.182.9 with SMTP id ca9mr4471961ibb.38.1272791678676;
        Sun, 02 May 2010 02:14:38 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm3309463iwn.10.2010.05.02.02.14.37
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 02:14:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1272662989-563-1-git-send-email-wfp5p@virginia.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146150>

Bill Pemberton wrote:

> In addition to + and - you can now use r to specify how many lines
> around <start> that you want to see.  For example: -L 20,r5 would sho=
w
> lines 15 through 25

=46rom too much exposure to subversion, the r suggests =E2=80=9Crevisio=
n=E2=80=9D.
But =C2=B1 is too hard to type, so I guess r will have to do.

> +++ b/Documentation/blame-options.txt
> @@ -32,6 +32,12 @@ This is only valid for <end> and will specify a nu=
mber
>  of lines before or after the line given by <start>.
>  +
> =20
> +- rrange

Maybe -rradius?  =E2=80=9Crange=E2=80=9D sounds like an interval with s=
pecified endpoints.

> +		/* if top is negative then top is actually a range
> +		   that was specified with the r option */
> +		if (*top < 1) {
> +		    long x =3D *top;
> +		    *top =3D *bottom - x;
> +		    *bottom +=3D x;
> +		    if (*bottom < 1)
> +			*bottom =3D 1;
> +		}

How does this treat -L 5,-10?

Jonathan
