From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] trace.c: mark file-local function static
Date: Tue, 21 Dec 2010 21:52:59 +0700
Message-ID: <AANLkTinL6RytF=x7a8URoxGQoLHhx0ip7gRNMp+nRaNB@mail.gmail.com>
References: <AANLkTinxJdASW6mQVU50grA2mUz6gt+gUND30VRK=BCN@mail.gmail.com>
 <AANLkTimBtpOx_GBzC=g4V6jW2aiF7Hg8uALWt2NQFFZG@mail.gmail.com>
 <1292846433.19322.1.camel@drew-northup.unet.maine.edu> <AANLkTimkxJHvTAvra+B-0bAQopd8s21ZrFCPG_ALbZZ9@mail.gmail.com>
 <1292863989.19322.27.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thiago Farina <tfransosi@gmail.com>,
	"Vasyl'" <vvavrychuk@gmail.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Dec 21 15:53:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV3aq-0003Kt-B4
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 15:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab0LUOxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 09:53:31 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39889 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab0LUOxa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 09:53:30 -0500
Received: by wwa36 with SMTP id 36so4211340wwa.1
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 06:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=dRB/0DaeJW1jPiaXQ3WZI0YOFg/F9AI16qRwH27Gq98=;
        b=oJ/P29jxubCb7tWlVIULSUpNvEyankW+thihI0/GPs3Wm6fepQicYBSqs5TKPmioba
         PCE9jDaZzY9Jixw3lF+D9dkluZMOReRK2ooTx9EU+rYG5W7eeLXdl2Tc2X+N210Pr1ne
         HzlKRPCZ5ZVF4Sy08m00xaGr2YmcTqdErA+S8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ucXlZzbLp3IlTCjoTVaVP8Sw/A855grDCrf+NqK0/RU52k6mTh/QjoEaAUriaaywqW
         e7Lm0DBqBdN4Zp2gl3AUcrCyJUJ71htDDbUMmKnIoJGA+Or2Z55RkTkd05DTtmQg5U2f
         u7c283ACT1UfAOYr0CBN+BDMUvlPRLNcbWBm8=
Received: by 10.216.177.9 with SMTP id c9mr6393475wem.34.1292943209325; Tue,
 21 Dec 2010 06:53:29 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Tue, 21 Dec 2010 06:52:59 -0800 (PST)
In-Reply-To: <1292863989.19322.27.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164036>

On Mon, Dec 20, 2010 at 11:53 PM, Drew Northup <drew.northup@maine.edu> wrote:
>> Why such trivial thing needs further explanation?
>
> Because even trivial fixes may break non-trivial things.

The only thing it could break is compilation.

> In addition, without justification we'd just as soon have somebody come
> back with another patch six months down the road that changes it back to
> the original code. Now that wouldn't make a whole lot of sense, now
> would it?

Yeah I would expect somebody reverting this patch _if_ this function
is useful outside trace.c again. On the other hand, this patch saves
do_nothing from global namespace so somewhere, some time, somebody can
use it.

This is pretty much a clean-up patch from my perspective. Do we really
need two paragraph explanation for marking a function static?
-- 
Duy
