From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Sat, 7 Apr 2012 02:12:22 +0300
Message-ID: <CAMP44s3-Ji33oG=Os_O9KpxawWzZzmiZ04QMTokQ+K6_x-31MA@mail.gmail.com>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
	<20120406201926.GA1677@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 01:12:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGIKT-0006eL-7p
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 01:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757417Ab2DFXMY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 19:12:24 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:56159 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab2DFXMY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 19:12:24 -0400
Received: by wgbds11 with SMTP id ds11so863214wgb.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 16:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7IplHVu7+osdaRyn3KyI0hbMHDjUsmMZBTh8wDf+uxA=;
        b=PL6r4ccQXxyjjhpUcmVH95tiGXKUjer/hNZVTZHl1cBaR9URETU3+Sz4zZxWfrK2Ir
         4Ey8kv/4NLwtH5JZxPf5+uJCK5S092fM6G+qIWlszyJXYkVxIhYGVRhMUXC2J7RvbT3Z
         Dv6WZJRHfyASfMJ8d7A6ZCdMxItsp0kBO5gm6d7v1bIfbIRw3oLXERToZd+yjFQxi2uR
         WwOGZQCellwaMb0j2XHsAN07PZmgxyjF2Wd5KIa97rqIYj9sRzyCDgbmGPwbaTGt5mD0
         lWYdixvxUM+HsLTyaf2JAqJPfFGLt/mbCm06JMW/oMXr69TB5tEQavyKwEaa5iYySR9K
         0axA==
Received: by 10.180.97.4 with SMTP id dw4mr136130wib.18.1333753942871; Fri, 06
 Apr 2012 16:12:22 -0700 (PDT)
Received: by 10.216.70.4 with HTTP; Fri, 6 Apr 2012 16:12:22 -0700 (PDT)
In-Reply-To: <20120406201926.GA1677@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194921>

On Fri, Apr 6, 2012 at 11:19 PM, Jeff King <peff@peff.net> wrote:

> I think you need to start with something like:
>
> =C2=A0#!/bin/sh
>
> =C2=A0if ! type bash; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo '1..0 # SKIP skipping bash tes=
ts, bash not available'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 0
> =C2=A0fi

What about this instead?

---
#!/bin/sh

if type bash >/dev/null 2>&1
then
	# execute inside bash
	[ -z "$BASH" ] && exec bash $0
else
	echo '1..0 #SKIP skipping bash completion tests; bash not available'
	exit 0
fi
---

--=20
=46elipe Contreras
