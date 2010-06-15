From: Joshua Shrader <jshrader83@gmail.com>
Subject: Re: Fixing branches from a (really messed up) subversion repository
Date: Tue, 15 Jun 2010 12:40:38 -0400
Message-ID: <AANLkTim6pBqc1qQhvGrzmf5FDbVkfw1GmNP00BM_99n4@mail.gmail.com>
References: <AANLkTinmU3tOkv9usjGogHn5cXm07FMde8ryDKuWNKD_@mail.gmail.com>
	<AANLkTink-Rm44xnzBHVo6W_29YCPrjScnolqx_9B8A5G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 19:08:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOZcg-0001gw-3R
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 19:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757922Ab0FORIV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 13:08:21 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59218 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757857Ab0FORIU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jun 2010 13:08:20 -0400
Received: by gwj15 with SMTP id 15so3374218gwj.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 10:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yX2pejljVmWsVBBx2Gr36je3Wa7kN5jbiRA2cOTqxWw=;
        b=OPetavQXSSVjSb/rt/ShLjL8ExDhQQAWhc4KZUk1ejgVJJMG5n9D1kNFzZ9lxNhxBo
         PQUmcr9EectaTVYfPHyccTRyUjJe27DQqkNsTxgKOAKtFt5dGIuMJCnJS9KhRKYenFNB
         nUNZkIEDdNRV+xzxuWhUhbNEj1shiw0yaBrUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=r2LdA7bvXkoMYT5LclDenr4IyAPMcsMi/4KaIOHTxPOMYlQbz5JxjkMlz0lDXe06TH
         ApcK/SFrvTWgAD8MjyeFV/njMUUFl+o/EA1I2PJBVNatPAKXT60LCA2oULmZmKVUduFt
         tWN/uqnSpRAr6zCucoa269T4XUu2Tx0BxgXlI=
Received: by 10.229.251.206 with SMTP id mt14mr1191298qcb.161.1276620038461; 
	Tue, 15 Jun 2010 09:40:38 -0700 (PDT)
Received: by 10.220.106.167 with HTTP; Tue, 15 Jun 2010 09:40:38 -0700 (PDT)
In-Reply-To: <AANLkTink-Rm44xnzBHVo6W_29YCPrjScnolqx_9B8A5G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149210>

Not quite sure if I understand correctly.  Can Git import directly
from an SVN dump, or are you suggesting to essentially re-build the
svn repository correctly, and then import?

On Tue, Jun 15, 2010 at 12:29 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Jun 15, 2010 at 16:26, Joshua Shrader <jshrader83@gmail.com> =
wrote:
>> I've finally convinced my project to switch to Git... =A0However, wh=
en
>> my project first began, the people responsible for branching/tagging
>> were fairly unfamiliar with standard procedures. =A0As such, the
>> beginnings of our repository look a little something like this:
>>
>> .
>> `----project
>> =A0 =A0 |
>> =A0 =A0 `branch1
>> =A0 =A0 | =A0 =A0 =A0 =A0 =A0|
>> =A0 =A0 | =A0 =A0 =A0 =A0 =A0`----project
>> =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0`src
>> =A0 =A0 `branch2
>> =A0 =A0 | =A0 =A0 =A0 =A0 =A0|
>> =A0 =A0 | =A0 =A0 =A0 =A0 =A0`----project
>> =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0`src
>> =A0 =A0 `src
>>
>> That is, the branches were essentially inside the trunk. =A0In order=
 to
>> check out the "mainline" of development, you also got all of the
>> branches. =A0After a few branches, they realized that this was a
>> problem, and someone found out about the trunk/branches/tags paradig=
m.
>> =A0Our branches were svn mv'd to separate directories under "branche=
s",
>> and all was well. =A0Now everything looked like a sane version contr=
ol
>> repository.
>>
>> Now, we want to import this into Git. =A0I tried git svn import
>> --stdlayout..., but this just stalled. =A0I'm assuming because the f=
irst
>> version didn't have a trunk/branches/tags structure. =A0So, I had to
>> import it leaving off the --stdlayout option. =A0Is there any way to
>> manually fix this in Git? =A0After the import is complete, my master
>> branch will have a trunk, branches, and tags directory in it. =A0Can=
 I
>> create real branches out of the directories under the branches
>> directory and then remove them from master?
>>
>> Any help is greatly appreciated. =A0I've been hoping for a while tha=
t
>> we'd switch to Git, and I don't want this to hang us up.
>
> I have the same problem on another project, and after looking at the
> components involved it seems that the easiest way is to filter the SV=
N
> dump, then import it into Git.
>
> It's quite easy to write a filter with SVN::Dump that does this,
> i.e. just do a few string replacements on the paths before a given
> revision, and drop the revision where you moved things.
>
> A lot easier than convincing git-svn to do what you want, anyway.
>
