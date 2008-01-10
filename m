From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: Revert git push
Date: Thu, 10 Jan 2008 13:31:59 +0000
Message-ID: <57518fd10801100531v6f6aef85k4b1b875c6f16aeba@mail.gmail.com>
References: <6zve61q0t3.fsf@odpc25.int.ondemand.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Markus Korber" <korbse@gmx.at>
X-From: git-owner@vger.kernel.org Thu Jan 10 14:32:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCxWL-0004hi-7A
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 14:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbYAJNcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 08:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbYAJNcD
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 08:32:03 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:15637 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbYAJNcA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 08:32:00 -0500
Received: by nz-out-0506.google.com with SMTP id s18so360700nze.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 05:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=Z0Z6YN4lM/zTemkYKLFF+JWDCzAGVFlO2LHQktXMtFI=;
        b=rhAIawghkOmDD4qqevDfbNoiEsbcUxt0YsnjKdhJ9mYLrPmoti1v3t+x08+kUvo/tjwEVvdlPhEXcyY8jdGcGutLgb37vF8ky0R3hmjPNo44lubeQkeGMJRh1aqdgymkw/bGw5ZuozlEkEIjONiJzlvsmp565+GTO/Bf0JyZ2QA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=OPj/zYQRzVuRciroS4VC+ezKqerncVDgrxVv6G9A84XJs0h/lE6K1XPtzvS6RzjIa5yBBjo71b0ormLRCCThFC2zRcZPV439xE4ClD82ovfe8Sh+XOoZxZyZsSfmrPLEgRLe1XdDJkaAMz2Kh3C47LJRrngA+8LyZ7ErneGxeKk=
Received: by 10.141.2.19 with SMTP id e19mr1179750rvi.221.1199971919409;
        Thu, 10 Jan 2008 05:31:59 -0800 (PST)
Received: by 10.140.134.14 with HTTP; Thu, 10 Jan 2008 05:31:59 -0800 (PST)
In-Reply-To: <6zve61q0t3.fsf@odpc25.int.ondemand.co.at>
Content-Disposition: inline
X-Google-Sender-Auth: 18b751bc64f1db76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70071>

On Jan 10, 2008 1:15 PM, Markus Korber <korbse@gmx.at> wrote:
> Hi,
>
> I've got two local git repositories, linux and mplayer, where I push to
> from a local directory.  Now I accidentally pushed from mplayer into the
> linux repository (via a not updated URL[1]).  Is it somehow possible to
> revert this push if nobody has pushed something since my last pull from
> the linux repository?
>
> (Or can I just copy the .git/objects/ directory over to the repository?)
>
> ,----[ .git/remotes/mplayer [1]]
> | URL: /prj/gitroot/linux
> | Push: +master:master
> `----
>
> ,----[ git push mplayer ]
> | updating 'refs/heads/master'
> |   from 94545baded0bfbabdc30a3a4cb48b3db479dd6ef
> |   to   9085d919f7954ad629447157f054e55230513936
> | Generating pack...
> | Done counting 3240 objects.
> | Deltifying 3240 objects...
> |  100% (3240/3240) done
> | Writing 3240 objects...
> |  100% (3240/3240) done
> | Total 3240 (delta 774), reused 0 (delta 0)
> | refs/heads/master: 94545baded0bfbabdc30a3a4cb48b3db479dd6ef -> 9085d919f7954ad629447157f054e55230513936
> `----


You can push again to revert your original push, just specifying a
different ref to push.  Something like this ought to work :

git push -f mplayer 94545bade:master

which will update the remote 'master' branch with commit 94545bade,
which is what it was before your accidental push

Jon
