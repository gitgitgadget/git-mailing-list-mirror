From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] list-objects: mark fewer commits as edges for non-shallow clones
Date: Thu, 11 Dec 2014 17:51:54 +0700
Message-ID: <CACsJy8DM17je-FJ7vq3SFZJWPL5KbZ=kE=iTFQ0X0bZUpKuNmg@mail.gmail.com>
References: <20141211030948.GA137226@vauxhall.crustytoothpaste.net> <1418269615-139571-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Dec 11 11:52:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xz1MD-0003J2-VW
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 11:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbaLKKw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 05:52:26 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49404 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756252AbaLKKwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 05:52:25 -0500
Received: by mail-ie0-f174.google.com with SMTP id rl12so4394039iec.5
        for <git@vger.kernel.org>; Thu, 11 Dec 2014 02:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BqqpuKm7WU7drTmQfzKndTLAdCioVbec8995ABsGUOo=;
        b=iNRTVVyHOI4gHLQYFtAKKCxMzBzi54AeOr8SvWODyHYBt+pe6pmjaZKk0TO/+3HCRI
         0op98Dqzd9tGDnL8qwr9ti6Y/jXUFXGIx/BxkM4r6gR4ZQzY/CXiA1wBqCsnMlmh4Tvh
         ef3eeOSNUO72Cn4VbiEYDGwYIE+73/lXhfFiaD80InIgQDYQP0fP5jeZw/grSeDT5A3o
         hklh890MLs3ftfZDCYwZOBChpWuhHysasWm2G7KD4oLFdO3oAxxQ3YNzXS1pG2zVtYPN
         5O4I+QLEFP6dktVZNIDaM1eUOfVXZ6OQOkq9TjMEdecGxtSg1I/YsLDVEvKsp0UNSrli
         TIXw==
X-Received: by 10.107.161.138 with SMTP id k132mr3898168ioe.60.1418295144453;
 Thu, 11 Dec 2014 02:52:24 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Thu, 11 Dec 2014 02:51:54 -0800 (PST)
In-Reply-To: <1418269615-139571-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261275>

On Thu, Dec 11, 2014 at 10:46 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> In commit fbd4a70 (list-objects: mark more commits as edges in
> mark_edges_uninteresting - 2013-08-16), we made --thin much more
> aggressive by reading lots more trees.  This produces much smaller packs
> for shallow clones; however, it causes a significant performance
> regression for non-shallow clones with lots of refs (23.322 seconds vs.
> 4.785 seconds with 22400 refs).  Limit this extra edge-marking to
> shallow clones to avoid poor performance.

I'm glad it's now working better for you. Out of curiosity, have you
enabled pack bitmap on this repo? I would expect it to reduce time
some (or a lot) more, or we would find something to optimize further.
-- 
Duy
