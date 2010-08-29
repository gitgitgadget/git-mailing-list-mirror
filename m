From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 0/2] Teach fetch and pull to recursively fetch submodules
 too
Date: Mon, 30 Aug 2010 00:34:53 +0200
Message-ID: <4C7AE08D.5030009@web.de>
References: <4C7A819B.3000403@web.de> <AANLkTimyGy5-wmx7NLu53neu5ScqZw291sUP1+WLUHwX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 00:35:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpqSq-0006Em-5B
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 00:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab0H2We4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 18:34:56 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:58444 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab0H2Wez (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 18:34:55 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 0809615E22510;
	Mon, 30 Aug 2010 00:34:54 +0200 (CEST)
Received: from [93.240.104.89] (helo=[192.168.178.29])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OpqSj-0003E0-00; Mon, 30 Aug 2010 00:34:53 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTimyGy5-wmx7NLu53neu5ScqZw291sUP1+WLUHwX@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/HziDSb3uoKHo2qUtThlMxmYLAHznEbLCapk6V
	gxgwXLd5G81zJRq+iE3o3oKiIgSTq7+78+Zk+ivOvNVxEPGGIx
	phwXNDW3fN7hYkfAI/Uw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154731>

Am 29.08.2010 19:29, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> However I wonder if we're going to make --recursive the
> default for pull/fetch whether it shouldn't be made the default for
> clone while we're at it.

Hm, while that would work for me (and for you obviously ;-), it
wouldn't make sense for other use cases where submodules are used
as a kind of sparse checkout (and then some of them are never meant
to be checked out, at least by some users).

I don't think recursive fetch would hurt there, as that only
affects already populated submodules, so turning that on by
default sounds safe.

After finishing the recursive checkout of populated submodules
one of my next goals is to teach clone to recurse too, but only
for those submodules where this is wanted (aka configured via
=2Egitmodules).
