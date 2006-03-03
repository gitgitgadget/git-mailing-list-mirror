From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Fri, 03 Mar 2006 21:57:48 +0000
Message-ID: <4408BBDC.10802@gmail.com>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk> <44037A5C.6080409@gmail.com> <b0943d9e0602281445w7160d915y@mail.gmail.com> <4405DC41.8020700@citi.umich.edu> <b0943d9e0603010953iccf64a4v@mail.gmail.com> <20060303141329.GA16456@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Mar 03 23:00:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFIJx-0001xX-5I
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 23:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbWCCWAR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 3 Mar 2006 17:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbWCCWAR
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 17:00:17 -0500
Received: from main.gmane.org ([80.91.229.2]:58595 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751718AbWCCWAO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 17:00:14 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FFIJo-0001w3-Rh
	for git@vger.kernel.org; Fri, 03 Mar 2006 23:00:12 +0100
Received: from cpc3-cmbg5-3-1-cust141.cmbg.cable.ntl.com ([86.15.186.141])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Mar 2006 23:00:12 +0100
Received: from catalin.marinas by cpc3-cmbg5-3-1-cust141.cmbg.cable.ntl.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Mar 2006 23:00:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpc3-cmbg5-3-1-cust141.cmbg.cable.ntl.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
In-Reply-To: <20060303141329.GA16456@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17159>

Karl Hasselstr=F6m wrote:
> We could perhaps do a little better. Instead of just noting whether
> the patch vanishes when reverse-applied, save the top and bottom of
> the patch as reverse-applied, and then replace the patch with the
> reverse of that. If the patch vanishes, this does what your patch doe=
s
> right now. If the patch does not vanish, all that remains is the part=
s
> that upstream didn't accept. (And as before, if the patch didn't
> reverse-apply cleanly, assume upstream hasn't accepted it at all yet.=
)

I don't fully understand this. If a patch reverse-applies cleanly, it
means that it was fully merged upstream. If it wasn't fully merged,
direct applying would fail and we should fall back to a three-way merge=
=2E
I'm not sure whether the latter would cause conflicts or not. The
disadvantage would be more time spent with trying two types of merges.

Anyway, I'll push the current patch but remain open to improvements. If
you get something working with your idea, please post a patch.

Catalin
