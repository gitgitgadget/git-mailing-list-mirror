From: Camille Moncelier <moncelier@devlife.org>
Subject: Re: cherry-pick fail when a symbolic link has been changed into a
 file or directory
Date: Sun, 7 Nov 2010 10:42:09 +0100
Message-ID: <20101107104209.3e497c5b@cortex>
References: <20101104125641.2ef90853@cortex>
	<AANLkTimq8SP-gxZQiXW3Pxg3-1Z98zyPAoNA8JDn0=6A@mail.gmail.com>
	<20101104151637.076ac021@cortex>
	<AANLkTi=cydcB2yRpWbSH7qZGHdjXEPjNvfBCJny7JcwJ@mail.gmail.com>
	<20101104181537.5f866d42@cortex>
	<AANLkTimDWM69qvY5wdyzFu=g6htg12-K542PRR4bdDYq@mail.gmail.com>
	<AANLkTi=aGHvQhG3bOcqS-U04UjFeB7PVw9GTsSuf3UFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>,
	Nick <oinksocket@letterboxes.org>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 07 10:42:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF1lp-00018J-8a
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 10:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716Ab0KGJmW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Nov 2010 04:42:22 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44704 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab0KGJmV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Nov 2010 04:42:21 -0500
Received: by ewy7 with SMTP id 7so2401804ewy.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 01:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=8JmjhKtimYMgSp2EY7B8tgQLDeMsIeDyFP59d7ZBjxs=;
        b=gEHlJh/FW5kUzfLg5lJfpVUnZc0W6trgN2f9bSZgxpUnPwA9XEE8HYG33qZwa9b1n2
         jP5LUP9K6eqDRU0PcEceKkqCKNNV+nhrxTTyvhpTKa4+YZdu+grS4p9STw8UfxViG5XW
         uZkv+DoGkdHd7/7hhQqKt/HMNa5R7rNccJu/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=KyGsyfLGawj4kY6nJRRWpQULKMLlAFEtIPX3YfuQ8fBlpUwjByCPUBzyOy87K+R+Yx
         sJOqSwA+cgc6B5t1F4CmRuEIUWt32fmoby/WV+GxRV46NxhE2Cy3N/jrFzaW2Rif1Z/w
         SENwge2SuJGooTgFFwRHc2CS4x0c9YIWmFCl8=
Received: by 10.213.17.132 with SMTP id s4mr3145888eba.73.1289122939794;
        Sun, 07 Nov 2010 01:42:19 -0800 (PST)
Received: from cortex (mal35-3-82-240-201-90.fbx.proxad.net [82.240.201.90])
        by mx.google.com with ESMTPS id v51sm3001693eeh.22.2010.11.07.01.42.17
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 01:42:18 -0800 (PST)
In-Reply-To: <AANLkTi=aGHvQhG3bOcqS-U04UjFeB7PVw9GTsSuf3UFA@mail.gmail.com>
X-Mailer: Claws Mail 3.7.6cvs62 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160871>

> > The patch series I posted in late September post-dates the related
> > series of mine that were merged in 1.7.3.
> >
> > I'd also be happy to take a look and see if my newer merge-recursiv=
e
> > series fixes your case (or whether one of my other improvements to
> > that series since my September posting does). =C2=A0If not, I'll tr=
ack it
> > down and fix it and add that fix to the series.
>=20
It's strange I've just tested on my laptop and it seems fixed in
v1.7.3. I'll redo the test this week on the repository I've first
experienced the problem, just to see if the problem is really gone or=20
my testcase isn't sufficient.

I've tried to use git bisect to check the patch which fixed the problem
but, I didn't succeed.=20

BTW, Is there a way using git bisect to find the "last bad commit",
or maybe the "first good one" ?

> Great!
>=20
> Thanks both,
> Christian.
