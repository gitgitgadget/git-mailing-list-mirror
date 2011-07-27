From: Reuben Thomas <rrt@sc3d.org>
Subject: Re: [RFC/PATCH] commit: allow partial commits with relative paths
Date: Wed, 27 Jul 2011 10:45:28 +0100
Message-ID: <CAOnWdojgxZNs4qyEG55URScqOGb6k5e6Mh_B3By6Lj6SpN9L9g@mail.gmail.com>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
	<19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net>
	<7v8vrmrxok.fsf@alter.siamese.dyndns.org>
	<4E2FCAC4.7020408@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 27 11:45:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm0gM-0004KD-C9
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 11:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab1G0Jpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 05:45:32 -0400
Received: from exprod7og103.obsmtp.com ([64.18.2.159]:45701 "HELO
	exprod7og103.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753926Ab1G0Jpa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 05:45:30 -0400
Received: from mail-yx0-f178.google.com ([209.85.213.178]) (using TLSv1) by exprod7ob103.postini.com ([64.18.6.12]) with SMTP
	ID DSNKTi/eOcILVfwC2GQGH3GT5ejvDD34yeta@postini.com; Wed, 27 Jul 2011 02:45:30 PDT
Received: by yxm8 with SMTP id 8so687724yxm.37
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 02:45:29 -0700 (PDT)
Received: by 10.143.32.11 with SMTP id k11mr4274918wfj.17.1311759928868; Wed,
 27 Jul 2011 02:45:28 -0700 (PDT)
Received: by 10.142.164.13 with HTTP; Wed, 27 Jul 2011 02:45:28 -0700 (PDT)
In-Reply-To: <4E2FCAC4.7020408@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177954>

On 27 July 2011 09:22, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Junio C Hamano venit, vidit, dixit 25.07.2011 21:02:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>> Also what is the "same
>> problem"?
>
> The one reported by the OP for commit:
>
> git rm ../a
> git commit -m "blurb" ../a
> error: pathspec '../a' did not match any file(s) known to git.

Actually, this is not what I reported. This explains why I couldn't
quite understand the direction this thread took. Look again:

$ cat ~/reportbug-git
$ git rm -f ../INSTALL
rm 'INSTALL'
$ git ci -m "INSTALL is now provided by gnulib." ../INSTALL
error: pathspec 'ALL' did not match any file(s) known to git.
$ cd ..
$ git ci -m "INSTALL is now provided by gnulib." INSTALL
[master 0895314] INSTALL is now provided by gnulib.
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 120000 INSTALL

The thing I didn't understand is that I tried to check in ../INSTALL,
but git complained about pathspec 'ALL'.

-- 
http://rrt.sc3d.org
