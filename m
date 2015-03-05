From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Thu, 5 Mar 2015 07:26:43 +0700
Message-ID: <CACsJy8BcL3=uYa6=zA9UfV5A9sYqhcrJte40y03sfCcsCkKdhA@mail.gmail.com>
References: <20150218191417.GA7767@peff.net> <54E6C78D.3070506@alum.mit.edu>
 <20150220072924.GC8763@peff.net> <vpqpp94exb5.fsf@anie.imag.fr>
 <70A3994196D94205B75660D9DEFF0A12@PhilipOakley> <CAGZ79kaNZsBP19gLvsrDx6RLyQ7QhmbKAgSDcXg71Uwcvf9tNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 01:27:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTJdH-0008OF-BQ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 01:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbbCEA1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 19:27:15 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34259 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365AbbCEA1O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 19:27:14 -0500
Received: by igal13 with SMTP id l13so38116519iga.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 16:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KMfDnW7Sxf65V9X+Se63T7FDmfY7r0T5FxPZiFaqBtQ=;
        b=ytD5EC3ZiwmvBc1h1AfGE8LQSFduggdfW5ctV5aPi26yTNgESVHoRsAnoejBemo7Pc
         n7c7xq/zUA4RK73mhXtRD7Giu/z1BDNF1XqReXLuoHz0pJF+5Vl2K5JoerDqAc1wwx/h
         hD3NKf+L4eX38djaXGIDyw83BJWmiSyp+rWe7+oV7YdXpdhpMYjbjXOHoBMrrMI02txA
         DVx0ie5rcEAXj0Obuho1uPh4HEiR16ky1nfLd4IabQdaOlPe5UmzlqwW9u91Z6JDo9C8
         kddoCy3AFDzlvexl+S+KYUcRF7Dp2L0ZAvlLwJTOtnnnPbeItmlXcfviP4BXHbM+dfZG
         CSgg==
X-Received: by 10.50.111.202 with SMTP id ik10mr16404059igb.37.1425515234054;
 Wed, 04 Mar 2015 16:27:14 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Wed, 4 Mar 2015 16:26:43 -0800 (PST)
In-Reply-To: <CAGZ79kaNZsBP19gLvsrDx6RLyQ7QhmbKAgSDcXg71Uwcvf9tNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264801>

On Thu, Mar 5, 2015 at 6:55 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Mar 4, 2015 at 2:05 PM, Philip Oakley <philipoakley@iee.org> wrote:
>
>> A possible idea is to add a date based variant of shallow clone :
>>
>>  'git clone --date <when> ...'
>>
>> in the same vein as the existing depth (shallow) clone.
>
> As food for thought:
> Maybe broaden this further up to the git-ish way of describing refs, so
>
>     git clone --since 2.weeks.ago <url>
>     git clone --since v2.10 <url>
>     git clone --since c0ffee^^ <url>
>
> would all equally work?

Yes, and we could generalize it further: add shallow-rev-list
capability and send "shallow-rev-list <rev-list options and _some_
rev>" line to define shallow boundary. The protocol change would be
simple enough. The hard part is select a safe subset of rev-list
options that can be used in this mode and reject the rest.

> I am not sure if that is feasible though, but it would come in handy. (E.g.
> you are an end user and want to bisect down a bug which you notice in the
> new version X but not in old version Y, so you start on getting the sources,
> compiling, bisecting)
-- 
Duy
