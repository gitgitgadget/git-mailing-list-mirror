From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Thu, 6 May 2010 19:38:22 -0400
Message-ID: <g2m32541b131005061638o8a5e3490x8a5b1c3eb8c73c70@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<cover.1273183206.git.eyvind.bernhardsen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, torvalds@linux-foundation.org,
	prohaska@zib.de, gitster@pobox.com
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 01:41:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAAgm-0008L6-V4
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 01:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313Ab0EFXin convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 19:38:43 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:49078 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab0EFXim convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 19:38:42 -0400
Received: by yxe29 with SMTP id 29so328071yxe.4
        for <git@vger.kernel.org>; Thu, 06 May 2010 16:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6iMG7xvXxdZzDY+3Ep0/pb3MsaxFUVLSosqo5r86wlc=;
        b=PLp6Fux+2M5ebHhq+W+ivDSmlD7DbMrJ1VLZwWhhGCygH3grdXskQhrogg4ortfrtq
         UvQKfQAZQ8I42MLylx0GFl39xHC15BF8u+BcDrNGPhGR9xzo7WLqNitEM2utBvaWVmWO
         qJfltp9feh9Ybq+oiYajaUM3p8Pyd4dj3g0d8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cFabYQI0QjC/H2Po1yt4DfUvu7B0PDf8a6CNQBD/R2vaVWHk3JWqwLS1B2Byns5kIy
         biqRMeATMN8p6EmiQ2mabJqd1pqsgUgqiGeNv6sRYo0aRNnECGGylhvCQx1K6FQTYiSx
         RgeVJWEBZlc9ECllvt7nQwmOwmlWkyFQEjnEg=
Received: by 10.151.87.18 with SMTP id p18mr2789609ybl.23.1273189122128; Thu, 
	06 May 2010 16:38:42 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Thu, 6 May 2010 16:38:22 -0700 (PDT)
In-Reply-To: <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146512>

On Thu, May 6, 2010 at 6:27 PM, Eyvind Bernhardsen
<eyvind.bernhardsen@gmail.com> wrote:
> - An attribute called "auto-eol" is set in the repository to turn on
> =A0normalization of line endings. =A0Since attributes are content, th=
e
> =A0setting is copied when the repository is cloned and can be changed=
 in
> =A0an existing repository (with a few caveats). =A0Setting this attri=
bute
> =A0is equivalent to setting "core.autocrlf" to "input" or "true".
>
> - A configuration variable called "core.eolStyle" determines which ty=
pe
> =A0of line endings are used when checking files out to the working
> =A0directory.

I definitely like this.  The existing core.autocrlf setting does cause
a lot of confusion for precisely the reason you stated: people often
forget to set it until *after* they've checked out the repo, at which
time all the files are already checked out wrong and total confusion
ensues.

Being able to globally set my preferred eol style in one place, but
only have it take effect on projects (and individual files in that
project) that we already know have eol constraints, would be
wonderful.

Of course this new feature would be in addition to the existing
core.autocrlf setting, not replacing it.

This would definitely help our Windows users at work.

Have fun,

Avery
