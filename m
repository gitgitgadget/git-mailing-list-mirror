From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/6] path: Make the 'get_st_mode_bits' symbol a file static
Date: Sat, 27 Apr 2013 22:26:23 -0400
Message-ID: <CAPig+cS0dwm_aHCx6zUCCKnrWk1WXMaO54FOKtkwXXftDLr=og@mail.gmail.com>
References: <517C1BF9.2050604@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 28 04:26:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWHK5-0005Ie-Dq
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 04:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738Ab3D1C00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 22:26:26 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:54030 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178Ab3D1C00 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 22:26:26 -0400
Received: by mail-la0-f53.google.com with SMTP id eg20so4475015lab.26
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 19:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=MG/JrvvsCkYJpVjTj0wNlqUq0dNF35fG7LO6lo3nwOc=;
        b=zNEwhco/eKr9W/DqejeoB9Uu7LynHrpYDJunCZFofJEgQYzVx7O0Xw6jpoDCjs1hSx
         7a/zMvyh81F3cP6lxbzg/Dad7Ma7qXKIlze2wlUGetS693Uw+1TB2tLMkIqOgQiTMmF5
         oUfQAiWHf6w0cBNUnaoFiaLOVbjBVw5hKzXDUMPNMzNPUy9KvMfXh+U2Syn7tkNiGBNl
         Db2SpvfMZ+lejapHaiKGB69EUKMEW4YJnT/1ZDJ++UDnD14DdgEQ7flWBXUPmljCHC5K
         pJfww/QJ8c3IEDos/9G1BpTCVHgi1IZlk6IbzphRZTmxrOGqFYKwdtSavPAo1apDX+Dj
         96mQ==
X-Received: by 10.152.19.199 with SMTP id h7mr24988222lae.21.1367115983916;
 Sat, 27 Apr 2013 19:26:23 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Sat, 27 Apr 2013 19:26:23 -0700 (PDT)
In-Reply-To: <517C1BF9.2050604@ramsay1.demon.co.uk>
X-Google-Sender-Auth: NBRt9d8ZDnHYwcnN-aZSGXzRQ6A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222726>

On Sat, Apr 27, 2013 at 2:42 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> On MinGW, sparse issues an "'get_st_mode_bits' not declared. Should
> it be static?" warning. The MinGW and MSVC builds do not see the
> declaration of this function, within git-compat-util.h, due to it's

s/it's/its/

> placement within an preprocessor conditional. (So, one solution would
> be to simply move the declaration to the top level of the header.)
>
> In order to suppress the warning, since this symbol does not need
> more than file visibility, we simply remove the declaration from
> the header and add the static modifier to the function definition.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
