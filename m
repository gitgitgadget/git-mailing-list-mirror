From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Pulling one commit at a time.
Date: Mon, 24 Aug 2009 18:19:56 +0000
Message-ID: <32541b130908241119t1b969d30q8c8b484481f30ace@mail.gmail.com>
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com> 
	<4A9172D0.6030507@microchip.com> <20090824060710.6117@nanako3.lavabit.com> 
	<4A92318F.6050105@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Sanjiv Gupta <sanjiv.gupta@microchip.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 20:20:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfe9j-0007YT-Nw
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 20:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbZHXSUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 14:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbZHXSUQ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 14:20:16 -0400
Received: from mail-yw0-f183.google.com ([209.85.211.183]:43236 "EHLO
	mail-yw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbZHXSUP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 14:20:15 -0400
Received: by ywh13 with SMTP id 13so3013361ywh.15
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9fDllL3m3gbr1kKW5rotpIsUsyuKlt7dLbWIb+iW2AY=;
        b=qdW0wEAMKA/sDCesj6TtD8Znzc8IW/D00Cve8O+wZHjd5ToIvNrtMffQGCkuYB6+yx
         KsKR6TjCr68946z541VqgaItwBqDsWK6lm3hX3pklIE1J72ycm/wtpOaAPs52zDkXsJ5
         n92tHce90QwJZEzWRGGBvpK73t1PoMKMwyeN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TtIjGbUclsmJq9m/OsglTjm0KI9Ok+2kmqXH5nz40Ffbea+VQ663hwq3hVIPvtZzFB
         XfUWETJwRfhd6Bb685/V+9Ki1ExO8oeuq7d97pRfv31UarUt0c3Ax6GIUSu1Xf0f9svT
         8hCOF9FOx8Qhm8vQe+BD3yEuQ3/omlSM/UCs0=
Received: by 10.150.160.10 with SMTP id i10mr8629046ybe.186.1251138016703; 
	Mon, 24 Aug 2009 11:20:16 -0700 (PDT)
In-Reply-To: <4A92318F.6050105@microchip.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126951>

On Mon, Aug 24, 2009 at 6:22 AM, Sanjiv Gupta<sanjiv.gupta@microchip.com> wrote:
> Excellent description. Thanks for that. I want to merge commits one by one
> because I want to run a regression suite on each commit and therefore know
> if any one is causing failures.

Hi Sanjiv,

'git bisect' is an even better way to do this, in my experience.  I
wrote a program (http://github.com/apenwarr/gitbuilder/) that
automatically runs regression tests against all the new versions on
all the new branches.  It then publishes the results on a web page and
via RSS.

gitbuilder does take a shortcut: if commit x passes and commit x+10
passes, it doesn't bother to test commit x+1..9.  However, if x+10
fails, it bisects automatically to find the first commit that caused a
failure.  You could disable this shortcut easily enough, however.

Have fun,

Avery
