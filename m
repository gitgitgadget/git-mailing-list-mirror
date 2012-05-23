From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] refs: use strings directly in find_containing_dir()
Date: Wed, 23 May 2012 18:20:03 +0200
Message-ID: <4FBD0E33.4060309@lsrfire.ath.cx>
References: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu> <4FBBE012.6090702@lsrfire.ath.cx> <7vlikj3nzc.fsf@alter.siamese.dyndns.org> <4FBC0F12.2000001@lsrfire.ath.cx> <7vhav73lnl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 23 18:20:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXEIP-0002GT-6c
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 18:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505Ab2EWQUO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 12:20:14 -0400
Received: from india601.server4you.de ([85.25.151.105]:33192 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab2EWQUN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 12:20:13 -0400
Received: from [192.168.2.105] (p579BE06F.dip.t-dialin.net [87.155.224.111])
	by india601.server4you.de (Postfix) with ESMTPSA id 43D0B2F8058;
	Wed, 23 May 2012 18:20:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vhav73lnl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198304>

Am 23.05.2012 00:18, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>
>> What has git grep to do with refs?  It checks if the path in the com=
mand
>> above is a ref, which makes it iterate over all of them..
>
> Do you mean:
>
> 	/* Is it a rev? */
>          get_sha1()
>          ->  ...
>            ->  get_sha1_basic()
>              ->  dwim_ref()
>
> callpath?

Yes, indeed.  Hmm, this is done even if the paths come after a=20
double-dash.  Anyway, I don't consider the check to be a performance=20
issue, just a quick way to test the allocation count that i stumbled=20
upon while working on the recent grep patches.

Ren=C3=A9
