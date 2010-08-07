From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] pack-object: trim memory usage a tiny bit
Date: Fri, 6 Aug 2010 19:04:26 -0500
Message-ID: <AANLkTingdhx5osnbiLVMyWaauCf1TRiMzcSC76gQRp9B@mail.gmail.com>
References: <1281114057-5982-1-git-send-email-pclouds@gmail.com> 
	<AANLkTikphara-0NXaBZ-MAygytGYDuN6ANcMWE+Ni3mW@mail.gmail.com> 
	<AANLkTikL8MtqFr1T=3TKA7GLKSEbyvf+6SLTT2BYehto@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 02:04:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhWuC-0000CM-Cj
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 02:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761303Ab0HGAEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 20:04:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39974 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab0HGAEq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 20:04:46 -0400
Received: by iwn33 with SMTP id 33so1731326iwn.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 17:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=uyLL9U57NVqNZ4B0xuJ86QUTG0KObThSjXnZ5vKmgMA=;
        b=bqlNygnj1BdMkOUuxb+xoK3Ai5eObYZO4GpxjBD/vrBLv708s9UYd57SKECCTX+O6o
         q1Wq1qORiYyiwj21cyrq5yp58hd+/Qp+nsBPHVVr2K7h1eU5TMyRmwOVW/WToR3mDhTr
         ppOaoVnsyrsy7fcoqfBQ02sr9Ih7xIfy+LsBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ulU+NnDDzc78Mk9OdNbpecWpce/OHuhzEN2ov0RnDo35Nq18dfik1WAYUag6lP/OW4
         zazFja5kf5nD4PEY2eRl8+HppZ81oqUbQBhUXrXDfXMEHBL7XKJBafSP1Z9vOLk+XA9H
         8KUKPGIKpPg+xiHKBz6nFBj+Zg7cHvqwvZSmY=
Received: by 10.231.14.137 with SMTP id g9mr14532670iba.183.1281139486255; 
	Fri, 06 Aug 2010 17:04:46 -0700 (PDT)
Received: by 10.231.139.160 with HTTP; Fri, 6 Aug 2010 17:04:26 -0700 (PDT)
In-Reply-To: <AANLkTikL8MtqFr1T=3TKA7GLKSEbyvf+6SLTT2BYehto@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152828>

Heya,

On Fri, Aug 6, 2010 at 19:03, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> struct object_entry is allocated for every object to be packed. So if
> you do a clone on linux-2.6, you would need 1.6M of those structs, 88
> bytes each. I cut 8 bytes from each of them.

Sure, that was clear enough. But _how_? What needs to be done to
retain this? Are there any downsides?

-- 
Cheers,

Sverre Rabbelier
