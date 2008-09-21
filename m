From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: What's cooking in gitweb (20 Sep 2008)
Date: Sun, 21 Sep 2008 22:22:55 +0200
Message-ID: <cb7bb73a0809211322q5aa6d8ex88651aa33a6c2688@mail.gmail.com>
References: <200809210138.01874.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Lea Wiemann" <lewiemann@gmail.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 22:24:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhVTX-00032B-Fe
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 22:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbYIUUW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 16:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbYIUUW5
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 16:22:57 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:54447 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbYIUUW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 16:22:56 -0400
Received: by gxk9 with SMTP id 9so2353725gxk.13
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 13:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6+M5uuCSKmnypRo1HtDPxFGFFxOgj20L/cxN7oghAlQ=;
        b=k3bdyiO66itnN6lGYGHGxc/caZfJshfA5dCzjgtAFwUDPLL7AbxU+KR8dNwbe3V6C2
         zV7+RvwhOFuQ8LVCI2GDp4wvZuUgbmpVWRboBDYl0rbiXSZYDE9xeIBrBN53agzxsA0T
         g2xQqYij0xPXnjvoTt5W9rsQrn3E0W12k8aPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rV7cHzXADGrrrzsbw8yeZfjzdtfUHwX6jo6NITjc+ViIcOVF6I+rK06FyUUEN9MNn6
         ai8FRBFR2MFbbaSMj632nEk19a8Thzpn0fzc4mdgC7P0YNpiquRRRN9Nl0Yb/LNHKyiy
         R9TNN0+kERBCQDYrvs/APsfXPrnIE6TiBcB64=
Received: by 10.151.111.1 with SMTP id o1mr6113544ybm.237.1222028575273;
        Sun, 21 Sep 2008 13:22:55 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Sun, 21 Sep 2008 13:22:55 -0700 (PDT)
In-Reply-To: <200809210138.01874.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96427>

Hi Jakub, hi all,

sorry for the late reply, I was out of town and connectionless for two
weeks and I'm getting back on track now.

> 1. "gitweb pathinfo improvements" by Giuseppe Bilotta
>   Message-ID: <1220435839-29360-1-git-send-email-giuseppe.bilotta@gmail.com>
>   http://$gmane/94779
>
>   Table of contents:
>   ==================
>    * [PATCH 1/5] gitweb: action in path with use_pathinfo
>    * [PATCH 2/5] gitweb: use_pathinfo filenames start with /
>    * [PATCH 3/5] gitweb: parse parent..current syntax from pathinfo
>    * [PATCH 4/5] gitweb: use_pathinfo creates parent..current paths
>    * [PATCH 5/5] gitweb: remove PATH_INFO from $my_url and $my_uri
>
>   Need some refinement, especially with respect to _generating_
>   path_info URLs inside gitweb.  Some patches (2 and 5) does not
>   need correction, and probably should be sent as separate series.
>   Author promised to resend series, if I remember correctly.

I'll resend the whole series (plus an additional patch to fix an
aesthetical issue I found recently) as soon as I fix the url
generation for the dotted filename corner case (which by re-reading
the past emails seemed to be the only significant issue, correct?).
Should be shortly

> 2. "[PATCH] gitweb: shortlog now also obeys $hash_parent" by Giuseppe Bilotta
>   Message-ID: <1218204731-9931-1-git-send-email-giuseppe.bilotta@gmail.com>
>   http://$gmane/91666
>
>   Very good idea, but for the following two caveats.  The name
>   '$commit_hash' is a bit strange to mean also revision range; passing
>   "a..b" to parse_commits()... well, it is a good solution, but for me it
>   feels a bit hacky.  But this is not something serious.
>
>   More importnat fact is that I'd very much like for _all_ log-like views
>   (perhaps with exception of feeds: Atom and RSS) to implement this
>   feature.  This could be done by either doing it all in the same commit,
>   doing commit series changing 'shortlog', 'log' and 'history' separately,
>   or what I would prefer actually, to refactor generation of log-like views
>   to use single worker/engine subroutine.

I agree that refactoring is probably the best idea. It will also take
me some more time ;)

BTW, I haven't heard from Lea, so can I just assume that my patches
don't touch any of her caching improvements?


-- 
Giuseppe "Oblomov" Bilotta
