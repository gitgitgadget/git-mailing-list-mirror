From: Stefan Zager <szager@chromium.org>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 10:39:22 -0800
Message-ID: <CAHOQ7J9ceOLe9CHbM-LjeSCkQpBihu9UA0V_-7zcRM3GD-_pvA@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CACsJy8Bsc6sywL9L5QC-SKKmh9J+CKnoG5i78WfUbAG9BdZ8Rw@mail.gmail.com>
	<CAHOQ7J8gvwpwJV2mBPDaARu3cQ54-ZDQ6iGOwKuJRr9Z+XBL7g@mail.gmail.com>
	<vpqtxc49o60.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Zager <szager@chromium.org>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 12 19:39:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDeiW-00052Y-Vk
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 19:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbaBLSj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 13:39:26 -0500
Received: from mail-vc0-f171.google.com ([209.85.220.171]:55647 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbaBLSjX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 13:39:23 -0500
Received: by mail-vc0-f171.google.com with SMTP id le5so7336039vcb.16
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 10:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rM7Ft+Lte2QcwAs0si35ezCQrlTUcWUuT+rXdxg52QI=;
        b=YRGZvmqlcuMyh8SpG198WHVOwS+8UVoaZhNLbEVSqrlSpKxNGgb8lO9niOwPDZx6IE
         b0XK8waLeu9Ddm85EF6FSPWtot2/9x9c/ViHQParN30uDTnrcv951VlgvisUpQwN4fiu
         dLi32C7thxVido6YbN54GxCRaUQ0cRCBmivyZu2Qne4B1CMdP+0C50IOgAPL2XqeM//h
         9ibWhqpJr7dGWh0wmtLpSYWyPIPeR1K+1YqQAc7n0r2uOKV5jacNxQH9OOERJdAgN6zm
         8tYcz5L7NnepfFV9GM+Dp+4INZl4Cpl5PgvtM/l2Xa3/K/TPTce7yZvZmtVf8lEOchIh
         y8vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rM7Ft+Lte2QcwAs0si35ezCQrlTUcWUuT+rXdxg52QI=;
        b=B/TLHT40vDWnYooe6MEfxZQQwLwEKvTO7RQ6VDZW0yoXyPNfhiiSFSLBiHZX37/R+r
         FpsIsknaHrxkmRCWB4El5HK6atmS+3w+kbczrhxTwcIWVppUipeRadH8Eey3AJR0V9t6
         39nosRhNexaCHC0Jg631kcZnXV76bi1znX3AA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rM7Ft+Lte2QcwAs0si35ezCQrlTUcWUuT+rXdxg52QI=;
        b=c3lcQpGGzmMzdlTNmYNq79dRR/4p3ysgf9UsW+bDaJ+rc2KWmFPKEloeV0lo/auDbm
         kHLOrYIpVZLwQP9+cc9IelaxC2nfIA9mhe6Fv4D7Mm10Bb9S9AELIE6as+lyeXLuP0S4
         0SVy5PbtiooYTWx0ZzOlJXvB4aHC1l02Ay52Aq6MdeFXMF1Dap/v353ON2IQTFYHOZxR
         QCh8gOhpyPKjt0n14Rkm+zAsYI6WX7gmlSUPfTiIq9n0nyEyE3OJCxd1lvKt/pjw5cqM
         IqF6TQgh8BXHPmBJCDKhHTUVnqYD4SlT9vh2W3eW3cqdJO9a1PjtcyQFlNt8ak2OjNeL
         5L6Q==
X-Gm-Message-State: ALoCoQmxKEcWn38K1DLVoEX1h4SBVXxLsR1yYl/Amzp37/dYG7d7+mPt50KbNdXga0uP64UW+AWeIFWtHY8eovjiUso5IKuafc3VpDBKpNimfDt+EoWNPZXBmRj3XTHXDg7UIjHxgq35PtmfFcQkL65/s/QMU2cGvU++ycgQAzf0FI9IuLVJqbkDnEKw7fziVS6o7rq4+Mwh
X-Received: by 10.221.54.65 with SMTP id vt1mr328505vcb.46.1392230362908; Wed,
 12 Feb 2014 10:39:22 -0800 (PST)
Received: by 10.52.168.226 with HTTP; Wed, 12 Feb 2014 10:39:22 -0800 (PST)
In-Reply-To: <vpqtxc49o60.fsf@anie.imag.fr>
X-Google-Sender-Auth: X972aWsi6pKk8-dJCW0lIR1XvKU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242008>

On Wed, Feb 12, 2014 at 10:33 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Stefan Zager <szager@chromium.org> writes:
>
>> I'm optimistic that parallelizing the stat calls will yield a further
>> improvement.
>
> It has already been mentionned in the thread, but in case you overlooked
> it: did you look at core.preloadindex? It seems at least very close to
> what you want.

Ah yes, sorry, I overlooked that.  We have indeed turned on
core.preloadindex, and it does indeed speed up status.  That speedup
is reflected in my previous comments about our observations working
with chromium and blink.

Stefan
