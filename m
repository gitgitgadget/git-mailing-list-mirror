From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Mon, 13 May 2013 12:22:57 -0400
Message-ID: <CACPiFCKkzSCaSfqExZggFHBAmcPBTYYhyauOa2h1dXiYqKZMxA@mail.gmail.com>
References: <7vipezaaig.fsf@alter.siamese.dyndns.org> <1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
 <CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
 <20130511055647.GA3262@iris.ozlabs.ibm.com> <20130511061322.GB3394@elie> <20130511094119.GA6196@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-2?Q?Zbigniew_J=EAdrzejewski=2DSzmek?= 
	<zbyszek@in.waw.pl>, Martin Langhoff <martin@laptop.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 13 18:23:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbvX0-0007M3-S6
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 18:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506Ab3EMQXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 12:23:19 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:48512 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768Ab3EMQXS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 12:23:18 -0400
Received: by mail-qa0-f53.google.com with SMTP id f11so1490537qae.12
        for <git@vger.kernel.org>; Mon, 13 May 2013 09:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EF6Z16KI3dtnIbc6ycxAAdS+O+1Bh2b1CFSEWtoMAIg=;
        b=z/KPftjfqN2vx4bn7YKnT2Ks5dn9B7/+1lOP8CSaiFth6zbwUKqMuiNkJ98CLGrJJ4
         M30EyQacWKSayOKkVybfvoCczxFmRIji4jizV5gMq1cbERaHKU/QFusHGtW34/jURAxq
         rGiBX+NTWPqm/ESXIsTXQhjs9I4o9wE5Qv0fDzKghpMVA0k/6jCMlbiUZdXo9WpZDnzJ
         d5VQRfo+8csbHcYUCkt4SGAmfWwwuwP6E4ss9aEpVITNaYLIzoDl4yw/71ofgyra2yyy
         IAp3NyeMb/7+OuMj2hq0H25XQOFHjpyx0pEU18U+VUjQzgUzIgLxfcUUOHXQorUKEzRk
         iE8A==
X-Received: by 10.229.77.99 with SMTP id f35mr1342202qck.65.1368462197542;
 Mon, 13 May 2013 09:23:17 -0700 (PDT)
Received: by 10.49.96.201 with HTTP; Mon, 13 May 2013 09:22:57 -0700 (PDT)
In-Reply-To: <20130511094119.GA6196@iris.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224177>

On Sat, May 11, 2013 at 5:41 AM, Paul Mackerras <paulus@samba.org> wrote:
> On Fri, May 10, 2013 at 11:13:22PM -0700, Jonathan Nieder wrote:
>> Paul Mackerras wrote:
>>
>> > I thought I had replied to this patch; maybe I only thought about it.
>> >
>> > Given that we already have a selector to choose between exact and
>> > regexp matching, it seems more natural to use that rather than add a
>> > new selector entry.  Arguably the "IgnCase" option should be disabled
>> > when "adding/removing string" is selected.
>>
>> Thanks.  I think I disagree: "log -G" and "log -S" are different
>> operations, not variations on the same one.
>
> OK, fair enough, and I see there is in fact a --pickaxe-regex we
> could use.

And to be honest, log -G is so much more useful that I don't care a
s***t for log -S.

Essentially, to use log -S you need to know that the string the change
you are looking for changed all together. That's a high threshold of
knowledge to meet before you find something; you essentially have to
know what you are looking for pretty well!

In other words: You find a suspicious-looking line of code and you ask
"how did this horrid code come to be?", and the more horrendous the
code is, the more likely it is to be the accretion of a several
commits. In that case, which to me is the common case, log -S ain't
your friend at all.

cheers,




m
