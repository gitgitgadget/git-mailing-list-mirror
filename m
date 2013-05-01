From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] get_sha1: prefer 40-hex ref name over 40-hex SHA-1
Date: Tue, 30 Apr 2013 23:03:03 -0400
Message-ID: <CAPig+cQMN56KfcgAu5EO39aGYwL_TO8CWuHSfcwAbruzw0a88A@mail.gmail.com>
References: <1367377282-9862-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 05:03:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXNK3-00027V-UG
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 05:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759075Ab3EADDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Apr 2013 23:03:07 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:58408 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757882Ab3EADDG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Apr 2013 23:03:06 -0400
Received: by mail-lb0-f176.google.com with SMTP id p10so1123947lbv.7
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 20:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dxiCKlk9pYCOOVr4KBR3FIPivZsQn9X8gNCjJKGHUTA=;
        b=qZ25nOUjBie2NP7T0jcxr7VlVqVuoZWqW/lC16LD/5fy4o4toSHcJeQxwncK+EHIC8
         o6WDaj1Ty1UAsUV28RrPs0/iD+tuiw7M7lKfWdxIJU+bfc1nAKVI5qBh3IYlBDl6pJd/
         FA1tH7mWaNEbe2+O5ummJspdULWlZc85n2Un9Nyxzk53euNjISbaZMlafXhDP5dB/6HP
         FEpgCsEEToHy/B/hNsJfgK7yZ7D/7rsyQxLWAFmV9jsYVJ05FU7VKnFHD+R4Q8XxvLrL
         7ilniPoV0q8i7cltvvhQpXWP4xhnXXhxFR6V7TMeT/Yalx993ZWTajIDAU30dhcY/Q5h
         03Jg==
X-Received: by 10.112.6.135 with SMTP id b7mr524431lba.104.1367377383876; Tue,
 30 Apr 2013 20:03:03 -0700 (PDT)
Received: by 10.114.174.135 with HTTP; Tue, 30 Apr 2013 20:03:03 -0700 (PDT)
In-Reply-To: <1367377282-9862-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: ygdclB456GD3vcbHskC8ziOQAAM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223067>

On Tue, Apr 30, 2013 at 11:01 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> The current behavior is inconsistent when passing SHA-1 to get_sha1.
> If it's a short sha-1, refs take precedence. "git rev-parse 1234" wil=
l
> resolve refs/heads/1234 if exists even if there is an unambiguous
> SHA-1 starting with 1234. However if it's full SHA-1, the SHA-1 takes
> precedence and refs with the same name are ignored.
>
> The former makes more sense than the latter. This patch makes git
> check for 40-hex ref names before consider it SHA-1. In future, we ma=
y
> want to warn ambiguity between refs and SHA-1 (for both full and shor=
t

s/warn/warn about/

> SHA-1).
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
