From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] commit: configure submodules
Date: Mon, 24 Sep 2012 20:15:09 +0200
Message-ID: <5060A32D.1060902@web.de>
References: <1348385867-17359-1-git-send-email-orgads@gmail.com> <7vr4pt16ep.fsf@alter.siamese.dyndns.org> <505F5151.2080208@web.de> <7vmx0g0xpm.fsf@alter.siamese.dyndns.org> <7v39271j3n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Orgad Shaneh <orgads@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 20:15:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGDBo-0007fG-Bx
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 20:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757330Ab2IXSPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 14:15:18 -0400
Received: from mout.web.de ([212.227.15.3]:50178 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174Ab2IXSPS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 14:15:18 -0400
Received: from [192.168.178.41] ([91.3.184.50]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MZUnl-1T2Ghl0EGr-00KwPf; Mon, 24 Sep 2012 20:15:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7v39271j3n.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:/tT33m5y1NQUxjPDGM1s0517xI7KxTku3KQHkY52RtZ
 1MB3K8h8Qu5ZUjd6QjpXa5xKrU7ei5ymCiLuNgjR3OwbnUyNJo
 yBW3VpbNhxGDIFhcGIDcYBZ55SreQp7FQyyYT0Twxyn1Qp6mCi
 R7zDfe/9sT/atNPhtDaACcqwPGSMiiBztRnYwy/pvb2hRwuU0K
 UWz8O6ney9p5/hcwiEmVQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206303>

Am 24.09.2012 18:27, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>> In any case, the log message I suggested in the review needs to be
>> updated in the reroll to make it clear that this is about reading
>> from .gitmodules, not "configuration".  AFAICS, gitmodule_config()
>> does not even read from $GIT_DIR/config, right?
> 
> OK.  gitmodule_config() does not read $GIT_DIR/config, but
> cmd_status() and cmd_commit() call git_diff_basic_config() that is
> called from git_diff_ui_config() to read submodule.$name.ignore from
> it.  So Orgad's patch is _only_ about submodule.$name.ignore that is
> in in-tree .gitmodule; the log message shouldn't mention "config",
> as setting configuration variables work for both status and commit
> just fine.

Yes, I was just checking that call path too to make sure the user
settings from $GIT_DIR/config really override those found in
.gitmodules. And of course you are right, while the change to the
code is sane the commit message still needs some work.
