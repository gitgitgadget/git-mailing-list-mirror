From: Stefan Beller <sbeller@google.com>
Subject: Re: compiling master fails
Date: Thu, 26 Feb 2015 12:52:18 -0800
Message-ID: <CAGZ79kZvVFTGASbsx6vZXvYJUwLjgqDeCGrN0Cz=3pjW58Qbyw@mail.gmail.com>
References: <CAGZ79kaRJg1QzFSyj0iAtUn2nUFxzZRy7BsrYC2++kaN0RD1Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 26 21:52:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR5QQ-000303-VJ
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 21:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202AbbBZUwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 15:52:21 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:37438 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190AbbBZUwT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 15:52:19 -0500
Received: by iecrl12 with SMTP id rl12so21000310iec.4
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 12:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=8Icn/wBDtw3y3KdkInW7hNUtRxH1mCPH1mj5Wg9KQxk=;
        b=OuRxnNnK7bTmjcdUfHMpMFOjKOZgrllEWdW9MRWVo+vbttJFzydNj1EjXmEcVYv/+A
         AsMWdWFFXZyNDqAkchB3DKNp+TsYwNHsMDI1k1GbbLVdp4QACgKXiDQxdUxxOQEsBa6W
         phrTZcgAnQa+dKLypuZpC3zdGwDPfHy97Qy+ilrPcZQbz6aoT54GirYHb12lrK2sMo2R
         DRsbx1RAzC75xMtr3D/PvlRFfY8x7we7pcTDDNFz7Khqst62ertA5KsdUU0EtACKxXDh
         z37Pwi7qzWg5h+ftm/YJChoMfOoS4CgasFIwm0LvLflAaZNEUVhgNAgkP504f/g9g2i3
         X4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=8Icn/wBDtw3y3KdkInW7hNUtRxH1mCPH1mj5Wg9KQxk=;
        b=RL5OkR+HZt9sy1U6OHyo855YoA9zO0uU12M7PNiySjy5cyBw9bvqxlzlpJMk8an4q8
         DUUMQ1w+X33YYSs4Gipt1iyOtCZMehvcXXhZll5JapMno3aKBxPCmTwSD8QXq+cDnZVF
         mTfA0VIQNYe2JfeRhMN60ofxebwQjOyYL0eUQLXe6X67VZ2Ev/mWvGd59Mix3k+x65WE
         v0mMAt3T13CLgnj/kDwvCTMYGDiqZQ51/d5mWGP9RMFXnMAVTF5OAYrOZ9NxvN09GEU6
         Y7wCgmz3KQ47laPMhD6lAx26dyA8reMm+t8EDo6wcvY8CDHE4jXRLkDxmArayKf6VfBY
         zowA==
X-Gm-Message-State: ALoCoQlVxCD8tNOO/DI/BbGV5dK24N/nXyzaB6UserjrJb9wMYOPQMot5hBOqyRe6gwGUBmJPDra
X-Received: by 10.50.122.68 with SMTP id lq4mr36553268igb.10.1424983938985;
 Thu, 26 Feb 2015 12:52:18 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Thu, 26 Feb 2015 12:52:18 -0800 (PST)
In-Reply-To: <CAGZ79kaRJg1QzFSyj0iAtUn2nUFxzZRy7BsrYC2++kaN0RD1Aw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264458>

Removing config.mak makes it compile again.
config.mak contained:
CFLAGS += -Wall -g -rdynamic -O0
# CFLAGS += -Wextra
# CFLAGS += -Werror
CFLAGS += -Wno-format-zero-length
CFLAGS += -Wdeclaration-after-statement
CFLAGS += -Wpointer-arith
CFLAGS += -Wstrict-prototypes
CFLAGS += -Wold-style-declaration
# CFLAGS += -flto
# CFLAGS += -fwhole-program
CC = /usr/lib/gcc-snapshot/bin/gcc

Mind that compiling did work with this exact version of
config.mak, (I did not touch it for a few weeks now),
so I suspect new changes in changes to break the
compilation.


On Thu, Feb 26, 2015 at 12:48 PM, Stefan Beller <sbeller@google.com> wrote:
> On Post 2.3 cyle (batch #5) (v2.3.1-167-g7f4ba4b)
>
>     CC http.o
> http.c: In function 'get_preferred_languages':
> http.c:1021:2: warning: implicit declaration of function 'setlocale'
> [-Wimplicit-function-declaration]
>   retval = setlocale(LC_MESSAGES, NULL);
>   ^
> http.c:1021:21: error: 'LC_MESSAGES' undeclared (first use in this function)
>   retval = setlocale(LC_MESSAGES, NULL);
>                      ^
> http.c:1021:21: note: each undeclared identifier is reported only once
> for each function it appears in
> make: *** [http.o] Error 1
