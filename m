From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Tue, 29 Nov 2011 20:17:36 +0700
Message-ID: <CACsJy8BRhoYM+Lb8afp=3rKzYNOEq0JY8uS9mD1ovz3uyJVWOA@mail.gmail.com>
References: <1322546563.1719.22.camel@yos> <20111129090733.GA22046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bill Zaumen <bill.zaumen+git@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, spearce@spearce.org,
	torvalds@linux-foundation.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 29 14:18:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVNZf-0006Ya-6b
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 14:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252Ab1K2NSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 08:18:10 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46315 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127Ab1K2NSI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 08:18:08 -0500
Received: by bkas6 with SMTP id s6so505576bka.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 05:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gyjne8Fv3EeqBjd/CVfRTERrNctMihTXxDuP1gjdjmY=;
        b=Ea9uiZmevqYLlezAvmWmHHcuf54tshG3jE/5ifvz262GhoMDeyciE+fgBAL51Vw4ep
         +qfniri9eGDdGcAio2+JC+A/Tx9a8LTazVJ4Sms38aM+wpt0bZTHEUDdUZr11XSUUxZy
         XFhMRGTFh/X+IjO2yNw49/5m908HBLelxrHos=
Received: by 10.204.14.208 with SMTP id h16mr49209160bka.2.1322572687335; Tue,
 29 Nov 2011 05:18:07 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Tue, 29 Nov 2011 05:17:36 -0800 (PST)
In-Reply-To: <20111129090733.GA22046@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186057>

On Tue, Nov 29, 2011 at 4:07 PM, Jeff King <peff@peff.net> wrote:
> However, it's harder for trees. Each entry needs to have the new digest
> added, but there simply isn't room in the format. So we would have to
> change the tree format, breaking interoperability with older versions of
> git. And all of your tree sha1's would change as soon as you wrote them
> with the new format. That's only slightly better than just swapping
> sha1 out for a better algorithm.

I think we could hide the new digest after NUL at the end of path
name. C Git at least does not seem to care whatever after NUL.
-- 
Duy
