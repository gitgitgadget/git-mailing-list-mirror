From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [BUG] git gui blame: Show History Context broken since 29e5573d
Date: Mon, 22 Feb 2010 16:18:11 +0100
Message-ID: <cb7bb73a1002220718p6b6621der6df062cd2f490d89@mail.gmail.com>
References: <vpqaav1llpn.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, "Shawn O. Pearce" <spearce@spearce.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 22 16:18:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nja3T-0001lV-US
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 16:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab0BVPSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 10:18:36 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:41406 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865Ab0BVPSf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 10:18:35 -0500
Received: by ewy28 with SMTP id 28so2831283ewy.28
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 07:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=FI+y2n1gdHPXEKTMV4fLtzaWzL2XbONg98NQ+f9lI6U=;
        b=WRvwgIIeME8R3SVlZByyA/KHYnLQXZg6lZY5jdCsEd4vl/7hVjj7TRx7rFn5GajQfz
         f0bNT35Ey63V6xfOunnNkjykbVFv/rHDYZSWBgR37Xs9DyIhZIMsf0ktCAu8ImhUQQvU
         9pOvvQTnaRadKwV3pn0NWEzUo3SMnMh+ryfsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=n7qrbvKJq/CO/aLAFggVkZX8n1p8jTHESasIAlmO3pmlrNfjeTRZVIUF97263r2bYB
         IdC1q3clwHRvCrlLJCgRauc6Q5hDsDFxO61O9tX0GHKH1943DXlpuWq8CSDiH5ifrjsI
         dmU9euf64QFPoGpStsaLO/3KVnbUhwPblzzuo=
Received: by 10.213.109.214 with SMTP id k22mr4492355ebp.83.1266851913977; 
	Mon, 22 Feb 2010 07:18:33 -0800 (PST)
In-Reply-To: <vpqaav1llpn.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140687>

On Mon, Feb 22, 2010 at 9:27 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Hi,
>
> In "git gui blame", right-clicking on the left fringe and chosing
> "Show History Context" in the context-menu doesn't work for me in the
> latest git. It says:
>
> couldn't change working directory to "": no such file or directory

Definitely my fault. _gitworktree was not being set up correctly when
support for bare repositories was enabled and the repo was not bare
(like in the blame case). Patch incoming, can you see if it does the
job for you? It seems to fix it here.

-- 
Giuseppe "Oblomov" Bilotta
