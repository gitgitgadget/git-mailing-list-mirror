From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Question about "git pull --rebase"
Date: Mon, 16 Nov 2009 13:17:51 +0100
Message-ID: <38b2ab8a0911160417w6b9cc943h5e87d4e22d0dea2b@mail.gmail.com>
References: <38b2ab8a0911141239w2bab7277o66350bc742d985dd@mail.gmail.com>
	 <4AFF3D4D.7000308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "Johan 't Hart" <johanthart@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 13:20:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA0Yv-0003Pb-Dt
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 13:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbZKPMRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 07:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbZKPMRs
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 07:17:48 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:54482 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbZKPMRr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 07:17:47 -0500
Received: by fxm21 with SMTP id 21so2607911fxm.21
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 04:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=TRya0f246YwD9i2ZCcECWeI9gsLMimMyJmLf3+3B0ck=;
        b=wXtci8KJ1nIiqNjiXS7qsvUBwhQ/OfzydHx8AL5RjwSdLy5g75VVkq0Dp5w46h3Y0l
         F77XxGKoA5vYJrfG9oYyJT6TmYEEZDPZrAJRjK/fBRQtrvhAqcRgTPYjoP2ir3PLb7BC
         iLV6XAbCzQ+sKUMlhpPaA5WKmZOmytfLpyNfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IJF5N3okRpu+stIaqiMZ5hz1RgwMt0fF6/TBzhLZB1ShozNmDgZ4mlYXoroj7fIR13
         ZtyNvxB17SxAmHWPvPD5TczYN1E9g5cVipvu+DNyIZ9m4XcncQUp6cIe72siXgFv519S
         b/qbQRrnfvGKALwN+EwSBoZRcyenY7qXY+SWw=
Received: by 10.239.168.230 with SMTP id l38mr794551hbe.37.1258373872207; Mon, 
	16 Nov 2009 04:17:52 -0800 (PST)
In-Reply-To: <4AFF3D4D.7000308@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133005>

On Sun, Nov 15, 2009 at 12:29 AM, Johan 't Hart <johanthart@gmail.com> wrote:
> This does not update any remote tracking branches, but it will rebase your
> foo branch on the remote master branch (which is what you want)
> It could also be done with:
>
> git pull --rebase origin master:origin/master
>
> This will also update your remote tracking branch refs/remotes/origin/master
> to match the master branch on the remote repo. Your foo branch will then be
> rebased onto it.

BTW, this seems to be not exact.

$ git pull --rebase origin master:origin/master

fetches the 'master' branch on the remote repo, then creates a new
branch 'origin/master', which is updated with the fetched branch.

To update the remote tracking branch refs/remotes/origin/master, I
need to issue:

$ git pull --rebase origin master:remotes/origin/master

BTW2,  it looks like if the <dst> local ref doesn't exist the it will
be created. This something that appears very lately in the man page
(actually I can see the information only in the last example). This
could be part of the <refspec> defintion.

Thanks
-- 
Francis
