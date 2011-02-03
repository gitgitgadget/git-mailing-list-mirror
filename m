From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Thu, 3 Feb 2011 12:33:48 +0700
Message-ID: <AANLkTi=tMq18mKqr0cp9rXqtDApKu3P_AZGyX6fA3hsx@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <20110201181428.GA6579@sigill.intra.peff.net> <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 06:34:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkrpp-0003wx-QY
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 06:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258Ab1BCFeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 00:34:20 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65320 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab1BCFeU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 00:34:20 -0500
Received: by wwa36 with SMTP id 36so819004wwa.1
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 21:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=TqfcyZ+hWWpVpoxjoBZmfFfqwOVTT7j5ClwtmNwkHnc=;
        b=gkltIjl8Sq1Pwlr6uGlIs2ma50ZBBc4NcAFVHOaL9j4ILFJ5pvamO2TXZMeHVYi7M4
         oszV/I9YL8vyuJbVpf9ixidqKqYcT0RL8y63p08MoCo6LgzK4IgK1HPlq7pOMez2ZXPy
         AIKs7bp/h+TPDO4NJ4Fh/TgJrXEsrbgz+grcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=da5D9y3yaO3Toae64Xkf0iVGbqbMNgCu8AnBtJy8mj2Rp8TcOfjPtoMyTNduommQy5
         XZKjT5yTSTwFudC47X4dvvmAb+7VCmavL7I4SI5/c8sztnZzdG6WG4bRTj65FyQAQco3
         3rq2pcOFr1+FxKUMaCocB1+V5e7acOa7lqTVs=
Received: by 10.216.89.71 with SMTP id b49mr9375578wef.28.1296711258663; Wed,
 02 Feb 2011 21:34:18 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Wed, 2 Feb 2011 21:33:48 -0800 (PST)
In-Reply-To: <201102020322.00171.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165956>

On Wed, Feb 2, 2011 at 9:21 AM, Johan Herland <johan@herland.net> wrote:
> Migration plan:
> ...
> In v1.8.0, we should default to the new default refspecs when creating new
> remotes. However, existing remotes (created pre-v1.8.0) must continue to
> work as before, so we cannot simply remove the implicit refspecs (or tag
> auto-following). Instead we need to make sure that the implicit refspecs is
> NOT applied to the new-style remotes. Identifying new-style vs. old-style
> remotes can be done by looking at the refspec itself (old-style:
> "refs/remotes/$remote/*", new-style: "refs/remotes/$remote/heads/*"), or
> (worst case) by introducing a config variable specifying the desired
> behavior (defaulting to old-style).

How about convert old style remotes to new style? Should it be done
automatically when new git detects old style remotes, or done by
command, or manually?
-- 
Duy
