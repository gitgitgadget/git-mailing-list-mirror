From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH 02/11] ref-filter: add 'colornext' atom
Date: Wed, 29 Jul 2015 16:10:40 -0400
Message-ID: <CAPig+cTb3U2AHjr4wmQGezqHOED3zyYHPG54BjdCZObt=7Mu3w@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"christian.couder@gmail.com" <christian.couder@gmail.com>,
	"Matthieu.Moy@grenoble-inp.fr" <Matthieu.Moy@grenoble-inp.fr>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 22:10:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKXgc-0005rS-Oc
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 22:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbbG2UKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 16:10:42 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33348 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbbG2UKl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 16:10:41 -0400
Received: by ykba194 with SMTP id a194so17663096ykb.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 13:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=sKSzITWsUpoYr8Hsiw8B+YnxU5BH8xPX3rtVQ+D0L0s=;
        b=VVmQUvCBFPa4yinzVPCNHauDKKIL0LpRzbSa92gX+OnmWEjt5oUeAZoAk2FhxRp5L6
         qLQgzhbJY/Jx+jaRXambnpskMGdLDSWfTXs0Z9FvAD4iVDCbONQ4/TWOA3ElUWQZP5T+
         Yy3N1/de+t2G7nKxYVWN6EaPGXlEBTcphpiS46eScXA2A6f4Q+ORif57+Cc7uRviBe0Q
         JesRUX5MPu/0wJ4GUWKf38ht+V8Zf8jdiPI9nLivYkSvWTqJgNwWloSJW9btmbfL7EQS
         GA3SqP2LbmrBcgvXCPnmbhT+6f0AlQ9synu34JeSoppjW3ao6Lym7JYsQH4o5UyV4ynJ
         lZDw==
X-Received: by 10.170.63.196 with SMTP id f187mr46934964ykf.82.1438200640212;
 Wed, 29 Jul 2015 13:10:40 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 29 Jul 2015 13:10:40 -0700 (PDT)
In-Reply-To: <1438066594-5620-2-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: U0UtDEX4iY3gGchMAZOSmnenj20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274948>

On Tuesday, July 28, 2015, Karthik Nayak <karthik.188@gmail.com> wrote:
> The 'colornext' atom allows us to color only the succeeding atom with
> a particular color. This resets any previous color preferences set. It
> is not compatible with `padright`. This is required for printing
> formats like `git branch -vv` where the upstream is colored in blue.

Can you explain here and in the commit message why %(colornext) is not
compatible with %(padright:)? Is it an implementation limitation, or a
syntax or semantic limitation, or what? Can the implementation be
fixed to make it compatible or does it require a redesign?

Also, please explain here and in the commit message why this highly
specialized colorizer ('colornext'), is needed even though a more
general purpose one ('color') is already available.
