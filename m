From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/6] Add stream helper library
Date: Fri, 4 Jun 2010 13:35:25 -0500
Message-ID: <20100604183525.GA21295@progeny.tock>
References: <1275658871-1473-1-git-send-email-artagnon@gmail.com>
 <1275658871-1473-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 20:35:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKbk0-00079Y-LH
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 20:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228Ab0FDSfc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 14:35:32 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:46209 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917Ab0FDSfb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 14:35:31 -0400
Received: by pzk15 with SMTP id 15so1092584pzk.15
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0ZGnO6ByqorsG1QIHKWwo3t6XcMHPgjwdj5scj7u254=;
        b=Lc7mHADbOPDMmk0dV31nhzpD3fOYmHDn9PAhOIoTyp/7jsKPoBO5/bJA5O9j/WBRg/
         YscX8/+FFnltHPMg74o424k5p+VRZMJpVzmhixEI0kBIiAXsbf8TRifeRJUTzrFJSAE2
         VuQHTusdNRs1IesD0baYP25qkqwI4qwPz2u7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=nHOLHJ5VPaLvUO/QrAetTMF9Y8QZq9y3+UH7gOcQu0o6SzEWocU1r5Q0GR8mkmis5V
         WT709SArJ8uB6bnzfnzkAI59JVB4p6qLzq+WjYr+EmOFR+vMjboJks5+OFkx9qBNcnHh
         V/qo6vtrfVFT2Vuizc4fUEnE3Rx7oea+lB4EM=
Received: by 10.142.67.26 with SMTP id p26mr8298482wfa.67.1275676529778;
        Fri, 04 Jun 2010 11:35:29 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id y27sm932117wfi.17.2010.06.04.11.35.27
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 11:35:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275658871-1473-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148434>

Ramkumar Ramachandra wrote:

> +static uint32_t line_buffer_len =3D 0;
> +static uint32_t line_len =3D 0;

I still don=E2=80=99t understand why this needs to read ahead.

I can take a stab at cleaning it up...

> --- /dev/null
> +++ b/vcs-svn/line_buffer.h
> @@ -0,0 +1,14 @@
> +#ifndef LINE_BUFFER_H_
> +#define LINE_BUFFER_H_
> +
> +#include <stdint.h>

Should use git-compat-util.h instead.

Jonathan
