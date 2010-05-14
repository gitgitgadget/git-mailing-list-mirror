From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Git methodology question
Date: Fri, 14 May 2010 14:44:10 -0700
Message-ID: <AANLkTikCHpIJYsORc2buuZkCNgg3dJAt-r7QuNI_dELv@mail.gmail.com>
References: <20100505033536.GB8779@coredump.intra.peff.net>
	 <cover.1273760226.git.git@drmicha.warpmail.net>
	 <20100514060612.GA19652@coredump.intra.peff.net>
	 <4BED7574.4070503@drmicha.warpmail.net>
	 <F802F7F4D3C2674881AB105A9CD324A804EE0D0D8D@azsmsx504.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Akhbari, Farshad" <farshad.akhbari@intel.com>
X-From: git-owner@vger.kernel.org Fri May 14 23:44:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD2g5-0005D7-Tg
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 23:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759608Ab0ENVoN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 17:44:13 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:54313 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758344Ab0ENVoM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 17:44:12 -0400
Received: by qyk1 with SMTP id 1so3850565qyk.5
        for <git@vger.kernel.org>; Fri, 14 May 2010 14:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y7x3IBKOBS12jHc2h24H/P6DEDtlW05ANVz8kRGkilA=;
        b=wY3x1195a3KmAgn9BO86Pcx0vCZwl1zJGcYg30UQG48FwdfYNNoN/I2uzBwRSVMEEq
         3dQCda3whyg7c3BH3f9gJBLWnBSjK9FKS69wRZPlMAk14LYcyPvkcYkecOcLezlxffWs
         RZmG2cHdE+zwUR6gADPDanJFBxG9sGgYj/RLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u/67XTUcoOEuz+t3vX6ozsGtd9R9rfhWn4M2L6FHqXxvvMdKppGVNlONgdFUvvjZQ7
         e2wlgMIbB3/p8fU+tn7aHTqZXlFrrIOOya2k1UbQ2dnYiiFeroKol6OVg5cqkuEUl4qU
         9QRgLVSDJorbcunN+05nLYVYUHkuQTpHjuL24=
Received: by 10.224.78.4 with SMTP id i4mr1032143qak.95.1273873450262; Fri, 14 
	May 2010 14:44:10 -0700 (PDT)
Received: by 10.229.2.26 with HTTP; Fri, 14 May 2010 14:44:10 -0700 (PDT)
In-Reply-To: <F802F7F4D3C2674881AB105A9CD324A804EE0D0D8D@azsmsx504.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147123>

On Fri, May 14, 2010 at 9:14 AM, Akhbari, Farshad
<farshad.akhbari@intel.com> wrote:
>
> All,
>
> I am trying to setup a "reliable" flow with git. I am sort of new to =
the tool and need some help from the experts. The question pertains to =
the way SHA1 tags can be back-tracked in parallel clones. Here is the s=
cenario I have in mind:
>
> In order of time:
> User1 =E2=80=93 pulls from the origin; updates, modifies, verifies an=
d commits into his clone. This will generate SHA1_1
> User2 =E2=80=93 pulls from the origin; updates, modifies, verifies an=
d commits into his clone. This will generate SHA1_2
> User3 =E2=80=93 pulls from the origin; updates, modifies, verifies an=
d commits into his clone. This will generate SHA1_3
>
> In none of these cases, anyone is updating from each other=E2=80=99s =
clones
>
> At the end of the week, the model builder needs to merge and verify a=
ll commits from user1, user2 and user3 before pushing into the origin m=
aster.
>
> The question is,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Can the model builder use SH=
A1_3 tag only to get all the updates made by user1, user2 and user3; or=
 all SHA1 tags are needed?
>
>
>
> Thanks,
> Farshad.
>

Hi,

I'm not sure if I entirely understand your question. Is "the model
builder" a person?

Making the assumption that it is (the usual term for this would be a
project maintainer) then you might wan to have a read of the
"DISTRIBUTED WORKFLOWS" section of the gitworkflows man page [1].

The short answer, if I've understood your question, is that all 3
developers will have to submit their work to the maintainer. There are
various mechanisms for this; they can either use "git format-patch"
and "git send-email" or request that the maintainer pulls from a
repository that they have published ("git request-pull" can help by
generating a nicely formatted email message).

After the maintainer has applied the changes the developers can then
use "git pull" to get the latest changes from the origin. This will
include their change and the changes from the other developers and may
also  include some merge commits.

As developers get more advanced they may start working on topic
branches and re-basing (or deleting) the branches after the maintainer
has applied their changes. Remember that in this case the topic
branches are local so the developers can do what they like with them.
The maintainer doesn't care _how_ the developers work locally they are
just concerned with the end result.

Hope that helps.

---

[1] http://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html#_=
distributed_workflows
