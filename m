From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Makefile: limit specifying -DGIT_USER_AGENT=... to keep
 ccache efficient
Date: Sun, 24 Jun 2012 21:56:32 +0700
Message-ID: <CACsJy8BJmDy4pXoKM2eHhh-R0BvTxgfYTn87qZsGffEfpOQDuA@mail.gmail.com>
References: <1340541457-9056-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 16:57:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SioFS-0007Z7-7E
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 16:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab2FXO5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jun 2012 10:57:05 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:52573 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab2FXO5D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2012 10:57:03 -0400
Received: by weyu7 with SMTP id u7so2243121wey.19
        for <git@vger.kernel.org>; Sun, 24 Jun 2012 07:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ogijZO5jxu4gkmF+NuccwNJvYsdqdVEOV5t8rpOHMlw=;
        b=jkWTeRmJH+vFHnMaogOfzqC1sFAYPLCIbsovdXE4HOC+dLd/v1BvKmCgWGHERGkHKo
         rGLi8rwu3wYktb8nLD7ITbp6ohFzSoRHQ4+SA2bt+dtMGwsZXl9q8uNlqZkIh+YSHd/l
         AhF8d4zWLrcWvrbLQKWoGkrUlD5UnKMEcVU1N3bNhsAIGlxx676TKkbKdAIHfx0tixev
         ug1jppEn6tOzD5YhtplSs57zdHenVkx89OnMT7hF3H1HY7PBozCafTJ8B9iUAhkPXSYd
         jW4JnJm3vifQhiO+wDpyRAwde0L3IqliKWWA+2r+49Swe5SAHQ29qieS4dS4fdpr34RQ
         MRyA==
Received: by 10.180.78.197 with SMTP id d5mr18034198wix.7.1340549822526; Sun,
 24 Jun 2012 07:57:02 -0700 (PDT)
Received: by 10.223.79.76 with HTTP; Sun, 24 Jun 2012 07:56:32 -0700 (PDT)
In-Reply-To: <1340541457-9056-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200531>

On Sun, Jun 24, 2012 at 7:37 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> GIT_USER_AGENT changes as HEAD changes. Defining it in BASIC_FLAGS
> means every time HEAD changes, the compiling options for every object
> file is changed, which defeats the purpose of using ccache.
>
> As version.c is the only file that uses this definition, limit
> defining only when compiling this file.

Uhm.. something like this is in jk/version-string-dependency already.
Sorry for the noise.
--=20
Duy
