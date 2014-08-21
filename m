From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH] Check order when reading index
Date: Thu, 21 Aug 2014 15:49:02 +0200
Message-ID: <CAPuZ2NGfKtc3+JyywNeuEk5Yx_mTAM6QLs1S5p49TWxkUe6_SQ@mail.gmail.com>
References: <CAPuZ2NEksZzt29XpAaszK8oc4iXH4OTGzRSsHUrtwgrv6bU_0Q@mail.gmail.com>
	<1408628606-12975-1-git-send-email-jsorianopastor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 15:49:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKSjl-0000S0-EW
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 15:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbaHUNtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 09:49:05 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:50088 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843AbaHUNtD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 09:49:03 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so13645915pdi.6
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BC39C9XGZvOjnd6UvFXrR7Kc/kIuASZVTB2bTLz5Qlw=;
        b=BEYHUYZv2OGtDvnXdbb2QDZzXqjtc8uiLIwWCinQ/Qgh/vMGWaZxtmNCL/B5lsu1uf
         5i8uPptEvnQdzICoiBLM71GKVRfitgEgaokpKPuKKBRjDUaAy5kepZQOvMdgr+PBvtWS
         majVucsQUgGLdawfSt45SSzvb9/CyxPU/z+DJy0uKuiI1hDrtvBlZxVVILmOubKxd5Zr
         yhAba67q/jVI52PXDEY9aCYEFxMD5einCgbkqLUqk0Fj07EpEinV6w9REtgH/c685BNI
         6YOSfNYOUeBVxeWGDczH50sYCG6nOsIPq53FEbukt+VBDt61Hf9okSgApkilK3hzTNF1
         qlaA==
X-Received: by 10.68.136.100 with SMTP id pz4mr1766084pbb.119.1408628942721;
 Thu, 21 Aug 2014 06:49:02 -0700 (PDT)
Received: by 10.70.37.2 with HTTP; Thu, 21 Aug 2014 06:49:02 -0700 (PDT)
In-Reply-To: <1408628606-12975-1-git-send-email-jsorianopastor@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255613>

On Thu, Aug 21, 2014 at 3:43 PM, Jaime Soriano Pastor
<jsorianopastor@gmail.com> wrote:
> +               if (!ce_stage(ce))
> +                       die("Multiple stage entries for merged file '%s'",
> +                               ce->name);

This case can be provoked by "git update-index --index-info" as shown
in the patch with the added test, maybe it should be only a warning.
And add too some variation of the patches in this thread to make the
same command able to fix the situation.
