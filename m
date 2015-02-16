From: Armin Ronacher <armin.ronacher@active-4.com>
Subject: Re: Experience with Recovering From User Error (And suggestions for
 improvements)
Date: Mon, 16 Feb 2015 14:29:19 +0100
Message-ID: <54E1F0AF.1070403@active-4.com>
References: <54E1C96D.2080109@active-4.com> <CACBZZX4NkkMymnG5ZWtO1ya2xzVhxuqh4d3tU2U+mPU49n=m8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 14:29:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNLjr-0005Op-ML
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 14:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbbBPN3X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2015 08:29:23 -0500
Received: from mail.architekten-ronacher.at ([178.188.250.58]:46524 "EHLO
	[192.168.6.11]" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754621AbbBPN3X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 08:29:23 -0500
Received: from localhost (localhost.localhost [127.0.0.1])
	by GateDefender.ronacher (Postfix) with ESMTP id 27DBFEDC003;
	Mon, 16 Feb 2015 14:29:21 +0100 (CET)
X-Virus-Scanned: by Panda GateDefender
X-Spam-CTCH-RefID: str=0001.0A090204.54E1F0B1.0019,ss=1,fgs=0
Received: from herzog.local (unknown [192.168.6.133])
	by GateDefender.ronacher (Postfix) with ESMTPS id 5642BEDC002;
	Mon, 16 Feb 2015 14:29:20 +0100 (CET)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CACBZZX4NkkMymnG5ZWtO1ya2xzVhxuqh4d3tU2U+mPU49n=m8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263899>

Hi,

On 16/02/15 13:09, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> We should definitely make recovery like this harder, but is there a
> reason for why you don't use "git reset --keep" instead of --hard?
This was only the second time in years of git usage that the reset was=20
incorrectly done.  I suppose at this point I might try to retrain my=20
muscle memory to type something else :)

> If we created such hooks for "git reset --hard" we'd just need to
> expose some other thing as that low-level operation (and break script=
s
> that already rely on it doing the minimal "yes I want to change the
> tree no matter what" thing), and then we'd just be back to square one
> in a few years when users started using "git reset --really-hard" (or
> whatever the flag would be).
I don't think that's necessary, I don't think it would make the=20
operation much slower to just make a dangling commit and write out a fe=
w=20
blobs.  The garbage collect will soon enough take care of that data=20
anyways.  But I guess that would need testing on large trees to see how=
=20
bad that goes.

I might look into the git undo thing that was mentioned.


Regards,
Armin
