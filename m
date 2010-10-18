From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v4 15/15] daemon: opt-out on features that require posix
Date: Mon, 18 Oct 2010 20:13:44 +0200
Message-ID: <m2y69vl67b.fsf@igel.home>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
	<1286833829-5116-16-git-send-email-kusmabite@gmail.com>
	<7vhbgphf25.fsf@alter.siamese.dyndns.org>
	<AANLkTi=N+4QokkiGmN+S17=7=QsgKWUXrsF0vZ_6Zt2H@mail.gmail.com>
	<7vbp6vduly.fsf@alter.siamese.dyndns.org>
	<AANLkTim0KeW3eDHAsxrxMCvBUD_15R3VSrHSzOFq38A1@mail.gmail.com>
	<20101018163134.GA6343@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 20:14:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7uDh-0000Dx-83
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 20:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933040Ab0JRSNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 14:13:54 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47404 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757625Ab0JRSNs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 14:13:48 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 0B55B1C159D1;
	Mon, 18 Oct 2010 20:13:45 +0200 (CEST)
Received: from igel.home (ppp-88-217-100-119.dynamic.mnet-online.de [88.217.100.119])
	by mail.mnet-online.de (Postfix) with ESMTP id EE4351C00142;
	Mon, 18 Oct 2010 20:13:44 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 84DD6CA2A0; Mon, 18 Oct 2010 20:13:44 +0200 (CEST)
X-Yow: Catsup and Mustard all over the place!  It's the Human Hamburger!
In-Reply-To: <20101018163134.GA6343@burratino> (Jonathan Nieder's message of
	"Mon, 18 Oct 2010 11:31:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159275>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Just to throw an idea out: you can also do something like
>
> #ifndef NO_POSIX_GOODIES
> struct credentials {
> };
> #else
> struct credentials {
> 	struct passwd *pass;
> 	gid_t gid;
> }
> #endif
>
> and pass a pointer to credentials around.

Empty structures are not standard C.  But if you only ever use a pointer
to the struct you can leave it undefined (ie. just forward-declare it).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
