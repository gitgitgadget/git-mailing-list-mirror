From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [BUG] gitweb: XSS vulnerability of RSS feed
Date: Tue, 13 Nov 2012 16:57:23 +0100
Message-ID: <CANQwDwfES_hpnPOz=KTb-g3mxa8YZzzcMaj+ePj3bjgPx4DHdg@mail.gmail.com>
References: <20121111232820.284510@gmx.net> <CAM9Z-n=6xsC7yiKJ+NU-CxNPxEXWmJzvXLUocgZgWPQnuK6G4Q@mail.gmail.com>
 <20121112202413.GD4623@sigill.intra.peff.net> <CAM9Z-nkuHj8MWLfWsvY=EqHXCUS+Pk5Ezv6m5J+cnh7cQHNc_g@mail.gmail.com>
 <CAO54GHCzeWv41Bu5By0JOzbBHGuzXV=krdDr0U=QsMBun7PF7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Drew Northup <n1xim.email@gmail.com>, Jeff King <peff@peff.net>,
	glpk xypron <xypron.glpk@gmx.de>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Jason J Pyeron CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Kevin <ikke@ikke.info>
X-From: git-owner@vger.kernel.org Tue Nov 13 16:57:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYIsA-0000vC-Lv
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 16:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab2KMP5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 10:57:44 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:64925 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab2KMP5o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 10:57:44 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so7536106oag.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 07:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OjruCYPbONWKfwLTyCUlN4Yb3mzgfe+7NfUqzPuKHDk=;
        b=eMU5CJ2Lc/E1xl/c+DYpUKIzXYt8yl65P20KgMGmXMtLUrXRn7NBLUOIJ5s8hKamBE
         d4hwH8Ldv7huo1ETjwoBKxa6+OdV13twr9eDUIWfF5O19Fwx92MCugxaxCulEupXUPSy
         PtUfUzxKdZUgESO7XvKuhF9EdUyEoY86XQES719LjQizmXGDde8o/1/fTOSX5o2yIGa8
         j00uuFop9vVVXJh7vCxG4JuFn4+81qzN/jGc7BG62OuSqEtawgOzMmncs3dkKrIk80xT
         m086SXrZM6GEUb1i2GDbrtkbmWWuA/iPHBsm+mF+rYoNDsOMPQREg7R1+LYUbtEjdbmU
         dvQA==
Received: by 10.60.170.114 with SMTP id al18mr18030553oec.56.1352822263293;
 Tue, 13 Nov 2012 07:57:43 -0800 (PST)
Received: by 10.76.91.134 with HTTP; Tue, 13 Nov 2012 07:57:23 -0800 (PST)
In-Reply-To: <CAO54GHCzeWv41Bu5By0JOzbBHGuzXV=krdDr0U=QsMBun7PF7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209626>

On Tue, Nov 13, 2012 at 4:45 PM, Kevin <ikke@ikke.info> wrote:
> The problem with input filtering is that you can only filter for one
> output scenario. What if the the input is going to be output in a wiki
> like environment, or to pdf, or whatever? Then you have to unescape
> the data again, and maybe apply filtering/escaping for those
> environments.
>
> You only know how to escape data when you are going to output it, so
> then is the the best moment to escape it.

Also there are so many ways to evade XSS filtering

  https://www.owasp.org/index.php/XSS_Filter_Evasion_Cheat_Sheet

If you can and should escape data (like in our case), it cannot not work;
not possible to evade it.
-- 
Jakub Narebski
