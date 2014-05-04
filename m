From: John Szakmeister <john@szakmeister.net>
Subject: Re: A failing attempt to use Git in a centralized environment
Date: Sun, 4 May 2014 04:58:20 -0400
Message-ID: <CAEBDL5XZGz3uRAhnvtPmjWH0i=MLz08MkEGvJVRfj2MLunq++Q@mail.gmail.com>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
	<5BA0AC67-CDD6-4725-B75D-B98F957EB51E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Geert Bosch <boschg@mac.com>
X-From: git-owner@vger.kernel.org Sun May 04 10:58:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgsFe-0001dd-PA
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 10:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbaEDI6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 04:58:22 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:60301 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbaEDI6V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 04:58:21 -0400
Received: by mail-yk0-f172.google.com with SMTP id 131so5249221ykp.3
        for <git@vger.kernel.org>; Sun, 04 May 2014 01:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=niSiAHgI/gNdnShT0RRHjtmM+srt4q94A1ZgPabulgA=;
        b=PrIsvj8xpQqCc2puwlkQ0cHkLnWuWQvMS9ruKYPoXxGo/uZZvVtBEjjitvG5x6K1fy
         5LabxxPwSLaA2A8SiFsibSsoEREyVr3MV0Zy/402R+1X65oEQbN+kWLx/gA51SMbCBX/
         2wgdV7PAfmsx57WV9Ks2WIR0wYXzqnU10BLIOdZfTsauLwUwas6uGoY5JATubDIVb3QV
         vGq0o7GC1NdCPrOBLzFBmaeoxWtEJqcNZVMSSaiTBp7p/wGqYnJUpRRVYD54z5ekBcjW
         TTZTiPEidyE8C3uin0lRGh+bCg1y+cg3g3puvaIJV73p8A2kjOwx40fJbRTM1yLvyKIe
         6qug==
X-Received: by 10.236.140.16 with SMTP id d16mr37543725yhj.55.1399193901006;
 Sun, 04 May 2014 01:58:21 -0700 (PDT)
Received: by 10.170.172.69 with HTTP; Sun, 4 May 2014 01:58:20 -0700 (PDT)
In-Reply-To: <5BA0AC67-CDD6-4725-B75D-B98F957EB51E@mac.com>
X-Google-Sender-Auth: 4fy1FI0rIO9Rdd2FYEcADGa5TB4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248083>

On Wed, Apr 30, 2014 at 1:15 PM, Geert Bosch <boschg@mac.com> wrote:
>
> On Apr 28, 2014, at 02:29, Marat Radchenko <marat@slonopotamus.org> wrote:
>
>> In short:
>> 1. Hack, hack, hack
>> 2. Commit
>> 3. Push, woops, reject (non-ff)
>> 4. Pull
>> 5. Push
>
> Just do pull --rebase? This is essentially the same as what SVN
> used to do in your setup.

That's not necessarily a good solution either.  For teams that don't
use rebase, it can leave them with their newly committed stuff now
rebased on the work from upstream--duplicating commits without
understanding why and where they came from, especially if other
branches were built on top of that one.

I agree in concept, but in practice it can be quite confusing. :-(

-John
