From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Wed, 26 Jun 2013 19:32:21 -0600
Message-ID: <CAJo=hJuA_4zL-cyygqPkDA+6ipbTqsmMYHw-c6OTKCcb5GAs0g@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-10-git-send-email-tanoku@gmail.com> <CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
 <CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
 <20130626051117.GB26755@sigill.intra.peff.net> <CAFFbUKJZ1w2puKFLjPNZmMhSLo3_1kpfA1upv7K6qZV256vTyQ@mail.gmail.com>
 <CAFFbUK+emr44o_2EHW2Y4o5fs8Livif_5D=G=NLDzE=2MEx6NQ@mail.gmail.com> <CAFFbUKJTh79-u-D89OAZxjCnfvyZ40DE_iwQ6e+zXSw88AY6PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	git <git@vger.kernel.org>
To: Colby Ranger <cranger@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 03:33:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us150-0004dN-RT
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 03:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab3F0Bcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 21:32:42 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:47736 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518Ab3F0Bcl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 21:32:41 -0400
Received: by mail-ie0-f175.google.com with SMTP id a13so380648iee.34
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 18:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UZ8vIFpdUeupvVAaD88BAVkKKnElFqFotG82aqB876k=;
        b=ZPlpYmYevIKrVA9udsuDjR1ABn6Fr3KJe0f4P9cU1OYg3rfUpPArUrbXfr4bH6TfGa
         KNDr7cdg0sllsgkXR1QNEQA+VHZ66Dgnl+9uGSDh8dfAriRhLCI/4RUxt5XneZU+RrPT
         De3LnV+/XVlvtPt83thX1Rdj2tsk4Rn6S9aB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=UZ8vIFpdUeupvVAaD88BAVkKKnElFqFotG82aqB876k=;
        b=Gv+ALlaqJKEg/KcLFk9eoLLewOYNaZWptYaq1aTphNMNyx6HvoXwiW0Bpucmz2y+Bo
         g8wI9XV2uLrJ7hoKYwEMowqFOyCAfVV9fKKE288nk5bpR4jPi/iSgEYOTb9MyXkqImkl
         L3KYx2QgOx5hg8sissY5R7ulOvcWyUxL3K1qo6+YQ8CanuiMKe5PV2fJWD6pugfElinz
         /WhwSHx24xClitSM3M8JUzeaIOBYWFMT4YS884w3nQXh1fz2+gYxeMwgTPFYIgOxWSN9
         sgX0Bta+XS5917tn8qz+VwkgUM7+GK3AhHkjtbQvTdiQRD+CCGdYMEPqZsbMZK4d+xnR
         mmgQ==
X-Received: by 10.43.84.131 with SMTP id ak3mr3530801icc.84.1372296761504;
 Wed, 26 Jun 2013 18:32:41 -0700 (PDT)
Received: by 10.64.82.38 with HTTP; Wed, 26 Jun 2013 18:32:21 -0700 (PDT)
In-Reply-To: <CAFFbUKJTh79-u-D89OAZxjCnfvyZ40DE_iwQ6e+zXSw88AY6PQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQk5vXU/HYNTQcOFWLmAB7ULIP/uWvWjAV1EBQ2Hx8kxBVPdy8PfQcQPiq4Q3iEPNekpnnYH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229080>

On Wed, Jun 26, 2013 at 6:53 PM, Colby Ranger <cranger@google.com> wrote:
>> +  Generating this reverse index at runtime is **not** free (around 900ms
>> +  generation time for a repository like `torvalds/linux`), and once again,
>> +  this generation time needs to happen every time `pack-objects` is
>> +  spawned.

900ms is fishy. Creating the revidx should not take that long. But if it is...

> If generating the reverse index is expensive, it is probably
> worthwhile to create a ".revidx" or extend the ".idx" with the
> information sorted by offset.

Colby is probably right that a cached copy of the revidx would help.
Or update the .idx format to have two additional sections that stores
the length of each packed object and the delta base of each packed
object, allowing pack-objects to avoid creating the revidx. This would
be an additional ~8 bytes per object, so ~19.8M for the Linux kernel
(given ~2.6M objects).
