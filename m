From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2 3/3] http: expand http.cookieFile as a path
Date: Wed, 4 May 2016 12:35:31 -0700
Message-ID: <20160504193531.GA62336@google.com>
References: <1462387335-57937-1-git-send-email-computersforpeace@gmail.com>
 <1462387335-57937-3-git-send-email-computersforpeace@gmail.com>
 <20160504193051.GF21259@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 21:35:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay2aB-0005sp-B3
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 21:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbcEDTff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 15:35:35 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34890 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbcEDTff (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 15:35:35 -0400
Received: by mail-pf0-f171.google.com with SMTP id 77so28493443pfv.2
        for <git@vger.kernel.org>; Wed, 04 May 2016 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XqSCDlxLD+wFPT91HsCaywsrbmcHso9kUlXlY9IuqeE=;
        b=BikKUGgUX/klR6gf3m78EQcMhiB0HpDI6WHxrtVDCDrnsnzQ2niwP6WpqIw2Ia6xOV
         hCuraPr4qoItBN9AOa38XVoQLmetjQbDX9LQTVm6/PlxLZixo2U8l0BYTbKCYD04Dxqe
         LDuXSrAd3Taqyc5y4DgaYgi3vpZsi14N7jFhnuZr2WsEU9JSABXhgKWiLaQdebQ0kjBD
         t3cB9W5tZzcGKQSYE5JFQTFiVGAv6cEHnY1A3RBFuLehDEdf17jEXxE6o99PdCTyRITt
         g5DH1JgrpBI3/WqJ6syuH6E4uG86LcyRWatR+FbHKviY5i5VXeRgdmipg/9hItr+yobt
         nrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XqSCDlxLD+wFPT91HsCaywsrbmcHso9kUlXlY9IuqeE=;
        b=ZebAGhdBf7WGXyqFrudRoDz9sj0OCuq9CZFO+DnG3jC+FqgBYrD3zS7msjNx8iKKaW
         bNmLzoJZMdWHdsIRf4c7qbDB6QpQvE38rTZfxfin2c2gTE+UU/KN4411qJpA0HDLhBEe
         RMP+rULqGwYwOuc6EU5Rvoj+ipuokBp9YjVgr08Z4b8hXcj+XPV3JxHpDnEZSYIchOyx
         C3FUgFrPcKn5cYi5yWfd7Fbdm86WIvQTypEMk1+MhrAhudG4dpI951oGxXdB+kZxnpil
         hHGi7R7RLOEAI4/vcgVhmxPAQjOvTiErwbih3IRZkbm10MTtg4jHPMyHXSfFd9R7afKp
         xyEw==
X-Gm-Message-State: AOPr4FU3IjIQVY2KQOTuVkjdRguVL0W44jHLlvAEFHtM2EjhfB21CNaQKUAZKTI4GSkBQg==
X-Received: by 10.98.38.66 with SMTP id m63mr14518686pfm.57.1462390534279;
        Wed, 04 May 2016 12:35:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:83a:44ea:311e:857])
        by smtp.gmail.com with ESMTPSA id ve11sm7974938pab.21.2016.05.04.12.35.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 May 2016 12:35:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160504193051.GF21259@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293577>

On Wed, May 04, 2016 at 03:30:51PM -0400, Jeff King wrote:
> On Wed, May 04, 2016 at 11:42:15AM -0700, Brian Norris wrote:
> 
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index e655b9729a7d..4c3cd7621ad0 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -1664,7 +1664,8 @@ http.emptyAuth::
> >  	authentication.
> >  
> >  http.cookieFile::
> > -	File containing previously stored cookie lines which should be used
> > +	The pathname of a file containing previously stored cookie lines,
> > +	which should be used
> >  	in the Git http session, if they match the server. The file format
> >  	of the file to read cookies from should be plain HTTP headers or
> >  	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
> 
> I think we usually re-wrap paragraphs when adding to the documentation,
> but I do not have a strong opinion (and certainly understand the reasons
> for not doing so).

I chose the wrapping mostly based on the diff suggestions y'all kindly
provided :)

I can rewrap and resend if necessary.

> The whole series looks fine to me. Thanks.

Thanks,
Brian
