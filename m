From: Shawn Pearce <spearce@spearce.org>
Subject: Re: PROPFIND 405 with git-http-backend and Smart HTTP
Date: Mon, 30 Jul 2012 13:42:25 -0700
Message-ID: <CAJo=hJsES44mXWjKmFqe7z+T_FHZ6Pi19toURyVp-wvW8AqQiw@mail.gmail.com>
References: <1343587966493-7564017.post@n2.nabble.com> <CAJo=hJtB6OQ8+8Q_JgPoAntOdQ=Z0tOERYRD7wJ0LRLgacYA8A@mail.gmail.com>
 <1343637600904-7564056.post@n2.nabble.com> <CAJo=hJtynNo3SPmM4vmmsS3b7PTUwOcQpHPYh0_sPWFWL-4HMA@mail.gmail.com>
 <1343680215071-7564137.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Bo98 <BoEllisAnderson@aol.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 22:42:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svwnj-0000Uj-Uc
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 22:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926Ab2G3Umr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 16:42:47 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:41670 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819Ab2G3Umq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 16:42:46 -0400
Received: by ghrr11 with SMTP id r11so5347110ghr.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=znLTfRjw1ndLmPz639UGNRxecQ3KEhlV8WUjtk1rC/c=;
        b=OT/TUy8EQ3S+7aApEqNRojqwdzxFh8H6b5kAqcQJWoCm5LGSGHrQujUOpC7oIQIAPH
         S5d2XFB283ertCebrOxbFsfB5mk0HN7vMk+MSTRVBycx1x/FQHtYkIx2D4CP5QihVNnL
         E9bSjQnyxHHzrjyw1pbnvnvnbclKxCw3SBhDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=znLTfRjw1ndLmPz639UGNRxecQ3KEhlV8WUjtk1rC/c=;
        b=hE2xny0zaWCuIZUG+qHvz7YqlJwIgGaM2DbOvGK+tACKip+9wP/Aq89qBUJVnM56az
         +C8J6hSajYSB32Q34Gi0bhSCs2fq1gLRZN8owHczzvpQQjunBkezfySss0n/tRZpBA7Z
         zvh8fALf9AEa3Do2jdWGiwCRBMnT/+M2zJw2ORzbo+5eb8mBrNivRzI7P0pTlfYOxrFz
         PEd33NubhYZuvcuZRJCX5fnzj/kpSeYQEtS4W7oPzZOjIja4+kVE6hsCa6f/pRN7jXFe
         lIDzTLMFTe+nlOMvza+8Q37n5NkrUnBhIPdzeiqwHaEBLsfuFT6qgyMyKRDENrN+w2wm
         I1CA==
Received: by 10.50.94.195 with SMTP id de3mr367400igb.68.1343680965597; Mon,
 30 Jul 2012 13:42:45 -0700 (PDT)
Received: by 10.64.14.177 with HTTP; Mon, 30 Jul 2012 13:42:25 -0700 (PDT)
In-Reply-To: <1343680215071-7564137.post@n2.nabble.com>
X-Gm-Message-State: ALoCoQmryt6liaIhK1KkDpwlmTW/aYUrq+eJCyS2ieKoPKdPqgoYqrQL984RGMYY19NYewp+6wK6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202613>

On Mon, Jul 30, 2012 at 1:30 PM, Bo98 <BoEllisAnderson@aol.com> wrote:
>
> Shawn Pearce wrote
>>
>> No, a smart HTTP response looks more like this:
>>
>> 1e# service=git-receive-pack
>> 000000a5e7a3bcbbb8083e812ce07a5459f0e6d30edfb9fe HEAD include-tag
>> multi_ack_detailed multi_ack ofs-delta side-band side-band-64k
>> thin-pack no-progress shallow no-done
>>
>> Looks like Apache isn't calling the smart-http CGI.
>>
>
> Oh ok, thanks! But do you have any idea why? Everything in my config looks
> okay to me. I've got my GIT_PROJECT_ROOT, my GIT_HTTP_EXPORT_ALL, my
> ScriptAlias and my LocationMatch. I'm not sure why it's like this.

Maybe you forgot to enable ExecCGI?
