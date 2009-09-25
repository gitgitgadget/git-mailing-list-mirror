From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: thoughts on a possible "pre-upload" hook
Date: Fri, 25 Sep 2009 19:13:16 +0530
Message-ID: <2e24e5b90909250643s5fb469f8x6974fed96aba4db4@mail.gmail.com>
References: <2e24e5b90909220320rbd5fd1l40c7898656445232@mail.gmail.com>
	 <867hvr2cms.fsf@blue.stonehenge.com> <vpqd45jvub6.fsf@bauges.imag.fr>
	 <20090922161725.GS14660@spearce.org>
	 <2e24e5b90909250454s7ed35b9ch10b954b0b1a40cfe@mail.gmail.com>
	 <vpqab0j1a2s.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 25 15:43:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrB55-0006Z6-RV
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 15:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbZIYNnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 09:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbZIYNnN
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 09:43:13 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:63486 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbZIYNnM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 09:43:12 -0400
Received: by iwn8 with SMTP id 8so1536717iwn.33
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=/nj9xhN0DLN4gYcp2ErT/uYtk3lswf44D8DE0N4o9ok=;
        b=AcoiMUMpvOMoaVLWWEm3T8ncXVHxGu3X6eM7TFKxVg0A2c0ZH+5vX9PLIzVMjQnzRw
         OFfjyxKx1lmT8tajpY01193Ltqk8UBs7XrXiGYEMvN+p3l5Mv2xJJqcw6FUHpmQcXfSX
         boqBr3v/X8c8ydO1y2Ys9IgFeh7NEvv84wGX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=neFZlMAAdxh43lhWYT/MzSBw8Z/RJeBrHaScrJ5UdjsL/vavo5E02+2C8TNcHco5t4
         3tcYC0iwsymT+NX7hMjJ9Ez6JxWdyarJy8sHqnoie99C5jXJSZD0y7tMilbkUeifws4a
         9IERfZJ8lSfCq64PBEt3/4Bd0ylrb15B90ogE=
Received: by 10.231.42.150 with SMTP id s22mr317808ibe.22.1253886196165; Fri, 
	25 Sep 2009 06:43:16 -0700 (PDT)
In-Reply-To: <vpqab0j1a2s.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129082>

On Fri, Sep 25, 2009 at 5:59 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> yes indeed -- if someone were to foolishly merge a "secret" branch
>> into a "normal" branch, so that it is now reachable from a "normal"
>> branch, that's his problem -- that cannot be within the scope of this
>> check.
>
> Merging is not the only scenario. Adding a tag could make secret
> things become visible too. I'm not saying the approach isn't viable,
> but if it gets implemented, it should be done with care to make sure
> there's no easy mis-use that would lead to reveal a secret (typically,
> I'd do that with a whitelist and not a black-list, so that new
> references are secret by default).

A whitelist may be better, but I'd be quite happy with a blacklist, if
that's easier to implement, and take on myself/my team the onus of
ensuring that code remains unreachable from any of the non-blacklisted
tags.

In other words, I don't expect this to be idiot-proof and I'll take
what I can get and work with it :-)

-- 
Sitaram
