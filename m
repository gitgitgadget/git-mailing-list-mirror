From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/4] remote-hg: don't push fake 'master' bookmark
Date: Fri, 10 May 2013 07:20:46 -0500
Message-ID: <CAMP44s2=xj=PS8Eb7D-meAO9U1x1yTD9PShJrMXP1dHMVUYXnA@mail.gmail.com>
References: <1368181023-10402-1-git-send-email-felipe.contreras@gmail.com>
	<1368181023-10402-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 14:20:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UamJi-0004A7-3J
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 14:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447Ab3EJMUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 08:20:50 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44345 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597Ab3EJMUt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 08:20:49 -0400
Received: by mail-lb0-f174.google.com with SMTP id r10so4079615lbi.5
        for <git@vger.kernel.org>; Fri, 10 May 2013 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=UFX+AQLbfmp6TlB7/oc3Ot+pgacx+u45bDXZx/oEmNw=;
        b=T+iWNoKzVWGjIvP//TdrsVIwWMNUjIHYVqswOBSKoBzjj9pjz9MoTnJnyNSJ/SjGbX
         MW1D36Vq2DjwgJIh1nta29BjGOu97XSsVA3OSG7B5P284mKgVMeoTuVvcdyF3zahBEU6
         ZrcB0dt8tOxiCYMm0w1UB+TluOq8R3IwOL6o4RJSJN8FlzyNHVT/cSxDwxRgcGxtBAOG
         RyMiQ+Cxp90fWhpQpAvDhMPU/2fHi7hMG31HDMZNCZRIe+1+RxH4zzM4r/mJ+T6WRT3z
         DQ3s0D8wAKHemUsq41u64BQa7CwQh0XS9b6HB/i4rBTE+rIrY4EEsltf9gHSYw+OvpZs
         9qfg==
X-Received: by 10.112.135.70 with SMTP id pq6mr7571003lbb.82.1368188446905;
 Fri, 10 May 2013 05:20:46 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 10 May 2013 05:20:46 -0700 (PDT)
In-Reply-To: <1368181023-10402-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223838>

On Fri, May 10, 2013 at 5:17 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -867,7 +867,7 @@ def do_export(parser):
>
>          if bmark == 'master' and 'master' not in parser.repo._bookmarks:
>              # fake bookmark
> -            pass

Missed:

+ print "ok %s" % ref

> +            continue
>          elif bookmarks.pushbookmark(parser.repo, bmark, old, new):
>              # updated locally
>              pass

-- 
Felipe Contreras
