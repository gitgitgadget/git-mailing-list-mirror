From: Dan Aloni <alonid@gmail.com>
Subject: Re: [PATCH v4 3/3] ident.c: cleanup wrt ident's source
Date: Fri, 5 Feb 2016 08:40:55 +0200
Message-ID: <20160205064055.GA15392@gmail.com>
References: <1454577160-24484-1-git-send-email-alonid@gmail.com>
 <1454577160-24484-4-git-send-email-alonid@gmail.com>
 <xmqqvb64f66o.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 07:41:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRa4t-0003Tc-32
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 07:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbcBEGlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 01:41:03 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34579 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbcBEGlB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 01:41:01 -0500
Received: by mail-wm0-f42.google.com with SMTP id 128so57340562wmz.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 22:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=q6vjyYhG8MSbuDa7J10cO3qCMOVkT8P2fQAGZvJi/2g=;
        b=MDyEpxyW4TKM2yGXqNynEvEPgv1k+yrRL/zOpGIBayCmgg9YyoH8u+l9WtDzNQvhez
         oPUqp8TNWAPLM+0gALIN7eMX3RGhQT7fS1/QKPh2YFFLy0IomytSjBvv74WxKQ2Is459
         uXYHhS+A0yXci/XWzC7cDywkSIg1j6RCOsxB3IHUgYEiBmmFyPxdydhFBnle0gawX3D+
         NrGqdACDgUmKMX655BsZLSTkCeY3oe6SF5k93DVdh4VOvxOFG1TuVpRWNLbFI3FigQlm
         xD7rcyh6Zl1pTnSZ0zBi5J0ktXy72lYfErmMgaC+HtK6klpqXWi2gTUDt4vW/e/OVaC7
         zbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=q6vjyYhG8MSbuDa7J10cO3qCMOVkT8P2fQAGZvJi/2g=;
        b=EqTD2CBKEYNynDtUHwgHBBkc+091wSN+5NuT9WzEFqLURSH/CZS3bNo1swVKG/mVbG
         UDdVRuPUcCBiTIp2SBD6LnJnubrTXKiJt8hHoK+ZZLX+Irmpyj7ai2yKg7QC5QUkIhkF
         82qZfehAvlU23nFEHWkYyE4z+uPOLS2yc9SWopjljGk9TKApr2hpmg4zCb5JzYk/jo8H
         6HewXpY5Ug3oC2dH3w+lfqFtvbgu8k2Du8VQ/xeGkISaUVdZWbjyuI4VALzudnk2uBgT
         fmmfEPOzgbXy2KR4//X9Kemtq51Ut5Grkmuym8iKJrx726QJ54RSuxddyPQTCQzekMdU
         AsEw==
X-Gm-Message-State: AG10YOTW8qf+psr9BlFZ/wJ9Kjc53VZxGqq+WhSjZIyrfS2GKM3GJez48OA4aDKrvmOcxw==
X-Received: by 10.194.250.39 with SMTP id yz7mr13467767wjc.92.1454654459948;
        Thu, 04 Feb 2016 22:40:59 -0800 (PST)
Received: from localhost ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id s2sm13563169wjs.39.2016.02.04.22.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 22:40:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqvb64f66o.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285542>

On Thu, Feb 04, 2016 at 02:42:55PM -0800, Junio C Hamano wrote:
> Dan Aloni <alonid@gmail.com> writes:
> 
> > +static int ident_source_is_sufficient(enum ident_source source)
> > +{
> > +	switch (source) {
> > +	case IDENT_SOURCE_CONFIG:
> > +	case IDENT_SOURCE_ENVIRONMENT:
> > +		return 1;
> 
> Without adding these two lines here:
> 
> 	default:
>         	break;
> 
> I get this build failure:
> 
> ident.c: In function 'ident_source_is_sufficient':
> ident.c:444:2: error: enumeration value 'IDENT_SOURCE_UNKNOWN' not handled in switch [-Werror=switch]
>   switch (source) {
>   ^
> ident.c:444:2: error: enumeration value 'IDENT_SOURCE_GUESSED' not handled in switch [-Werror=switch]
> ident.c:444:2: error: enumeration value 'IDENT_SOURCE_GUESSED_BOGUS' not handled in switch [-Werror=switch]

My fault - must have left over CFLAGS="-O0 -g" while debugging, so it
got missed. Will fix.

>[..]
> ident.c: In function 'ident_is_sufficient':
> ident.c:456:6: error: variable 'name' set but not used [-Werror=unused-but-set-variable]
>   int name, email;
>       ^
> cc1: all warnings being treated as errors
> make: *** [ident.o] Error 1

Ditto.

-- 
Dan Aloni
