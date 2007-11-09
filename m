From: "Yossi Leybovich" <sleybo@gmail.com>
Subject: Re: corrupt object on git-gc
Date: Fri, 9 Nov 2007 11:31:51 -0500
Message-ID: <4fe79b4b0711090831o30d2880dh3d9ec0bb0503f77a@mail.gmail.com>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com>
	 <473464A2.7080003@op5.se>
	 <4fe79b4b0711090701g7a43cdfdi5e20e5ffb437d7bb@mail.gmail.com>
	 <47347E0E.1040205@viscovery.net>
	 <4fe79b4b0711090753r52abd3e1ree64271c0fa229f6@mail.gmail.com>
	 <alpine.LFD.0.9999.0711091102370.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org,
	"Yossi Leybovich" <sleybo@mellanox.co.il>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:32:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqWm9-0008Kb-I1
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 17:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347AbXKIQby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 11:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753322AbXKIQby
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 11:31:54 -0500
Received: from el-out-1112.google.com ([209.85.162.178]:64443 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbXKIQbx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 11:31:53 -0500
Received: by el-out-1112.google.com with SMTP id j27so206553elf
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 08:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0AZQxQsy7FCr/8/l1mmyP39YmbXk3LccpPt+SFb5agw=;
        b=j6/v5wxfsj+b+yjW+CYpVCpZQuuDyq0nH7LoAFq3qM/zMTxYgwTDBa1qae0vcG7TBkZPQFKaK+CoJcwluTVkWbLvpaKlBsnBcMLVuIofHZ0EtJKzxeavB0i/7z48FanN1vYnmzzY0kGOuwEmaRbW5jpWdMdqQoYK+M152eBNSwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TmgETdZhMZFZb5edifL+8mAA2MS3w6/4XrITOpDm3xW95PAfT+uZScRgckQ5mgYakr8VAVHYx8PVuxXMKQD0AwTAz6hbrCLvEIPm+t7vSXVdaJax2uvpK5cDGE0g6Xwj3gOmnbFwLLF1I4XCSO129fXyCX9QUIwr5NOl927teLs=
Received: by 10.142.226.2 with SMTP id y2mr753858wfg.1194625912023;
        Fri, 09 Nov 2007 08:31:52 -0800 (PST)
Received: by 10.142.217.12 with HTTP; Fri, 9 Nov 2007 08:31:51 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0711091102370.21255@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64214>

On Nov 9, 2007 11:03 AM, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 9 Nov 2007, Yossi Leybovich wrote:
>
> > On Nov 9, 2007 10:34 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> > > Yossi Leybovich schrieb:
> > > > [about corrupt loose object '4b9458b3786228369c63936db65827de3cc06200']
> > >
> > > You can try to create a clone (after you have fixed up the artificial
> > > breakages that you made). If that goes well, then the bad object is
> > > referenced only from reflogs.
> > >
> >
> >
> > git clone ib ib-clone
> > Initialized empty Git repository in /home/mellanox/work/symm/ib-clone/.git/
> > 0 blocks
>
> Please try "file://ib" instead.  Otherwise the clone will only hardlink
> files to the original repository.
>
>

And agian the corruption pop up again , so clone does not help


[mellanox@mellanox-compile ib]$ git clone file://ib ib-clone
Initialized empty Git repository in /home/mellanox/work/symm/ib-clone/.git/
remote: Generating pack...
remote: Counting objects: 276
Done counting 3288 objects.
remote: Deltifying 3288 objects...
remote: error: remote: corrupt loose object
'4b9458b3786228369c63936db65827de3cc06200'remote:
remote: fatal: remote: object 4b9458b3786228369c63936db65827de3cc06200
cannot be readremote:
error: git-upload-pack: git-pack-objects died with error.
remote: aborting due to possible repository corruption on the remote side.
fatal: early EOF
fatal: index-pack died with error code 128
fetch-pack from 'file://ib' failed.
fatal: git-upload-pack: aborting due to possible repository corruption
on the remote side.


> Nicolas
>
