From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v6 02/11] update-index: use enum for untracked cache options
Date: Sat, 23 Jan 2016 07:44:10 +0700
Message-ID: <CACsJy8CeKdk4u6xppXFX0-k+9aP2BZZuiw5eqiZp=khBLbjjJA@mail.gmail.com>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org> <1453283984-8979-3-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 01:44:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMmJu-0003X1-3g
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 01:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780AbcAWAoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 19:44:46 -0500
Received: from mail-lb0-f196.google.com ([209.85.217.196]:35112 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107AbcAWAol (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 19:44:41 -0500
Received: by mail-lb0-f196.google.com with SMTP id dx9so4418858lbc.2
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 16:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LNCWh8jQp3GNsH0SOY3nGJPNBvMtSSBEaC6Yw34gDp4=;
        b=Mbu6IwubeYOiXXMaqg8OpZMo/bNGGXj9d3UAsCXI2WdHfDb4mcojtCsD+iEVv7fynb
         aWNY15D/gkZXZtvNxpX9PAmSd5d1aINlNw+4XK/L42Dspl2qpTfGDaVIIE5GYgDv6oAq
         eh3ylF76f+i2VcWIufwYylIzsqCZt3oTOaH0fRqe5sDv/XQIZEk3IuUjVRo7FubdFZaj
         GmkvP2pm27L7dyjo6ls88UmVXPM8rt884YCFnh5/YJ+1tNZZmbraYswKkia1EQt7OWSK
         lPHbc8dfYXXu8teUscdN8f1ivL/mjdpbE5vU7DkBTnhaUVbF1Uz555pxpyLk3Jethhs9
         Ga5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=LNCWh8jQp3GNsH0SOY3nGJPNBvMtSSBEaC6Yw34gDp4=;
        b=FSpdnjt0uK6Z+En92uU3+NU3sYFgYRFIWy2mSSH4YWtTIT35h5o8mhNU3p22nM3N4o
         EcdL0eBiaJR7UrunAxb4cp8eVfmeVosxK3JJfvpVCzU/5ZQG+qx+hF3Bwo6tNzWFE85N
         U0moA/y951XcPcV/I/cap1H/m5/SCpFdiGEy2ojCrjmPyncP1VZpN1woV9WVcwBlXoKN
         Zk4NrxZjTjCsJF2otQyRcow2pfpcpLhPzgqZ7t3BRdyJ1FnQ+FAis7vTo5Ot9jHjmWLH
         K5XiHOO2EiQs7CwEeEViWFxOUit9jBQjjN0zhcKQtAP/3pGJBz40RLyKiKVXijXu/DSk
         ZcoQ==
X-Gm-Message-State: AG10YORlJhnN/m2jHKNHCuHUSQV5qqG7otGxu4F3KE86JVIhUr/66/ji6L85+aEbIWc5UbdJjpqe1LJmty0mrA==
X-Received: by 10.112.141.97 with SMTP id rn1mr2417350lbb.80.1453509880090;
 Fri, 22 Jan 2016 16:44:40 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 22 Jan 2016 16:44:10 -0800 (PST)
In-Reply-To: <1453283984-8979-3-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284617>

On Wed, Jan 20, 2016 at 4:59 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> Helped-by: Duy Nguyen <pclouds@gmail.com>

Nit. I think usually your s-o-b comes last
-- 
Duy
