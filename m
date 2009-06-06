From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 2/3] pull --rebase: Add support for rebased default 
	upstream
Date: Sat, 6 Jun 2009 10:00:18 +0200
Message-ID: <adf1fd3d0906060100vc04032eh6315d336ef619402@mail.gmail.com>
References: <1244231617-17754-2-git-send-email-santi@agolina.net>
	 <alpine.DEB.1.00.0906060120140.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:01:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCqpn-000216-Hj
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbZFFIAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 04:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbZFFIAU
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:00:20 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:52923 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbZFFIAT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2009 04:00:19 -0400
Received: by bwz9 with SMTP id 9so1954485bwz.37
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:00:20 -0700 (PDT)
Received: by 10.204.72.129 with SMTP id m1mr4068846bkj.61.1244275219823; Sat, 
	06 Jun 2009 01:00:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0906060120140.26154@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120879>

2009/6/6 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Fri, 5 Jun 2009, Santi B=E9jar wrote:
>
>> Also add a test to check for this case and another one (failing) to
>> test rebasing two branches on top of a rebased upstream using just
>> 'git pull --rebase'.
>>
>> Signed-off-by: Santi B=E9jar <santi@agolina.net>
>
> Either I am a stupid moron (which is a completely valid suggestion) o=
r
> this commit message lacks in detail severely.
>
> For example, when I "git pull --rebase junio next" and "next" was reb=
ased,
> it works _perfectly_, so I do not see any need for a fix.

It is for the default upstream (with no arguments), so before this patc=
h:

git pull --rebase

did not work with a rebased upstream.

But you are right, the commit message can be improved a lot. I've
redone this patch series so much that at the end the commit message
lack details.
>
> Further, this:
>
>> ---
>> =A0git-parse-remote.sh | =A0 =A08 +++++++-
>> =A0t/t5520-pull.sh =A0 =A0 | =A0 29 +++++++++++++++++++++++++++++
>> =A02 files changed, 36 insertions(+), 1 deletions(-)
>
> ... suggests to me that pull --rebase is not even affected by your pa=
tch.

It modifies a function used in git pull --rebase.

> So maybe you want to clarify so much that even stupid morons understa=
nd
> what you want to achieve, and how.

OK, I'll try.

parse-remote: support default reflist in get_remote_merge_branch

Expand get_remote_merge_branch to compute the tracking branch to merge
when called without arguments (or only the remote name). This allows
"git pull --rebase" without arguments (default upstream branch) to
work with a rebased upstream.

Santi
