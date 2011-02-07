From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Mon, 07 Feb 2011 15:26:04 +0900
Message-ID: <buo8vxsfjib.fsf@dhlpc061.dev.necel.com>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
	<7vsjw0v11p.fsf@alter.siamese.dyndns.org>
	<AANLkTimG6s5vSCnisJCt-EXkcJGXfY4Y3WtdB_netU08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sebastian Pipping <webmaster@hartwork.org>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Matthieu@a-pb-sasl-sd.pobox.com, Matthieu.Moy@gr.pobox.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 07:26:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmKYa-0003qT-2u
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 07:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225Ab1BGG0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 01:26:33 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:35927 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059Ab1BGG0c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 01:26:32 -0500
Received: from mailgate3.nec.co.jp ([10.7.69.192])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id p176Q6qj015143;
	Mon, 7 Feb 2011 15:26:06 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id p176Q6u07072; Mon, 7 Feb 2011 15:26:06 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.46])
	by vgate01.nec.co.jp (8.14.4/8.14.4) with ESMTP id p176P6iN003913;
	Mon, 7 Feb 2011 15:26:05 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay11.aps.necel.com with ESMTP; Mon, 7 Feb 2011 15:26:05 +0900
Received: from dhlpc061 ([10.114.98.26] [10.114.98.26]) by relay11.aps.necel.com with ESMTP; Mon, 7 Feb 2011 15:26:05 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 282A252E1D4; Mon,  7 Feb 2011 15:26:05 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <AANLkTimG6s5vSCnisJCt-EXkcJGXfY4Y3WtdB_netU08@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Mon, 7 Feb 2011 13:14:36 +0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166235>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> git log -p and diff family all can take pathspecs. All default to
> tree-wide without pathspecs. This is what I'm doing all the time:
>
> git diff
> # checking, ok, looks good
> git add -u
> # ack, need to come to root dir first

Not to mention "git status", which shows everything in the tree when
given no args, but will only show changes underneath the cwd if given
"." as an argument.

I agree that the "default to root of git dir when given no args"
behavior seems both more convenient -- it's annoying to specify the root
of the tree explicitly, but very easy to specify the cwd explicitly
(".") -- and more intuitive -- If I want "everything underneath cwd",
I'll naturually specify "." as an argument; if I give no args, I almost
certainly want the whole tree, no matter where I happen to be in it.

-Miles

-- 
Christian, n. One who follows the teachings of Christ so long as they are not
inconsistent with a life of sin.
