From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 3/3] builtin/show.c: do not prune by pathspec
Date: Thu, 31 Mar 2011 19:50:46 +0700
Message-ID: <AANLkTik4wy3B1S=7_2opLdAVy5LBq55VsfZnkj0=QskC@mail.gmail.com>
References: <2590090d32e748932d988dff3897058b909e8358.1301562935.git.git@drmicha.warpmail.net>
 <4D94322A.8030409@drmicha.warpmail.net> <3bee7fb376e2fb498c9634ab2ff5506f8c74a7bc.1301562936.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 14:51:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5HLO-0003TS-M3
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 14:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab1CaMvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 08:51:17 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:52758 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab1CaMvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 08:51:16 -0400
Received: by pxi2 with SMTP id 2so522539pxi.10
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=XL9RcYtTs/y7Ry+oldtbIWOgrlggA4A9xqHHtIfsH9o=;
        b=oN7OwwloszgKVYQgl1dmDlVO5asHPKhvwCHQ83/oUdyJak/wfkphqSWrbKTm9n+gxd
         7hrD9xVqM3FkkqOQU+7kpFqWMkn+Wx5VQYNmUfRPsw5RRDoY8PgG7rSXla9hce872iV9
         5n83c/SeYt7OEXxrid77tl4v+47sotop2i+zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=k8KYV7C8bJUUcO4M/Vfcqx4eL7njVmMezkIb/Fo9xImu376YZYSo/Hl8pzYS2m+rBv
         q7KEaW7v3mCqrqsKb/NCWTQHwsOol5uIZ7bW2OaG8NRmG2bPGWWtCaC1KwsOkXxsJeBP
         KKLrf0KF/FLkOkR3gYNkPNLgOVCiFsx1r/QSE=
Received: by 10.142.202.12 with SMTP id z12mr1880163wff.442.1301575876083;
 Thu, 31 Mar 2011 05:51:16 -0700 (PDT)
Received: by 10.68.42.234 with HTTP; Thu, 31 Mar 2011 05:50:46 -0700 (PDT)
In-Reply-To: <3bee7fb376e2fb498c9634ab2ff5506f8c74a7bc.1301562936.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170484>

I suggest add "commit" to the subject: do not prune commit by
pathspec. Diff limiting is another kind of pruning and I was confused.

On Thu, Mar 31, 2011 at 4:17 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> By design, "git show commit -- path" is not "git show commit:path", and
> there is no reason to change that.

Even more true, now that "path" can be "*.sh".

> But "git show commit -- path" simply
> returns nothing at all "most of the time" because it prunes by pathspec
> even though it does not walk commits. This is pretty useless.
>
> So, turn off pruning (but keep diff limiting of course) so that "git
> show commit -- path" shows the commit message and the diff that the
> commit introduces to path (filtered by path); only the diff will be
> empty "most of the time".

Tests please?

> As an intended side effect, users mistaking "git show commit -- path"
> for "git show commit:path" are automatically reminded that they asked
> git to show a commit, not a blob.

Nor a tree. I don't really see how "git show commit:path" and "git how
commit -- path" are relevant for it to be mentioned here.
-- 
Duy
