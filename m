From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [ENHANCEMENT] Allow '**' pattern in .gitignore
Date: Wed, 3 Oct 2012 20:42:29 +0700
Message-ID: <CACsJy8DRxbjcRpbO30vOCo9D+TK_dDX_oiocZSOtnGAR2jAOFw@mail.gmail.com>
References: <CALkWK0nXfeAnFfdFtdDNdEwtk0mMPtpYbg8sPzfrEXUpXsGQOA@mail.gmail.com>
 <506A9EA6.9010303@gmail.com> <CALkWK0=X5nJ6Shwa0+6Jk2cgvvo25j=mKLRs4v=eQY7x9+XvFw@mail.gmail.com>
 <CACsJy8CUK0g4FhuJxzJqN7qS2apoO2zYdg_SGvWzEN5dGcHhaA@mail.gmail.com> <506C3F23.9000009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 15:44:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJPEY-0006kk-Qg
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 15:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951Ab2JCNnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 09:43:01 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:51363 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755913Ab2JCNnA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 09:43:00 -0400
Received: by qaas11 with SMTP id s11so1477975qaa.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 06:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BFabEn/7GRj2KW5SvyL290xolxRZO7Y5mxOI4fSd3jo=;
        b=WdhHnsDNkBvrUhjP9RorjSYt96NyO1dFOyLqwxhMh14wfobJLX63A3+qclnOLd+h+F
         kDnSouafr9HBkhEID5smge06rj57htyvTJHec5stbTwtL6lUuffMBhzmxkzXADRRPKyI
         A2eoRdaodYt04/5wYjwkxR5N+zBJpYur8LHNocMBEc582vlinWeiAu7IsQakTPQoGaix
         KrxzLkndiVU87bbqaY4Zaop6cxZVNV4p4B+nHRvVO2aqL0+N9GfZQvkTg9PL84HEKCHq
         AcIrbq6+DegL6EiLPT0jiH02ESe5Vn3aUCp0t1NdBWa7GedPP2u1XzgdVHjDXz2Iw6GR
         OJLQ==
Received: by 10.49.51.7 with SMTP id g7mr11791135qeo.34.1349271779715; Wed, 03
 Oct 2012 06:42:59 -0700 (PDT)
Received: by 10.49.72.201 with HTTP; Wed, 3 Oct 2012 06:42:29 -0700 (PDT)
In-Reply-To: <506C3F23.9000009@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206893>

On Wed, Oct 3, 2012 at 8:35 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> */foo/bar
> */*/foo/bar
> */*/*/foo/bar
>
> Using "**/foo/bar" instead would be a great improvement

If this "**/foo/bar" (i.e. no wildcards except one ** at the
beginning) is popular, we could optimize this case, turning fmatch()
into strncmp(), just like what we do for "foobar*"
-- 
Duy
