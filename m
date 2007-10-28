From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test case for running from a subdirectory with GIT_WORK_TREE
Date: Sat, 27 Oct 2007 17:18:59 -0700
Message-ID: <7vodek147g.fsf@gitster.siamese.dyndns.org>
References: <20071027081954.GA23406@laptop>
	<Pine.LNX.4.64.0710271343270.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 02:19:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlvsB-0003Yw-PS
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 02:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbXJ1ATJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Oct 2007 20:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbXJ1ATI
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 20:19:08 -0400
Received: from rune.pobox.com ([208.210.124.79]:42571 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbXJ1ATH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Oct 2007 20:19:07 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 6C06214F1BA;
	Sat, 27 Oct 2007 20:19:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C4EE914F1B8;
	Sat, 27 Oct 2007 20:19:23 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0710271343270.4362@racer.site> (Johannes
	Schindelin's message of "Sat, 27 Oct 2007 13:45:23 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62517>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 27 Oct 2007, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> +mkdir -p work/sub/dir || exit 1
>> +mv .git work
>> +if test "$1" =3D --normal; then
>> +	say "Normal case"
>> +else
>> +	say "Worktree case"
>> +fi
>> +test "$1" =3D --normal || mv work/.git repo.git || exit 1
>> +
>> +test "$1" =3D --normal || export GIT_DIR=3D$(pwd)/repo.git
>> +export GIT_CONFIG=3D"$(pwd)"/$GIT_DIR/config
>> +test "$1" =3D --normal || export GIT_WORK_TREE=3D$(pwd)/work
>> +
>> +cd work/sub || exit 1
> ...
> Hmm?  I would like to see this test case in the official git.git.

Me too ;-)  It would help people fix the issues.
