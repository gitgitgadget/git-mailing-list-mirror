From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] gitk: refresh index before checking for local
 changes
Date: Tue, 6 Apr 2010 21:57:06 -0500
Message-ID: <20100407025706.GA6528@progeny.tock>
References: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com>
 <20100406233601.GA27533@progeny.tock>
 <n2kc6c947f61004061647ybb6c2f55zc70197362764ef8@mail.gmail.com>
 <20100407004353.GA11346@progeny.tock>
 <4BBBEC43.5000100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Avery Pennarun <apenwarr@gmail.com>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 04:57:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzLSK-0002SJ-Nf
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 04:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387Ab0DGC5X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 22:57:23 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:52065 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab0DGC5S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 22:57:18 -0400
Received: by yxe1 with SMTP id 1so125173yxe.33
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 19:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=s8p23ggJif3WjxHzmLu2DAUw2M++J4mdvDxKIPRMb60=;
        b=j2kYOv/fYpS7AJ/XZX34ySn+UPMjckXhobBIBxwlT+i8k+Rosm7ySzQXbK1LgLL63B
         knhQWKUeWhAi9+g792wiw/F4Bi8BAxsg/bV++VqsBPivBpzUi0gfDESjiFeG5RnqE7Wc
         vAr7LkgZiF4r0Aylp7I55p5PyxOwuMIWvxpDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=HpDJZvssGVDL179e5YFcuD5cral7XFngzX5mGsVgL27+SQVZF36SYVLk+vAGeEkPrS
         59dQeuFD5Un00/NbPZp1ybwO987hf6pPvyibhK8E3mbSyiag6c6Tszq04dav4FlC4mFM
         iZweMDYg2rGToFaMk78RaZeQhPnuNcN8YMDXk=
Received: by 10.101.213.12 with SMTP id p12mr1719675anq.246.1270609031289;
        Tue, 06 Apr 2010 19:57:11 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id co35sm680788ibb.14.2010.04.06.19.57.10
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 19:57:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BBBEC43.5000100@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144189>

A Large Angry SCM wrote:

[context: should gitk run =E2=80=98gitk update-index --refresh -q=E2=80=
=99 transparently?]

> NAK - gitk should not modify a repository and/or working dir unless
> _explicitly_ prompted to by the user.
>
> If you want a new _non-default_ option setting for gitk, that fine al=
so.

I have some sympathy for this point of view.

Does the same principle apply to =E2=80=98git diff=E2=80=99?  If not, w=
hy not?

It should be possible to suppress files with no changes from the
display without refreshing the index (or not to suppress them and to
still refresh the index, nor that matter; the issues are orthogonal),
but it would be nice to come up with a clear rationale first.

Jonathan
