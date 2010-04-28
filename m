From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [patch 06/16] diff-test_cmp.patch
Date: Wed, 28 Apr 2010 12:43:02 -0500
Message-ID: <20100428174302.GD2041@progeny.tock>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <20100427135833.403548000@mlists.thewrittenword.com>
 <20100427171531.GA15553@progeny.tock>
 <20100428090045.GD36271@thor.il.thewrittenword.com>
 <20100428095159.GD1394@progeny.tock>
 <20100428102250.GB39644@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 19:43:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7BIG-0002II-QC
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 19:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242Ab0D1RnL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 13:43:11 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:48670 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab0D1RnK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 13:43:10 -0400
Received: by ewy20 with SMTP id 20so4918200ewy.1
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=upIWI5IYd7F8Z7NSmKWR+ms0jj6nk/FFRNHt+nCvOnM=;
        b=PZQ8NrzNkZgqlrmGqSlPxTAcd71XqT68m3FRAFgIKlYe+R3ki2PEg44VhfCWLz7rfI
         YyxX9g2zYh+JZLS9tGB/MW97oPn2Y29lQnSWICx31eRiRRsZpD5Gt3+e+sjHBBSLEGx+
         Wq48Mltcm6q4DyncKp7hrp9NehOaGz3p6kxYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QYctM8EvdznPVGmeFP/iJZkdKe7/CaXJkb7aYwfLXVA1ekWsvX18V1dU7DU16yGTGj
         ooRnFNY9/bTsrM66qBdC303dQVZZBlZzjnDNgXsDOe+5JkdQGo2P38h7lwhPnFDSwVKM
         FMY+KxJtPUCq+u38crEvm4/1PuA74siVgw9UY=
Received: by 10.103.7.28 with SMTP id k28mr4283323mui.25.1272476588260;
        Wed, 28 Apr 2010 10:43:08 -0700 (PDT)
Received: from progeny.tock (c-76-28-252-211.hsd1.wa.comcast.net [76.28.252.211])
        by mx.google.com with ESMTPS id b9sm141004mug.7.2010.04.28.10.43.05
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Apr 2010 10:43:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100428102250.GB39644@thor.il.thewrittenword.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146000>

Gary V. Vaughan wrote:
> On Wed, Apr 28, 2010 at 04:51:59AM -0500, Jonathan Nieder wrote:

>> The most general way:
[git init and git add . and git commit]
> D'oh.  Of course... I was too fixated on git clone to notice.
>
>> You can automate some of those steps by
>>=20
>>  wget http://address/of/tarball.tar.gz
>>  git init project
>>  cd project
>>  perl /usr/share/doc/git/contrib/fast-import/import-tars.perl tarbal=
l.tar.gz
>>  git checkout import-tars
>>  ... use git as usual
>
> What's happening here?  Is this sharing a single repository for all
> locally hosted git projects, or is this more or less the same as the
> above?

It=E2=80=99s the same as the above.  The only advantages I can think of=
 are that
it might be slightly faster (though I haven=E2=80=99t tested) and that =
this way
I don=E2=80=99t have to remember the tar --strip-components option.

You could share a single repository for all locally hosted git projects=
,
but that would kill the behavior of make.

>> If upstream uses git, there is also the shallow-clone facility:
>>=20
>>  git clone -b master --depth=3D1 git://repo.or.cz/git.git/
>>  cd git
>>  ... use git as usual, except history is cauterized
>
> This is probably the flavour that would be of the most use to us.
> Thanks for educating me :)
>
>> It has one rough edge you may run into: push is not supported.  If t=
hat
>> is a problem for you, let me know and maybe I can try to help fix it=
=2E
>
> No, I think the main benefit of using git locally would be to provide
> a pull source for upstream.

Oh, that=E2=80=99s another rough edge (the same one, fundamentally).  S=
orry.

Another benefit of using git to fetch from upstream is to get the lates=
t
version.

Hope that helps,
Jonathan
