From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] checkout: add --sparse for restoring files in sparse
 checkout mode
Date: Sun, 24 Mar 2013 02:12:41 -0400
Message-ID: <CAPig+cSqocBs=YzvH31TRr7mAtOUNanYuXf6AaCgPos9Uz6DRg@mail.gmail.com>
References: <514C3249.7000100@ivt.baug.ethz.ch>
	<1364101583-6035-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, kirill.mueller@ivt.baug.ethz.ch
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 07:13:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJeB3-0000FW-IG
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 07:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab3CXGMm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Mar 2013 02:12:42 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58274 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab3CXGMl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Mar 2013 02:12:41 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so3250930iec.19
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 23:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MhIU25RhqU+5W+nu3mXHxi/c85DHb691s7v63OgulQk=;
        b=ITkAkkAosz0YFRc5uNOf9Vhf8vqhlTlsPMUO5gCxOaV4pEOiUgVeG3OJ2dCfKop3WB
         4ece+eCEBY8hJ9m0sq0430rW9jLr4zQ2iDOsd+mqg/uZKU+IqSBYm4zIet2qSGZ6SIeW
         ds+3mXiioieku/kET9bWimRfbXKjkQVn3/rnSUW2KGCU15qo5ACjb0lCaad8OTU+nfhV
         hNZ5VJSbegbyYBqjP6CPn7T1TwXBXFcpQ8V9J27Rram1Gnwusp14oSHiHx+psmo2VGiW
         L7U0DkILTKqGy4E+SQsxuLoeMskWjDjp/h1+Tj2JbcssCwH8p6h4NZzSWiqzyPmu1hJD
         eZaA==
X-Received: by 10.50.185.234 with SMTP id ff10mr8584560igc.25.1364105561217;
 Sat, 23 Mar 2013 23:12:41 -0700 (PDT)
Received: by 10.64.23.239 with HTTP; Sat, 23 Mar 2013 23:12:41 -0700 (PDT)
In-Reply-To: <1364101583-6035-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: Ull6R6elBh5TslzZ-wNtaAcjSZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218938>

On Sun, Mar 24, 2013 at 1:06 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index 8edcdca..45a2b53 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -180,6 +180,13 @@ branch by running "git rm -rf ." from the top le=
vel of the working tree.
> +--sparse::
> +       In sparse checkout mode, `git checkout -- <paths>` would
> +       update all entries matched by <paths> regardless sparse

s/regardless/regardless of/

> +       patterns. This option only updates entries matched by <paths>
> +       and sparse patterns.
> +
