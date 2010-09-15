From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: ls-files --exclude broken?
Date: Wed, 15 Sep 2010 19:41:50 -0400
Message-ID: <AANLkTi=L0PA-p5HkWnurfurfyYAQhCBt+Q7SzzCczFLH@mail.gmail.com>
References: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
 <7v62y661pl.fsf@alter.siamese.dyndns.org> <AANLkTimYNtU7sHn4_Vx50evTWDpMK_=XgshU3ZzT+eVw@mail.gmail.com>
 <AANLkTik7ORPUsABJv-bFraFNt2TvP0Xx=-013P2=A6Nr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 01:42:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow1cd-0001eW-OD
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 01:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262Ab0IOXmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 19:42:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57979 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab0IOXmV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 19:42:21 -0400
Received: by iwn5 with SMTP id 5so506831iwn.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 16:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=U9C/PBof2OxaoXZCIZmJ5EF11c/LVJuLOrduLFJOZ6E=;
        b=BsnjTxyJVInw1USvj27LxvZaG0rNs7ljaN2QYIu/fby9hXJih/RFzHcZygXo1gEeKj
         zxTNUqbsvchVZREe0b6demCABa+OXte0Aq+tftuBL0CLujwT03vOqr8+wLS9kbONwCY6
         QDTfQXgkE6849yV89uJLhL8tJ8TIWFpIgEqn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=d+lUMs3sFfr7u/R11LqXr8AcQFJZhAIUOjj4IJxxvtI4Z3uDyTTwONC88aIwAMfO8B
         PBd3bmPaPdteDskY7mWydjfMytZca/6eAm6PAewCCe1ARLlDl2OSNYxaTUOHVHQdOqr7
         MmrBo2r4nTT3Pu8cC2/kPhO8bOdzSvEC9fGTE=
Received: by 10.231.10.135 with SMTP id p7mr2315625ibp.88.1284594140445; Wed,
 15 Sep 2010 16:42:20 -0700 (PDT)
Received: by 10.231.11.11 with HTTP; Wed, 15 Sep 2010 16:41:50 -0700 (PDT)
In-Reply-To: <AANLkTik7ORPUsABJv-bFraFNt2TvP0Xx=-013P2=A6Nr@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156277>

On Wed, Sep 15, 2010 at 7:29 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> I sense another use of negative pathspecs here..

Yeah, I'm really not sure I agree with the reasoning of b5227d8
(ls-files: excludes should not impact tracked files, 2009-10-12).

I thought about submitting a patch to revert b5227d8, but with an
additional option to guard the behavior
(--exclude-cached-files-too-pretty-please).

But I guess I don't see the harm in allowing excludes to apply to
cached files when it is explicitly requested on the command-line. Here
I think ls-files is slightly different than the other areas of git
that don't apply excludes to cached files as it's about, well, listing
files, and it's clear (I think) what the user wants.

But I'll go dig in the mailing list archives now to see if I can find
what motivated Jeff's change beyond what he gave in the commit
message.

j.
