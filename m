From: Kirill <kirillathome@gmail.com>
Subject: Re: [GITK PATCH 3/3] gitk: strip prefix from filenames in 
	subdirectories
Date: Tue, 23 Feb 2010 14:42:29 -0500
Message-ID: <f579dd581002231142v6a937ac0xdc9618f2a468989d@mail.gmail.com>
References: <f579dd581002200847o340a3eb9l50d0f1329d4e2c23@mail.gmail.com>
	 <alpine.DEB.1.00.1002201847290.20986@pacific.mpi-cbg.de>
	 <a5b261831002200948v3c01708dv3e42d08d42e3119@mail.gmail.com>
	 <alpine.DEB.1.00.1002201920350.20986@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.1002231748320.3980@intel-tinevez-2-302>
	 <alpine.DEB.1.00.1002231810020.3980@intel-tinevez-2-302>
	 <alpine.DEB.1.00.1002231811021.3980@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pat Thoyts <patthoyts@googlemail.com>,
	Paul Mackerras <paulus@samba.org>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 20:42:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk0eW-0003A2-7m
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 20:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710Ab0BWTme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 14:42:34 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:63537 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab0BWTmd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 14:42:33 -0500
Received: by ey-out-2122.google.com with SMTP id d26so23451eyd.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 11:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ZBSpctDni2M/NWOcKBAHunTEdPwoZXCfOEm3LneyRSo=;
        b=KgPbj4uacz6J5CQv9PfBlfq9Mbx99vDAOP9IOCF1OWHtmfq9vsUce7YCrP7mENtF8K
         g8A6re64P4LXM+YeJX4bHTKEUOJcwi4sbSnE/dSzr0kytb8eKvD9qb5h033enVCDtE9x
         eyIsFIFOmNm/xvo3WauJ5SuBnGsF1I+nLMVrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lxuPuJwXjZCbwgumkV1FFETyZvJrLXR74cmg4EgIndI2u9T0WnJzPMi4yVRaR6bwdz
         pevwCcN1/ckuuMh0ra+mub4CYUNyPlc+JwQVeI5ljw200nf44Q/SR7nLHCQ8Sp/TAk0r
         hMkpwvw3ZCiNAXgrIqzCNMi2KsV31ZDOvb1bU=
Received: by 10.216.161.148 with SMTP id w20mr2230337wek.117.1266954150222; 
	Tue, 23 Feb 2010 11:42:30 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002231811021.3980@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140826>

Hi,

On Tue, Feb 23, 2010 at 12:12 PM, Johannes Schindelin wrote:
>
> Again in the lower right panel, where the file names of the files touched
> by the current commit are clickable: let's not show the prefix when we
> are in a subdirectory, as it wastes precious screen estate conveying
> information the user already knows.
Unfortunately, it seems to be too aggressive, leading to a misleading
display. When gitk is invoked from a subdirectory but without the
filter, the lower right panel displays some paths, relative to the
root of the work tree, and some, relative to the wd:

$ # fresh netinstall with checked out devel's
$ cd /
$ gitk --all & # 1
$ cd /bin
$ gitk --all & # 2

1. bin/move-wiki.sh when devel is selected; share/WinGit/install.iss -
when installer-improvements is selected (that's correct)

2. move-wiki.sh on devel; share/WinGit/install.iss on installer-improvements
That's misleading.

And honestly, I'm not that advanced in gitk use, so somebody will
probably have to do some more testing.

Thanks!

--
Kirill.
