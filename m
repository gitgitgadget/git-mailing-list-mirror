From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Sat, 1 Oct 2011 18:45:38 +0000
Message-ID: <CAMOZ1Bsc2idQnKxeggruPi1rrY3+vsa=DoMydHY4+BM+qoW69w@mail.gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <119711285.RuumktFLOq@hyperion> <loom.20110930T041939-332@post.gmane.org>
 <CAMOZ1BsTKBPArRF-LxoNOJcQarMWx-2a2UBoVjWN-96xJ3Ad8A@mail.gmail.com>
 <loom.20111001T073652-884@post.gmane.org> <CAMOZ1Bvn64q5sVfo2-ZhTSpBttpjG1pHELJMM9sEmWsrqANCkw@mail.gmail.com>
 <loom.20111001T191413-25@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Shenkin <shenkin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 20:46:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA4Zu-0001pA-UO
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 20:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab1JASqU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 14:46:20 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47585 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166Ab1JASqI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2011 14:46:08 -0400
Received: by iaqq3 with SMTP id q3so3125669iaq.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Xu0isCPbX2wkw06UTA6H1Bg8GqdH7tyb6Y3Mb/Sygks=;
        b=MobfX7+WKk0PibXPnPf8WVStKARJzEif1VEqkx10RbYTzueQ7OYc2b2QK5u+QTaowQ
         eF22ERFeu/IP0djDvJfjLYhjr0xGl/067V0dGrUmgB49RFmsf/AzcTuaOPLtOf0q70sr
         DniMXPg0jHbu0c1Xmvwfi+/WNfHJRifUbL8dM=
Received: by 10.42.117.133 with SMTP id t5mr4797593icq.222.1317494768121; Sat,
 01 Oct 2011 11:46:08 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Sat, 1 Oct 2011 11:45:38 -0700 (PDT)
In-Reply-To: <loom.20111001T191413-25@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182569>

On Sat, Oct 1, 2011 at 17:16, Peter Shenkin <shenkin@gmail.com> wrote:
> Michael Witten <mfwitten <at> gmail.com> writes:
>> However, my point was this:
>>
>> =C2=A0 You can still tell git to fetch anything else you want in add=
ition.
>
> Michael,
>
> Yes, you are right. I am still missing how to do that.
>
> Can you show me a sample fetch invocation that would
> have the effect of downloading all tags and also branch heads?

Unfortunately, there's currently no way to tell "git fetch" to
download whatever your configuration files specify as default, but you
can at least be explicit by using what's called a "refspec" (which is
documented in "git help fetch"):

  git fetch --tags origin '+refs/heads/*:refs/remotes/origin/*'

You could probably get your hands on the default refspec by rigging
something up with "git symbolic-ref" and "git config", but that's so
much hassle; currently, it is probably best just to run "git fetch"
twice.

Sincerely,
Michael Witten

You might also find this email insightful:

  http://article.gmane.org/gmane.comp.version-control.git/181911
  Message-ID: <7142366f54c44cea82542adf8aea5bb9-mfwitten@gmail.com>
  Subject: Re: any way to "re-sync" a bare repository against
               another bare repository?
