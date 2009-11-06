From: Timur Sufiev <tsufiev@gmail.com>
Subject: Timur Sufiev: Re: [PATCH I18N filenames v2 3/3] Provide compatibility with MinGW
Date: Fri, 06 Nov 2009 13:00:42 +0300
Message-ID: <4af3f3cb.0305560a.7a34.0f43@mx.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 11:00:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Lck-0002Ep-Mz
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 11:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583AbZKFKAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 05:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756369AbZKFKAl
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 05:00:41 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:63757 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754995AbZKFKAk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 05:00:40 -0500
Received: by fg-out-1718.google.com with SMTP id d23so143142fga.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 02:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :x-mailer:mime-version:content-type:date;
        bh=pX8Vvs/5ohwFQqmXRItfB1eMmuR2bLTe7RumaqZIJl0=;
        b=CT2ugsyKVFeghdxyGMfeR5ohwAPNq5T38yV73f5d5Np9MftY3t9ZLEzGkYsimq8jFv
         akzZx6TUNjXDm7sLdjeKvCmPQ8N0H0TeU6vGF5SuVHckK4LdCGxa9diX9OrT5xkXdfJE
         whsggmgWFzMi/1jQEzOmilZbWt9T3dw8+aFXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:subject:x-mailer:mime-version:content-type:date;
        b=iAnpDhUufo5aZjCymJX6sz8l0X6KDaWlOwTuC1+kqnghEnAmX3D0omYgW9g/xcfezY
         UrekDUhS5EF+oCeBblYsSQV2ycB4pFDuuwdELEqdNy+l6WV0U5wzMAhLVVr0m7znUY6o
         un1vaLGiU3I18Och2b6beyNnQ1+oxzOZ9nh9c=
Received: by 10.86.225.38 with SMTP id x38mr5628645fgg.59.1257501644669;
        Fri, 06 Nov 2009 02:00:44 -0800 (PST)
Received: from localhost ([80.90.116.82])
        by mx.google.com with ESMTPS id 3sm35143fge.19.2009.11.06.02.00.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 02:00:43 -0800 (PST)
X-Mailer: MH-E 8.2; nmh 1.3; GNU Emacs 23.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132295>

--=-=-=
Content-Type: message/rfc822
Content-Disposition: inline; filename=200
Content-Description: forwarded message

From: Timur Sufiev <tsufiev@gmail.com>
To: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH I18N filenames v2 3/3] Provide compatibility with MinGW
In-reply-to: <alpine.DEB.2.00.0910290955530.8995@ds9.cixit.se>
References: <1256752900-2615-1-git-send-email-timur@iris-comp.ru> <1256752900-2615-2-git-send-email-timur@iris-comp.ru> <1256752900-2615-3-git-send-email-timur@iris-comp.ru> <alpine.DEB.2.00.0910290955530.8995@ds9.cixit.se>
Comments: In-reply-to Peter Krefting <peter@softwolves.pp.se>
   message dated "Thu, 29 Oct 2009 10:01:01 +0100."
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Date: Tue, 03 Nov 2009 19:53:44 +0300

Hello, Peter
> Hi!
> 
> Instead of calling the open_i18n() which converts from UTF-8 to a local 
> 8-bit character set, this should probably call a version that converts from 
> UTF-8 to UTF-16 and uses _wopen().
> 
> Same thing for fopen_i18n() and _wfopen().
> 
> I created a small RFC patch for that that changed parts of the system 
> earlier this year - http://kerneltrap.org/mailarchive/git/2009/3/2/5350814
> 
> I did not address readdir() and friends, I'm not sure if they are available 
> in UTF-16 form or if they need to be rewritten using findfirst()/findnext().
> 
> -- 
> \\// Peter - http://www.softwolves.pp.se/

I've decided to stick to local 8-bit encoding for now having considered
the following issues:

1. Many git front-ends, e.g. TortoiseGit, use 8-bit set, not UTF-16:
they call git plumbing commands and pass filenames to command line (in
local 8-bit encoding). So, using [UTF-8] <-> [UTF-16] approach, I had to
deal with 3 different encodings: UTF-8, UTF-16 and local 8-bit one
(CP1251 in my case). Moreover, Windows itself uses both UTF-16 and
CP1251, so one had to deal with reencoding between them (if he plans to
support UTF-16). Too much confusion.
 
2. UTF-16 is a proper solution for Windows, but my patch is useful for
other OSes with locales different from UTF-8 (e.g. Linux with KOI8-R
locale).

Still there is a possibility that one day we'll stumble upon some UTF-8
symbol which cannot not be correctly mapped into 8-bit encoding. UTF-16
would be a remedy in this case, but what if don't have it (see 2)?
-- 
Timur Sufiev

--=-=-=
Content-Disposition: inline
Content-Description: Signature

-- 
Timur Sufiev

--=-=-=--
