From: Jason McMullan <jason.mcmullan@gmail.com>
Subject: Re: "failed to read delta base object at..."
Date: Tue, 26 Aug 2008 17:01:58 -0400
Message-ID: <48B46F46.9090302@gmail.com>
References: <20080825164602.GA2213@fieldses.org> <alpine.LFD.1.10.0808251153210.3363@nehalem.linux-foundation.org> <20080825213104.GI2213@fieldses.org> <alpine.LFD.1.10.0808251435540.3363@nehalem.linux-foundation.org> <20080825221321.GL2213@fieldses.org> <alpine.LFD.1.10.0808251616240.3363@nehalem.linux-foundation.org> <48B46B04.70102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bfields@fieldses.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 23:03:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY5h5-0000ZU-TP
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 23:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbYHZVCK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Aug 2008 17:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbYHZVCJ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 17:02:09 -0400
Received: from main.gmane.org ([80.91.229.2]:56020 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbYHZVCH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 17:02:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KY5fx-0006ub-W4
	for git@vger.kernel.org; Tue, 26 Aug 2008 21:02:06 +0000
Received: from 209.195.169.219 ([209.195.169.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 21:02:05 +0000
Received: from jason.mcmullan by 209.195.169.219 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 21:02:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 209.195.169.219
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <48B46B04.70102@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93820>

Jason McMullan wrote:
>=20
> Was this pack created on a journaled file system? Reiserfs? Ext3?
>=20
> If there's journal corruption in a commonly used filesystem,
> That Would Be Bad.

In private mail, it was indicated that this was an ext3 with the
data=3Dwriteback option. From mount(1), man page, ext3 section:

    writeback
       Data ordering is not preserved - data may be written into
       the main file system after its metadata has been  commit=E2=80=90
       ted  to the journal.  This is rumoured to be the highest-
       throughput option.  It guarantees  internal  file  system
       integrity,  however  it  can  allow old data to appear in
       files after a crash and journal recovery.

All bets are off when data=3Dwriteback.


- Jason McMullan
