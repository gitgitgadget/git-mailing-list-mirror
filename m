From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] builtin/mv: Get rid of the last caller of get_pathspec
Date: Mon, 3 Aug 2015 18:48:16 -0400
Message-ID: <CAPig+cT_YB=HY9dBo5eRNu4qvCqCXRwwXgpxCA8YjxagP+sHfA@mail.gmail.com>
References: <1438624382-31248-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 00:48:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMOWs-0007OX-5K
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 00:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755796AbbHCWsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 18:48:17 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:34330 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784AbbHCWsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 18:48:16 -0400
Received: by ykax123 with SMTP id x123so123661996yka.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 15:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=eddUm+Xd3wYizoEtoM6PIeCzxmAWV9zra0Ozw2tFAyQ=;
        b=tkBWGQuypFoXG8J4feB0PG2SolJJs2h+ZFu2EBzTyRuhNsjXF9oWBs5EThLULpWyIg
         HDTaCZpXULZ0BRUGc9b3A9FVBky8mg6TDCRebKIK/gi9Qb94WTghPkc+vj0h3u8qBQI1
         U6HezlCT2kueVdS8jNJuZc33sOuHOB6RPdWZT8tOMAQg09UTRvagkhEBYOc8fd3UVcGN
         wo0MC1Uof18H5EOxNsfOaAFMzSqU3eJeuoDH6Za8GL1O/M17VPDCF0GOcfwAAd+fXTZ3
         ObNr9RSuUG2AJAp1N6/+IOfRvnThoNvXPm9ILifTG1mMV2jwsGjqBiYOjmVWllRnCPSz
         x8AA==
X-Received: by 10.170.63.196 with SMTP id f187mr490888ykf.82.1438642096236;
 Mon, 03 Aug 2015 15:48:16 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 3 Aug 2015 15:48:16 -0700 (PDT)
In-Reply-To: <1438624382-31248-1-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: 73NBabaPgVuNcctYJGrOaGGKUXU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275224>

On Mon, Aug 3, 2015 at 1:53 PM, Stefan Beller <sbeller@google.com> wrote:
> `get_pathspec` is deprecated and builtin/mv is its last caller, so getting
> rid of `get_pathspec` is rather easy. By getting rid of `get_pathspec`,
> the documentation such as 'technical/api-setup.txt' becomes easier to read
> as the reader doesn't need to bear with the additional fact that
> `get_pathspec` is deprecated.
>
> The code in 'builtin/mv' still requires some work to make it less ugly.

Perhaps split this into two patches? One to free git-mv of
get_pathspec() dependence, and the second to actually retire
get_pathspec().

> Signed-off-by: Stefan Beller <sbeller@google.com>
