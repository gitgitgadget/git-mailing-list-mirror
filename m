From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Is anyone working on a next-gen Git protocol?
Date: Wed, 10 Oct 2012 20:08:41 -0700
Message-ID: <CAJo=hJsFLqV7ye0LZzQOrt6EpUXNVjqYfPp9ixO52=CBWcQtdw@mail.gmail.com>
References: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com>
 <5072973D.4080703@op5.se> <7vtxu5lyjr.fsf@alter.siamese.dyndns.org>
 <035A66D9-FAF0-48EE-B161-7D0CAD92F2FB@zib.de> <7vlifeawd5.fsf@alter.siamese.dyndns.org>
 <CACsJy8DMStBNjucU2eitNdkYgk-1K04dxhqV2gpKOZkpLzR_iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Andreas Ericsson <ae@op5.se>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 05:09:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM999-0000fH-9p
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 05:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177Ab2JKDJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 23:09:04 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:42493 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab2JKDJC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 23:09:02 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so902530iag.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 20:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ah6n7cZhmP2lfMLw0F1H/vH0OO3GsMlMYDkht7sptJ4=;
        b=dpmu4+8D76ylj+4+5OKZZFXantY6/GgLUOHzxL8shW3vhB2QFEgOYus+/GhfSQ5qPL
         /qDh+yzSUrzG/1wt2VETl1ki2sPQ7TTpG0uGbi2jxecIxt4sEitNekbnO8AIUbJTWmL1
         6rQyYcs1R1cR9Hj0E0jKCRc0zeecduCV9dzFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=ah6n7cZhmP2lfMLw0F1H/vH0OO3GsMlMYDkht7sptJ4=;
        b=NyITRGf3PEVlxdXQCJBxmjvyjkIs+bB5GkCYhwAT1e12wFVWHCqxZcrbF8b6Kso3BP
         wB7WE6Q6xecdpQXpoLlJtZDgg9vrpB8cevbcjUHIGDbtPOsnIkrzsTzii7XhgBCuNFOr
         ukOHvR6pqDE9kTp122d5Wb7ONjpo5KGruwLysUAD0mI0i0gQIkE3x9y+n78UvXSGl3AL
         oCuTPwxrRI0i4miLm+A0d6kMD/Mr6rGPvn+c0B+LatrILowavOagH3/PF0cK62+p3eHD
         g8HLdYtWxLdt4UhInCdrAEhRxIsCdkdolSosOwOlkTwRsLKOzgMz/MUncWOxgaA50qWI
         01+w==
Received: by 10.50.197.170 with SMTP id iv10mr7426253igc.24.1349924941778;
 Wed, 10 Oct 2012 20:09:01 -0700 (PDT)
Received: by 10.64.143.106 with HTTP; Wed, 10 Oct 2012 20:08:41 -0700 (PDT)
In-Reply-To: <CACsJy8DMStBNjucU2eitNdkYgk-1K04dxhqV2gpKOZkpLzR_iA@mail.gmail.com>
X-Gm-Message-State: ALoCoQmWeAIXkDG9yPSHLa6MJe4e8ezximvJZP89Q8kVmjkR+zMRdaRsC/gyuzK8NcJDGz6q1GBR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207457>

On Wed, Oct 10, 2012 at 6:44 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Thu, Oct 11, 2012 at 3:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Steffen Prohaska <prohaska@zib.de> writes:
>>
>>> I've recently discovered that the current protocol can be amazingly
>>> inefficient when it comes to transferring binary objects.  Assuming two
>>> repositories that are in sync.  After a 'git checkout --orphan && git
>>> commit', a subsequent transfers sends all the blobs attached to the new
>>> commit, although the other side already has all the blobs.
>>
>> I do not think it has anything to do with binary, but what you
>> deserve from using orphan, where you declared that the history does
>> not have anything to do with the original.
>>
>> If both of your repositories had the two paralle lines of these
>> histories as branches, the transfer would have went well with or
>> without binary objects.
>
> On the same inefficient subject, git does not try to share common
> objects for non-commit refs, for example tags pointing to trees. I
> have such a peculiar repo and if a new tag shares 90% the tree with
> existing tags, git-fetch to sends the whole tree of the new tag over
> the wire. It does not seem easy to fix though and is probably rare
> enough that does not justify proper support. As a work around, I
> generate commits that link all these tags/trees together in a
> predetermined order. Not nice but works ok.

Aside from saving a huge amount of CPU during the "Counting objects"
phase, the compressed bitmap work we presented in JGit solves this by
working off the complete reachability graph, and not just some subset
related to a cut made across the commit graph. Unfortunately we took a
shortcut and didn't create bitmaps for non-commits, but this is a
trivial modification to the algorithm and the storage.
