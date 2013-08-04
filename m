From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 10/19] documentation: add documentation of the index-v5
 file format
Date: Sun, 4 Aug 2013 18:26:14 +0700
Message-ID: <CACsJy8D9Q5=TF7MD1PUid-HEsCb7+JKo6=Rv6zXtjRYO3fPVYQ@mail.gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-11-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 04 13:27:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5wSt-00047B-Ik
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 13:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417Ab3HDL0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Aug 2013 07:26:47 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:45632 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab3HDL0q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Aug 2013 07:26:46 -0400
Received: by mail-ob0-f176.google.com with SMTP id uz19so3744782obc.7
        for <git@vger.kernel.org>; Sun, 04 Aug 2013 04:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dQEH5uOHTTx82AcTTdwJhs5MLGx6lIZQ348apE0maR0=;
        b=C2/V0MMSyK4BZlLAHWn9Nrs/4G8aNO36iZ7FMBoU6Goj1H5faV95woN6FhcStt1DHH
         HrnyzOSc2aiU1LIDDuGSVrl2MXsj0buKK7NNQ+rogGa5MLXSTXDeFN/uxGrlKCshQiV9
         UhQ3o7a+U5Pw1ptb+r5IowOq76+Zmv5l1GJ6NPgUqKEuWJldWWBeVKYMOqzKVJsX780N
         yalQokvOfWHWhrpqLLZCCRM7xCMTbZeRGs5juU+Uzm2XC9e07fTlESuNVltPaFvjQdTR
         ODzrcjh2uBVTPbUBVBra+7f20LfMKnFoI2QGpChkNcsquJdi26X/HX3TAdNTmtrCTDqI
         pfEA==
X-Received: by 10.60.132.113 with SMTP id ot17mr10868217oeb.104.1375615604927;
 Sun, 04 Aug 2013 04:26:44 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Sun, 4 Aug 2013 04:26:14 -0700 (PDT)
In-Reply-To: <1373650024-3001-11-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231623>

On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> +== Header
> +   sig (32-bits): Signature:
> +     The signature is { 'D', 'I', 'R', 'C' } (stands for "dircache")
> +
> +   vnr (32-bits): Version number:
> +     The current supported versions are 2, 3, 4 and 5.
> +
> +   ndir (32-bits): number of directories in the index.
> +
> +   nfile (32-bits): number of file entries in the index.

I just noticed that "file" command can show the number of entries,
something like this

.git/index: Git index, version 4, 2625 entries

Maybe we can swap ndir and nfile to immitate pre-v5 format, so
unmodified "file" still shows correct number of entries/files with v5?
-- 
Duy
