From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv8 3/9] submodule-config: remove name_and_item_from_var
Date: Fri, 5 Feb 2016 16:46:15 -0800
Message-ID: <20160206004615.GB28749@google.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
 <1454623776-3347-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 01:46:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRr15-0005gV-JL
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 01:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbcBFAqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 19:46:19 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34878 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbcBFAqS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 19:46:18 -0500
Received: by mail-pf0-f181.google.com with SMTP id c10so10772705pfc.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 16:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=u6CDBN+TbEfpD/UwgaOGKZb3x7lvRwGg90VxlUlD1y4=;
        b=ybgjNeHkDEzPUP9a/jXPtO3KTBwMVEwUamCl/iPGE463njFDkuNPpMyFWZvEC58iGT
         7fObzyXDwHk2zlW2P/ONSaIpWoP+MoBuvpoeD1Q8jw11pmmGZtPESJmV1emdfQf2Hgfp
         PpweBl35uCd5x/1eYBhhtGGAT67Rw7rR03qvFLH0IIwEj5R+vSpfTGiJt3RZfwsbG4fO
         GFu+jP1wUF4HqiAnnJNoc6Zke7dzD0R00ePue7b4NaUcbIcn4c10OxgyIzchT9K2pznA
         MmrxxFOBnZYV4Gh+25i2EGaHmWjYIBa0FkNpIWqwFmgHdWYllgcHFRa1gg/Z9qt58y61
         pQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=u6CDBN+TbEfpD/UwgaOGKZb3x7lvRwGg90VxlUlD1y4=;
        b=ZhnasoarreXPajwb4M/CclpjupcosExmzrHg8OIt37cLItjdtAKGNPteVJT1H3Q7H5
         pAEWGsFl72nvfhlGYqZ4bh5intsjhthVYTwZNCflFdGkck4PeZ9XHXga+xLfjFiaBK7q
         0UL9nxv0FxHQ4SwnHH3n1yCg8qneHkFz4YaNdrz4yKs+O+VTT2/gUYXbi8q0tJ/IrKK4
         G5i9lIL5jbR4aITvlNpEJ46LZjItijAJ+xa5U1oSzrpsnrCzWTZJnr1DIEa0G6Tqezr0
         lkRKq4d4ZGIZk+BD9QyZsTyL/mVwu3l6/b7mp8TbtiPiAyQ7ehkr/GXYdOTFjP84ky7v
         3csw==
X-Gm-Message-State: AG10YOTNqJdsVNqG4MSBfYX3MaUOg5AIfUL7PU/Ew8y/AuU+NPgX4W1GyoP/73qtXoKccg==
X-Received: by 10.98.64.4 with SMTP id n4mr11207238pfa.58.1454719578424;
        Fri, 05 Feb 2016 16:46:18 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d5a0:f713:2934:4c2])
        by smtp.gmail.com with ESMTPSA id 1sm27077240pfm.10.2016.02.05.16.46.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 16:46:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1454623776-3347-4-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285659>

Hi,

Stefan Beller wrote:

> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -251,18 +235,19 @@ static int parse_config(const char *var, const char *value, void *data)
>  {
>  	struct parse_config_parameter *me = data;
>  	struct submodule *submodule;
> -	struct strbuf name = STRBUF_INIT, item = STRBUF_INIT;
> -	int ret = 0;
> +	int subsection_len, ret = 0;
> +	const char *subsection, *key;
>  
> -	/* this also ensures that we only parse submodule entries */
> -	if (!name_and_item_from_var(var, &name, &item))
> +	if (parse_config_key(var, "submodule", &subsection,
> +			     &subsection_len, &key) < 0 || !subsection)
>  		return 0;
>  
> +	subsection = xmemdupz(subsection, subsection_len);

This appears to be leaked.

Thanks,
Jonathan
