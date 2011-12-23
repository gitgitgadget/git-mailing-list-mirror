From: demerphq <demerphq@gmail.com>
Subject: Re: "Nested quantifiers" error in gitweb with "++" in the filename
Date: Fri, 23 Dec 2011 17:02:22 +0100
Message-ID: <CANgJU+VA9s9t0c8D0P_DesbSDQRBQ6v913KixKQAuiy8jZsdzQ@mail.gmail.com>
References: <jd04eq$9m0$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jehan Bing <jehan@orb.com>
X-From: git-owner@vger.kernel.org Fri Dec 23 17:02:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Re7Zk-0002o3-Dn
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 17:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379Ab1LWQCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 11:02:24 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58246 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab1LWQCX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 11:02:23 -0500
Received: by yenm11 with SMTP id m11so5830628yen.19
        for <git@vger.kernel.org>; Fri, 23 Dec 2011 08:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wrmcbRVE/f4/xfcHDt+C8Njd6SJZhltmznD8pQLdCJU=;
        b=X/Oyt+URmbe85v37XOq+g9JjOGKM02IqmnZ5vqzHM3sz4t6rf0n39d7VuCx5/r0Lp2
         yl1UibmhnbA+g/IdR7EfgTSeJIzUugq+mQWBHI91rZeSD3wZiY735gT3XZAGAuUiln4W
         ml6pkSHKg5aqWWgIafcwzBXSL336KZqM/8i9M=
Received: by 10.236.173.170 with SMTP id v30mr21732528yhl.24.1324656142906;
 Fri, 23 Dec 2011 08:02:22 -0800 (PST)
Received: by 10.236.72.132 with HTTP; Fri, 23 Dec 2011 08:02:22 -0800 (PST)
In-Reply-To: <jd04eq$9m0$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187632>

On 22 December 2011 21:37, Jehan Bing <jehan@orb.com> wrote:
> Hi,
>
> I'm getting an error when trying to look at a blob when the filename has
> "++" in it:
>
> http://.../blob/13ec1624fefc23d20d0407aac3337b35844a2ceb:/foo-++.txt

This error comes because the filename is being used a pattern without
being protected by a quotemeta.

Interestingly, a later version of perl would not have this problem as
++ is a legal quantifier as of 5.10, nevertheless it probably wouldnt
do what you expected.

yves
-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
