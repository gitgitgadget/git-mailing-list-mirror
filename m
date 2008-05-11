From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] instaweb: if no httpd is specified and lighttpd doesn't exist, fall back on apache2.
Date: Sun, 11 May 2008 21:58:34 +1000
Message-ID: <ee77f5c20805110458s6f1e4908k38be50753ba38d09@mail.gmail.com>
References: <1210483565-12415-1-git-send-email-nathans@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "nathan spindel" <nathans@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 13:59:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvADY-0003ov-96
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 13:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbYEKL6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 07:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752692AbYEKL6g
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 07:58:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:56934 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbYEKL6g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 07:58:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1434541fgg.17
        for <git@vger.kernel.org>; Sun, 11 May 2008 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SfHK9x+zubjiW1dpiXmYyE87KJ/8FHBk/BLTBBBTri0=;
        b=JQjbTgqle4f6guQsHyK+tTAhaR3WrLL1dUostF4EiMLYw0GewDbQljmn/GsAh1upCpCZc4d5yKgug8Ud7sPHwfcMcFEUo3NMdT5vhG4FS1rdAMPVVFlfiPoKp0QaAZrndGfXSZGoAM9Ff4F19quKsYU4ctwBpj1LwfciwaVaYj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wh1N+0UcWuWQyhK3yoXvxZ1q8zQPjQPhV1nRZ9b/Z7/z8N+tXB6kifrk7QDLu+j0hkn6xjoV0434PPXPcke/FO1atC1jsbVcEEGsHTdk91fS7O1Y8X0DQy4YJqGOsnQhv2G+K7x9lN3MzLGsTD88jPuHPHoC7D0j8+bHQUXYOEg=
Received: by 10.86.29.19 with SMTP id c19mr12142734fgc.28.1210507114689;
        Sun, 11 May 2008 04:58:34 -0700 (PDT)
Received: by 10.86.96.12 with HTTP; Sun, 11 May 2008 04:58:34 -0700 (PDT)
In-Reply-To: <1210483565-12415-1-git-send-email-nathans@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81759>

On Sun, May 11, 2008 at 3:26 PM, nathan spindel <nathans@gmail.com> wrote:

> -# if installed, it doesn't need further configuration (module_path)
> -test -z "$httpd" && httpd='lighttpd -f'
> +# use lighttpd if it exists, otherwise use apache2
> +if test -z "$httpd"
> +then
> +       if type "lighttpd" > /dev/null 2>&1;
> +       then
> +               httpd="lighttpd -f"
> +       else
> +               httpd="apache2 -f"
> +       fi
> +fi

I personally would prefer to use webrick over apache2, since it's much
more lightweight. That's just my two cents.


Dave.
