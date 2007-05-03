From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: FFmpeg considering GIT
Date: Thu, 3 May 2007 13:48:03 +1200
Message-ID: <46a038f90705021848w3d3b8f6pdbd100e8419f1b74@mail.gmail.com>
References: <loom.20070502T111026-882@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Panagiotis Issaris" <takis.issaris@uhasselt.be>
X-From: git-owner@vger.kernel.org Thu May 03 03:48:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjQQp-0000XI-09
	for gcvg-git@gmane.org; Thu, 03 May 2007 03:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945901AbXECBsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 21:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945996AbXECBsG
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 21:48:06 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:48712 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945901AbXECBsE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 21:48:04 -0400
Received: by wx-out-0506.google.com with SMTP id h31so306111wxd
        for <git@vger.kernel.org>; Wed, 02 May 2007 18:48:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a//QalX3p1rCOaylBLt6i+u9SAlL5jQkDI5M26NSn5ZUBkg/7S+Z1+SkiToUmxFny6udNtm1vTraRjBhtpxPjsTJymJS3MRzzPW5vg7g/53LOcOc5wGHqiDX1Q52YAKeTVkz75eBNLSr3fuPyMkIn33s/UmZrt0cuRTnpjmf5Xg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s3rkxYr9Ijv2S7XM8ju6IOERtnyknsg5j6wV+j44epm9/udWVJO/OuG4eUcvVauPhJoOEbpyZYOnd4//wHH0m3llDqJGbnLXqe7THWGSiJ6zar60XorxP10M8zdhVW932V53Znq3ITwoG2YalKkIrmkSwo2e7NIgNqgeRcy/YwA=
Received: by 10.90.83.14 with SMTP id g14mr1335689agb.1178156883955;
        Wed, 02 May 2007 18:48:03 -0700 (PDT)
Received: by 10.90.75.15 with HTTP; Wed, 2 May 2007 18:48:03 -0700 (PDT)
In-Reply-To: <loom.20070502T111026-882@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46056>

On 5/2/07, Panagiotis Issaris <takis.issaris@uhasselt.be> wrote:
> The questions are stated in this e-mail [1]. One of the things that are being
> discussed is the following action on a publicly mirrored repository:
> git branch -m master dead_end
> git branch -m last_good master
>
> I'd think this would fail as people could have pulled from the repository while
> the "dead_end" commit was already available, right?

Yes - that's something you shouldn't do on a normal branch... but
that's a feature ;-) -- we call it re-winding a branch.

A good workaround if you expect to go down some dead_ends is to have
an experimental branch that you pre-announce that will be rewound
regularly. On the git repo, Junio does exactly that with "pu"
("proposed updates"), and several  feature-development branches have
been dropped or rewound at times.

Now, for your main dev and various maintenance branches, just do a
revert. If something made it into the main dev branch it means it's
not so experimental anymore and all the developers are building
further development on top. At that stage, the potential mistake has
made it "quite far" so you can't rewind it and pretend it didn't exist
;-)

So the good practice is to never rewind the long-term branches people
base their work on. Branches in your repo, and public branches clearly
marked as experimental, anything goes.

cheers,


martin
