From: Andrew Ruder <andy@aeruder.net>
Subject: Re: git status resets permissions on index file -- Ubuntu 12.04 64b
Date: Thu, 8 Aug 2013 17:18:07 -0500
Message-ID: <20130808221807.GA8518@gmail.com>
References: <CACO0oR7a1-fUASQ+SJVbH1CU8d=NbHrK0MuMu+9Pr4_=7q85Vw@mail.gmail.com>
 <52040F27.4050908@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Justin Collum <jcollum@gmail.com>, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 00:20:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7YZG-0003tG-Lx
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 00:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966379Ab3HHWUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 18:20:22 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:52029 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966217Ab3HHWUV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 18:20:21 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so2927411iea.18
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 15:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=rOKLhLGkioaSrhxMSnsJGzCdlLSTcPWv12f8zn/riZg=;
        b=f6MBinGws/lbxy2AtQCBBckiBTd2qwM0uumexFM93TpDLiLJKBvS8yq64V+FJtUtr1
         NTustsBAn9TKDgylsnpqawkaPQMpq/+ttzIz7wpot18p9rP/GaUTFHkmRPywnoqF6NT8
         w61dcaGhzLIgAcvoiQL+LYR9yx+aA9m8RsYk/HtcEM9YeAPnDJEeQxLaqdP0z4pvp1/k
         xvBWuXTQ0SMobNU7VSyZbkhM6iV2dmMdSsYGeQfTtFtKnmfm6g/BX685Uah86b75jxJ4
         jLwv8OGaPh3MBctbr2rDMxMG4g9yLqpzOWx0QyQyveon8afbq95q58Z64Ne8HAqpfPd3
         3iyA==
X-Gm-Message-State: ALoCoQmcX3EGrbDbtj6TxyBtxf5wveY2a8FQ9BEA+2/oLjwAAQD7YZ/AFLaio4z+2p/Xx9Wg+oZ9
X-Received: by 10.50.153.49 with SMTP id vd17mr667763igb.22.1376000420553;
        Thu, 08 Aug 2013 15:20:20 -0700 (PDT)
Received: from gmail.com (64-198-156-98.ip.mcleodusa.net. [64.198.156.98])
        by mx.google.com with ESMTPSA id o14sm9457476igw.2.2013.08.08.15.20.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 15:20:19 -0700 (PDT)
Mail-Followup-To: Stefan Beller <stefanbeller@googlemail.com>,
	Justin Collum <jcollum@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <52040F27.4050908@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231946>

On Thu, Aug 08, 2013 at 11:35:35PM +0200, Stefan Beller wrote:
> On 08/08/2013 10:27 PM, Justin Collum wrote:
> > [...]
> > -rwxrwxrwx   1 dev dev  17K Aug  8 13:12 index
> > [...]
> > -rw-rw-r--   1 dev dev  17K Aug  8 13:16 index   # <---------------
> 
> The permissions are set to reading for all and writing for you(r user)
> and your group. This should be no problem with standard git commands.
> Before you had the index file executable, why would you need that?

I'm about 90% sure the issue he's having is that the write bit for
other/world goes away and he is neither the user dev or the group dev
and the reason for all the executable bits is that he is regularly
running

    chmod -R 777 .

Justin, if this is true, I will tell you that git respects your umask
but I just can't bring myself to really suggest someone type umask 000
ever. :(

- Andy
