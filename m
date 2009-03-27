From: Anton Gyllenberg <anton@iki.fi>
Subject: Re: svn clone Checksum mismatch question
Date: Fri, 27 Mar 2009 13:18:07 +0200
Message-ID: <83dfc36c0903270418q59a81290xcb8043b8c037be18@mail.gmail.com>
References: <22719363.post@talk.nabble.com>
	 <20090326130213.GC3114@atjola.homenet>
	 <83dfc36c0903260735q3231ce96h5949d1123858995f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 12:19:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnA6B-0002tG-Dc
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 12:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812AbZC0LSN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 07:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753621AbZC0LSM
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 07:18:12 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:43590 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbZC0LSL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 07:18:11 -0400
Received: by ewy9 with SMTP id 9so1000096ewy.37
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 04:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=E7VyllOuoQgqlpr91E+bkCf/fIq5mWwAY++jkcbdV20=;
        b=QIXGv/lMkVvf3Yh0v9uPhd4tUUN8QLGaIJFCDV7/rY3nk/dJIX6O+z+rWPviCzpNa3
         htT5wwoUvN6ue3VJnu2UpJR4AFw9fB0is22RcAxEJjaXkrdSSVbPtulFbVgICIQnU6zT
         SFT51UyYYYlr9H5YngmNVyk10duoGJyBsoF/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=BjyHzGOARAuVIgITYZgYKmZWQQobFjJ2Wq1y+2Tzt0A1XerRHFb3HI95MdVx0mETJE
         G3r8+E5d+7lBNaJyWNnXzsUin3vBjNFRQhDGif5a4f+RGbPXRqXl3d4/tcIDDutv0OM+
         Md6b3efI0EJt2mM+ufaRLtER6ksMOcwcM1P20=
Received: by 10.210.144.3 with SMTP id r3mr1546519ebd.31.1238152687888; Fri, 
	27 Mar 2009 04:18:07 -0700 (PDT)
In-Reply-To: <83dfc36c0903260735q3231ce96h5949d1123858995f@mail.gmail.com>
X-Google-Sender-Auth: 253acbf8c14aec7a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114880>

I hope I didn't hijack the thread with an unrelated issue.

2009/3/26 Anton Gyllenberg <anton@iki.fi>:
> I don't know if this is the same issue, but the I get a similar error
> on the public twisted-python repository on both windows and linux,
> with several different versions and plenty of free disk space. As thi=
s
> is a publicly accessible repository it should be easy to reproduce:
>
> git svn init -s svn://svn.twistedmatrix.com/svn/Twisted twisted
> cd twisted
> git svn fetch -r 13611:HEAD
>
> This ultimately dies with the following error:
> W: +empty_dir: trunk/doc/core/howto/listings/finger/finger
> r13612 =3D f6d995ac255e3dfa08a517a6e72fbcfe63feaaa0 (trunk)
> Checksum mismatch:
> branches/foom/--omg-optimized/twisted/internet/cdefer/cdefer.pyx
> 264b0c5f7b3a00d401d1a5dcce67a3734f0eede3
> expected: c7ccddd195f132926e20bab573da7ef3
> =A0 =A0 got: f006323ff4714ca52c0228ce6390d415

Looking into this, the mentioned blob
264b0c5f7b3a00d401d1a5dcce67a3734f0eede3 with md5sum
f006323ff4714ca52c0228ce6390d415 is not at path
branches/foom/--omg-optimized/twisted/internet/cdefer/cdefer.pyx. The
contents of the blob is the seemingly totally unrelated LICENSE file
that is found at trunk/LICENSE and
branches/foom/--omg-optimized/LICENSE. cdefer.pyx does have the md5sum
c7ccddd195f132926e20bab573da7ef3.  Note that the branch root directory
is branches/foom/--omg-optimized (like with the branch name being
foom/--omg-optimized), not just branches/foom. Is think git-svn relies
on the standard layout being branches directly under the branches/
directory, but I don't see how this would get the paths mixed up like
this.

Looking at what was done around this commit one finds odd stuff, like
deleting directories in trunk and then copying from a previous
revision of trunk to under the branch:
http://twistedmatrix.com/trac/changeset/13611

I created a local test svn repository and tried to do something
similar but git-svn had no problem with my test.

This is issue is not critical for me in any way but if somebody wants
to look into it I am happy to help out.

Anton
