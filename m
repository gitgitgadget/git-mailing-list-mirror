From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: symbolic link management in git-archive
Date: Tue, 01 Apr 2008 00:12:09 +0200
Message-ID: <47F161B9.1030408@gmail.com>
References: <loom.20080327T112740-539@post.gmane.org> <7v3aqcb02s.fsf@gitster.siamese.dyndns.org> <loom.20080327T175844-199@post.gmane.org> <47F14D4A.2020403@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Apr 01 00:13:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgSFO-0006tI-3b
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 00:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbYCaWMP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Mar 2008 18:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbYCaWMO
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 18:12:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:11734 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbYCaWMN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2008 18:12:13 -0400
Received: by nf-out-0910.google.com with SMTP id g13so729643nfb.21
        for <git@vger.kernel.org>; Mon, 31 Mar 2008 15:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=Sc3BiPXU4uWt8eZ6GmWrium5syb0GyHkawTeq3gS6lo=;
        b=lc1SO3SS3rrWs0jTrUp89fWRhDG0hNYEmdVaLV79O1OlDrY2F4kz258VeESnVw65w6wAaU54nAd2ky5edpkhr04+NcCD9o/hjzN+i6z79OLljjF83xTUKcWgF6CbDvlBkrxdNqGf/YJ+vAVCcxOrZk9eEAlhELWoGnnnF/ZzTz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ghh35tMktStq/IB98xdAbgEWrJqcTCR/WIFpePbIGEGtpy4G2Ujzq16PU4Z+vgnmb5z9wHyVVGeviR84+P1kBeel6V1v+D/9+r+ftcVetwIeAYNtL90BqNJ64/oZPxRIJeXSD6fMyyNKeIQ6IMUbPdOC0Ben+lkeevVGobEzkp4=
Received: by 10.78.184.2 with SMTP id h2mr23959087huf.14.1207001531773;
        Mon, 31 Mar 2008 15:12:11 -0700 (PDT)
Received: from ?192.168.1.12? ( [87.6.50.227])
        by mx.google.com with ESMTPS id i5sm4707269mue.7.2008.03.31.15.12.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 31 Mar 2008 15:12:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <47F14D4A.2020403@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78608>

Ren=E9 Scharfe wrote:

> Windows 2000 and up has support for symbolic links; it's just strange=
ly
> restricted, [...] here's a good starting point for
> more information: http://en.wikipedia.org/wiki/NTFS_junction_point
>
> Arguably, your unzip program should create junction points for symlin=
ks
> in zip files.  I wouldn't be surprised if none of the existing ones
> support that, though;
>
> Would it be practical for you to distribute a junction point creation
> tool like Mark Russinovich's Junction (except that Junction's EULA
> forbids redistribution under most circumstances; see here:
> http://www.microsoft.com/technet/sysinternals/FileAndDisk/Junction.ms=
px)
> and a script that creates these symlinks for your audience?
>  =20
Thank you very much for the detailed explanation. Unfortunately, I do=20
not think that Junction can be an option.  My colleagues using Windows=20
tend to be a bit "conservative" about the tools they use.  If they=20
navigate filesystem contents with the graphical tool, and they=20
look-at/expand the content of a zip file from explorer they expect that=
=20
it should be immediately right, otherwise there must be something wrong=
=20
in the way /I/ create zip files.  They would not appreciate having to=20
unzip the file and then run an additional program on it to fix the=20
unzipped stuff.
> It's harder for git-archive to support following symlinks than for e.=
g.
> GNU tar.  The reason is that the former operates on git objects, not
> files, directories or symlinks.  In order to follow a symlink it woul=
d
> need to evaluate the symlink, follow it and then add actual files and
> directories to the archive.
>
> For your purposes, perhaps a slightly different implementation might =
be
> sufficient: namely to follow only relative symlinks that point to
> tracked objects.  That way you still get a repeatable result and (mos=
t
> importantly) git-archive doesn't need to look at files and directorie=
s,
> it can stay safely in git land.  Would such a way of operation be use=
ful
> to you?
>  =20
Absolutely positive.  This would be already a great improvement,=20
fulfilling 99.9% of needs.

Sergio
