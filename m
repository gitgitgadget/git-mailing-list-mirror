From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] send-email: Add simple email aliases format
Date: Fri, 22 May 2015 10:17:23 -0700
Message-ID: <xmqqzj4wedlo.fsf@gitster.dls.corp.google.com>
References: <9f88da801466c83331d02262855e8bef4164e5eb.1432266004.git.allenbh@gmail.com>
	<CAPig+cRLxk26p7DFaS+gRkKZxkRwf8g=4=j2QHX6AC2Uk5J++w@mail.gmail.com>
	<CAJ80satbXXBYva9qrgR1oA_f7LAHUeAm21=R-mGsWx+sDoQ9sQ@mail.gmail.com>
	<xmqqlhggfz97.fsf@gitster.dls.corp.google.com>
	<CAJ80sateODWDUvkAf9YbMMSYv_-=nKnBopGjgDFFSkVHuQJJMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 19:17:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvqZi-0000CK-MH
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 19:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946272AbbEVRR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 13:17:28 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33281 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946178AbbEVRRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 13:17:25 -0400
Received: by igbpi8 with SMTP id pi8so41533828igb.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Fud2fuGYRZaPrbZh6VMoQ7U8nn+t3c0U4DkfUDSzyNI=;
        b=o+DHmr2I1z7FdLP0vuhAWYUAeHGNOcLgHF1g5MQcaQQ8MpD2FYEImvWWpkx/qvWPhu
         8ADqkYuOZcP0FAEDPCfm3K6ZCUl7K3UYWKqUB9njMvEpYGqOb6tjCUVartic6lCF4Uvp
         Tcb/gpb0qzABk/hcUPuB79RkWovFC1lpv+rkWyxQ6eO7NeJK6Ox1Psa4aZbCLFe66HMV
         TlspG/Y7fgzxALCRNtkyFWDeDSjRmjRegjYBPmuQdfUxxoCthkKD6BBnX2EskBpWDJcy
         FHTPSdsx37WOwQL8a+jSu6xP2nDqACvCXEb+/0+z4Tu7YTFSYCyNPzsxvs5NuUQNW28F
         XJVg==
X-Received: by 10.107.4.196 with SMTP id 187mr12465859ioe.6.1432315045085;
        Fri, 22 May 2015 10:17:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id d4sm2204067iod.17.2015.05.22.10.17.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 10:17:24 -0700 (PDT)
In-Reply-To: <CAJ80sateODWDUvkAf9YbMMSYv_-=nKnBopGjgDFFSkVHuQJJMQ@mail.gmail.com>
	(Allen Hubbe's message of "Fri, 22 May 2015 11:39:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269740>

Allen Hubbe <allenbh@gmail.com> writes:

> On Fri, May 22, 2015 at 10:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Let me step back a bit.  Earlier you said your aim is not to use an
>> alias file you already have and use with the MUA/MTA, but to have a
>> collection of aliases to use with git-send-email only.  Is there a
>> reason to add support for a new format (whether it is compatible to
>> or subset of postfix/sendmail format, or a totally new one) for that
>> goal?  What makes the existing formats unsuitable?
>
> It's just a matter of personal preference what is suitable or not, for
> me, in my environment, etc.  Is there a reason I should use the alias
> format of some email client, if I don't use that email client?

I do not think "should" is a good word in the context of that
sentence, as nobody is forcing you to choose one of the existing
formats.  But one reason you might want to do so would be because
git-send-email already knows about it.

It is a different matter if you already use an email client that
supports your new format and you are trying to reuse an alias file
with that email client.  But I got an impression that was not the
case, so the choice seemed to me between

 - learning and using one of existing 5; and

 - inventing, adding support for, and using a new one.

That felt to me was a choice that is clearly not in favor of the
latter, and I was wondering if there were other reasons to shift the
balance.  For example, "all of the existing formats are klunky and
difficult to write" might be why "learning and using one of existing
5" is not a win, compared to "inventing, ading support for, and
using a new one".  I do not know if that is the case, so I wanted to
hear the reason why.

> I'm not trying to force anything on anyone else by offering this, just
> another option that might be suitable for someone else, in their
> environment, as it is in mine.  People who don't like it can choose a
> different option.  People who don't like any of the options can write
> their own like I did, or is that not allowed for some reason?

We prefer not to carry dead code---when we add things, we would want
to make sure it will be widely useful so that other people benefit.

> I've already shown that I am willing to change the name, write the
> documentation, write the tests, modify the syntax, and so on.  I've
> done the work, from +6 lines to +57 lines, as requested.  I'm not
> looking forward to v5, v6... v10 of what was a really really simple
> patch.  If you don't like it, please don't string me along.  This is
> not my job.

Yeah, I know.

A trade off from contributor's side is between (1) handing the
maintenance to the upstream, so that a feature will stay available
with minimum fuss in the future, or (2) having to carry one's own
enhancement forward every time one updates from the upstream.

On the other hand, a trade off from project's side is between (1)
rejecting a half-way finished ware and hurting feelings of people
and (2) accepting a half-way finished ware and having to spend
engineering effort (e.g. making sure it fits to the rest of the
system without adding dead weight) to polish it to the end.
