From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/6] t1500: avoid setting configuration options outside of tests
Date: Tue, 10 May 2016 02:34:30 -0400
Message-ID: <CAPig+cTXOcUfO=EE5xhOjEgzSNtmhrD84PDMvVHX9hEmwuV==g@mail.gmail.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
	<20160510052055.32924-5-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 10 08:35:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b01GJ-0001Kk-Ut
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 08:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbcEJGeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 02:34:31 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:33611 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbcEJGeb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 02:34:31 -0400
Received: by mail-ig0-f194.google.com with SMTP id rc4so507957igc.0
        for <git@vger.kernel.org>; Mon, 09 May 2016 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=9gAm4kL9G8KAnezfZL1a1+Qy9W6EuCQ1nz4YleYfZJY=;
        b=b2kNScN/tzQ+PielAdPYG9R7UPfKTnaK9JkcHHz1dl6cMo/Ko78tvFpO14bMeMNiMN
         s9o1aheJJobud4c/FPXxBnWQm/YrC5WTM6GaKWGf0M5V0YJdBrYU2fvAeMCT0QBIL8Am
         TyttkxrieGBbK3PqI8vfhnq8gX3zR8aNSruVDunJtTrJGwFpR4kQfXFcWPvAt3B2VB27
         k186lSr+VtYabs9J0qucq5/o/Wo3Ho8qzF9ubK/95zRJLTHzXhYRzLJmL3/joHccfEOD
         eCt29THBCSDba/7W+kdW0lkd2YGp3xjAsWYGxrkZTYPh0s1AI/vUS5AM9iMow102e7hd
         mNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=9gAm4kL9G8KAnezfZL1a1+Qy9W6EuCQ1nz4YleYfZJY=;
        b=in3cr12ydtF7vcYdW7ceAH/Wlsd7b79L6Zxj0f2pRwWCYFVnTdXDJbt36COQ5cW4Mu
         j8FNlApKKHTC/nZ7Uc0/TvRJcHn56mXEpz+vqYlbb4LHPMEHjebqelQK+8Y66SKppg6a
         +iBDTGCGmHnVY25Zwb0B/qFMvMXQqQXpzafmgWyGIV1Dm2hmE5JxlU/cB/m0jwDQ2MyN
         RAiYEviRSCHItv01bIQ1tUNuZkEszuk5onHZP66SZvyUUH3gRTGkqWcCusgcovYnqEI6
         l7aBqtQHeCtuEkrVOzxo84zWZ29EG/QE9GBMlt1km2lxSsYZdKMFFGZ44JVepCP0HttN
         EunA==
X-Gm-Message-State: AOPr4FWQMvmFwCafExciTEEbEuCT1rYJX61tk9dHsPFSnExzsoSaH9WcmZON5GeFc+kPEWFdeS3VR2Y1LQo1jw==
X-Received: by 10.50.36.9 with SMTP id m9mr15899031igj.91.1462862070127; Mon,
 09 May 2016 23:34:30 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 9 May 2016 23:34:30 -0700 (PDT)
In-Reply-To: <20160510052055.32924-5-sunshine@sunshineco.com>
X-Google-Sender-Auth: MRLxHflwd7HcBy2c_UD9LRoazSg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294100>

On Tue, May 10, 2016 at 1:20 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Ideally, each test should be responsible for setting up state it needs
> rather than relying upon transient global state. Toward this end, teach
> test_rev_parse() to accept a "-b <value>" option to allow callers to set
> "core.bare" explicitly or undefine it, and take advantage of this new
> option to avoid setting "core.bare" outside of tests.
> [...snip...]
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> @@ -6,15 +6,25 @@ test_description='test git rev-parse'
> +       case "$bare" in
> +       '') ;;
> +       t*) bare="test_config $dir core.bare true" ;;
> +       f*) bare="test_config $dir core.bare false" ;;
> +       u*) bare="test_unconfig $dir core.bare" ;;
> +       *) error "test_rev_parse: unrecognized core.bare value '$bare'"

Oops, this line lost its ;; at some point while refining the code.

> +       esac
> +
