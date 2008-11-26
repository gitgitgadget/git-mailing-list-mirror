From: "Ondrej Certik" <ondrej@certik.cz>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Wed, 26 Nov 2008 11:18:35 +0100
Message-ID: <85b5c3130811260218s7529914eyb56a05ec1ca34b8f@mail.gmail.com>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
	 <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de>
	 <85b5c3130811260135g4646bf72iaf57f599fdd21a0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Fabian Seoane" <fabian@fseoane.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 26 11:19:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5HUv-0004HL-RN
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 11:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbYKZKSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 05:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbYKZKSi
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 05:18:38 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:57735 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbYKZKSh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 05:18:37 -0500
Received: by fg-out-1718.google.com with SMTP id 19so264794fgg.17
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 02:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=4FESQfpYtwytIbXwHX0w7mjjo3y/xPzZ8jB2+Q5Anmo=;
        b=jHgLbnHUgpSHwC3KMgVrAHfq8y9OERkE5UFXScHi4EGdTmrBSn5fzW33xUvpC46jD6
         2PR07bgTv1llwJrK0aQijMi4E3iSqKs26pSe/bNtbP8hrb+t5BgO73wv9pJ4g4K3fiy6
         H70c/32yfY1QYSTUwt4qz1Lvty9d1YWW1UVIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=AfYpv0cvahjzTIpbjge6jzgk4g7S7Y81c3YQIIkmpUj6cj8VTaTu1qln52gDrpp1jC
         BBDlnGC21Ezdpd5d/yYWo9F3s+x4i2RiXHpl9H+p7AOGxxSpTf/IySApLgYcsfYsgE+M
         yiW0dn9SJae16Hi98NeNo4mCI3QadDHaXsLNw=
Received: by 10.86.4.14 with SMTP id 14mr3659460fgd.76.1227694715239;
        Wed, 26 Nov 2008 02:18:35 -0800 (PST)
Received: by 10.86.33.8 with HTTP; Wed, 26 Nov 2008 02:18:35 -0800 (PST)
In-Reply-To: <85b5c3130811260135g4646bf72iaf57f599fdd21a0c@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: d814176bee32e532
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101721>

On Wed, Nov 26, 2008 at 10:35 AM, Ondrej Certik <ondrej@certik.cz> wrote:
> On Wed, Nov 26, 2008 at 1:14 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Tue, 25 Nov 2008, Ondrej Certik wrote:
>>
>>> I would like to export our whole git repository to patches, and then
>>> reconstruct it again from scratch. Following the man page of "git
>>> fast-export":
>>>
>>> [...]
>>>
>>> However, the repository is very different to the original one. It
>>> contains only 191 patches:
>>
>> Can you try again with a Git version that contains the commit
>> 2075ffb5(fast-export: use an unsorted string list for extra_refs)?
>
> I tried the next branch:
>
> $ git --version
> git version 1.6.0.4.1060.g9433b
>
> that contains the 2075ffb5 patch. I haven't observed any change ---
> the "git log" still only shows 191 commits (git log --all shows
> everything).

I deleted all tags and then fast-exported and imported, now all the
commits show in "git log", however, the patches are wrongly connected.
Basically, both repositories are identical (including hashes) up to
this commit:

d717177d4  (fixed downloads instructions in the README and a typo)

However, the original repo (sympy-full-history-20081023) contains 3
children at this commit:

Parent: fecac34251934e98a05631440d3ce151585f2391 (David added to credits)
Child:  03ccb60798d62f94ac9d2ec9472dc7333f67b420 (Allow to specify
line width in 2D plotting.)
Child:  203124d834488781db5429d941eeb60e396990c8 (credits improvements)
Child:  77146885f1b7aa49184f27c2297488c3d1201106 (Speed "import sympy"
up as in the last release.)

but the newly created repository only 2:

Parent: fecac34251934e98a05631440d3ce151585f2391 (David added to credits)
Child:  203124d834488781db5429d941eeb60e396990c8 (credits improvements)
Child:  77146885f1b7aa49184f27c2297488c3d1201106 (Speed "import sympy"
up as in the last release.)


And from that point on, the hashes mishmatch and sometimes the commits
are just wrongly connected (e.g. for example d2dc6b3's parent is
0adafe3, but 0adafe3 was committed half a year later after
d2dc6b3...), so it's a mess. Also the checkouted files are not
complete.


Now, if you look at the "patches" file, to which I saved the results
of "git fast-export", you can find that the commit d717177d4  (fixed
downloads instructions in the README and a typo) has the mark :6540,
and if you search for this mark in the patches file, you can only find
2 children:

commit refs/heads/master
mark :6542
author Ondrej Certik <ondrej@certik.cz> 1198803347 +0100
committer Ondrej Certik <ondrej@certik.cz> 1198803347 +0100
data 21
credits improvements
from :6540
M 100644 :6541 README


and:

commit refs/heads/master
mark :6551
author Ondrej Certik <ondrej@certik.cz> 1198951670 +0100
committer Ondrej Certik <ondrej@certik.cz> 1198951670 +0100
data 48
Speed "import sympy" up as in the last release.
from :6540
M 100644 :6550 sympy/printing/preview.py


however, the third child doesn't contain the "from :6540":

commit refs/heads/master
mark :24
author Ondrej Certik <ondrej@certik.cz> 1198798384 +0100
committer Ondrej Certik <ondrej@certik.cz> 1198798384 +0100
data 101
Allow to specify line width in 2D plotting.


So imho that's a bug in git fast-export. What do you think?

Ondrej
