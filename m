From: Dan Aloni <alonid@gmail.com>
Subject: Re: [PATCH v3] Add user.explicit boolean for when ident shouldn't be
 guessed
Date: Thu, 4 Feb 2016 11:07:11 +0200
Message-ID: <20160204090711.GA24020@gmail.com>
References: <1454442861-4879-1-git-send-email-alonid@gmail.com>
 <20160203035648.GA20732@sigill.intra.peff.net>
 <20160203082112.GA27454@gmail.com>
 <CAPig+cSWN-wpcooqmYtFfZoDYpkhLoezSeu6bm9rSTvZ72jSEQ@mail.gmail.com>
 <20160203192227.GA13878@gmail.com>
 <20160204040111.GA27371@sigill.intra.peff.net>
 <20160204053646.GA24453@gmail.com>
 <20160204055035.GA13537@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 10:07:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFsw-0000Vz-5g
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965317AbcBDJHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 04:07:23 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35017 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965211AbcBDJHP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:07:15 -0500
Received: by mail-wm0-f51.google.com with SMTP id r129so201415784wmr.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KsqqZWLp8XUF8cohoYsO/5/qX8hOAKm8SUJinFC2gEU=;
        b=VOZOLsMVZ5b7prjeGI3rFuQRRWpqKJlwKKXjOTjogStn4zI4gtoshAgEwwJ1rTaXUQ
         xf5BB0CpZmrl8Nokk8d/ggg/OtQxfewiRZzq8mc/B4B6EBh5coaMf8gcfaqKN6THaU5x
         TZEfJcX0mU0YJ+d840dZVN4zkzRjuoEl9/eWSkcpjNKpRIxHb/7ZFNjAUO0GbOEVdMj1
         kP3kqu5FNvSX7eSXbTrladaomxnd6B85DCwMNYsC2koy5fsaDKmc2/FupAg6V1bgtLqV
         4Y5U39TLOXz5A79/dQK9Bp5Z/xvQcfsAy7WaUm+ALzsV5ky51u6tMy/5cetDDiGPygJV
         GgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KsqqZWLp8XUF8cohoYsO/5/qX8hOAKm8SUJinFC2gEU=;
        b=glKqRD7QO8OKA9P0Q9DqhbsEQaQlzgA1JX1xd81Vd1XcOBhk74LneJcsRQjDn2x1iH
         6K6DGqIJS1dC4N3KKBXV13htyYoacJoZfLDeLZs5nN7mWKhC6nrzIphF7BOXg0pkAcOM
         gJ2ONxWKn1EYP3TSkP7XgJK9yD5/hL6G4G3BK8PmcQ1iw5k87DLcIDO0C7UfxQF45hCg
         o0yVlfA1lS/XRcYfoMhPVoiBw5gfWQyf9kKAVa6WYr8JTU05qKVj+66uuJnw5BqkNrk6
         Nb7Wv6Q0c/I6PAVHxChmKVsUZn0IWL6zmQhnRhEqHqXjeu3IIzr87fXYwxH+Ki/06enV
         8taw==
X-Gm-Message-State: AG10YOSVBRu3POG6RxfvFk+QcZlE6eLBUzVtx/k/JeREsC1bJJ0DrGMtPXFtTGQyhSJQ3Q==
X-Received: by 10.28.226.212 with SMTP id z203mr5699991wmg.78.1454576833880;
        Thu, 04 Feb 2016 01:07:13 -0800 (PST)
Received: from localhost ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id x10sm10311517wjx.8.2016.02.04.01.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:07:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160204055035.GA13537@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285440>

On Thu, Feb 04, 2016 at 12:50:35AM -0500, Jeff King wrote:
> On Thu, Feb 04, 2016 at 07:36:46AM +0200, Dan Aloni wrote:
>[..]
> > The code should be cleaned up anyway. I only delved into that code for
> > the first time two days ago, so it would take me more time to come up
> > with a new one (though reading your overview here of the cases is going
> > to be helpful, thanks).
> 
> Feel free to look into this direction, but having pushed a little
> further towards the "simple" approach (with the 2 patches I just sent),
> I think that does what you want without too much complication. I'd be
> fine, too, if you wanted to pick those up[1] and put the finishing
> touches on the second one.
> 
> -Peff
> 
> [1] To clarify, since you are new to the git.git workflow: I'd expect
>     you to use `git am` to pick up my two patches. Leave me as the
>     author of the first cleanup patch. Squash your additions onto the
>     second one using `cherry-pick`, `commit --amend`, or whatever, and
>     make sure to `commit --reset-author` so that you're the author. Post
>     both as part of the v4 re-roll.
> 
>     But that's just "here is what I meant", not "what you have to do". :)

Thanks. Being familiar with Linux kernel patch submission process, good to
be focused about git.git's idiosyncrasies too.

The cleanup was easy thanks to your patches. Going to post v4.

-- 
Dan Aloni
