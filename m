From: Yuri <yuri@rawbw.com>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Tue, 04 Feb 2014 14:45:11 -0800
Message-ID: <52F16D77.2000604@rawbw.com>
References: <20140117041430.GB19551@sigill.intra.peff.net> <20140117042153.GB23443@sigill.intra.peff.net> <xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com> <20140121054927.GD5878@sigill.intra.peff.net> <xmqqwqhtuojx.fsf@gitster.dls.corp.google.com> <20140204221220.GA5457@sigill.intra.peff.net> <xmqqiosu7ca2.fsf@gitster.dls.corp.google.com> <20140204222507.GA6031@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 23:45:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAokK-0006AH-GZ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934824AbaBDWp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:45:28 -0500
Received: from shell0.rawbw.com ([198.144.192.45]:52147 "EHLO shell0.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933411AbaBDWpY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:45:24 -0500
Received: from eagle.yuri.org (stunnel@localhost [127.0.0.1])
	(authenticated bits=0)
	by shell0.rawbw.com (8.14.4/8.14.4) with ESMTP id s14MjC5i016366;
	Tue, 4 Feb 2014 14:45:13 -0800 (PST)
	(envelope-from yuri@rawbw.com)
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140204222507.GA6031@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241579>

On 02/04/2014 14:25, Jeff King wrote:
> Right. If git just disabled the color, I think that would be sane (and
> that is what my patch was shooting for). But somebody who sees:
>
>    $ git log
>    ESC[33mcommit 3c6b385c655a52fd9db176ce1e01469dc9954f91ESC[mESC[33m
>    (ESC[1;36mHEADESC[mESC[33m, ESC[1;32mjk/meta-makeESC[mESC[33m)ESC[m
>
> does not necessarily know what is going on. They do not know that it is
> a "less" problem, nor that their less settings are relevant. They only
> see that Git is broken out of the box.

Maybe, instead of doing all the elaborate guess and assumption work, 
have configure script check if the current PAGER supports colors and 
build git accordingly?
configure could run the pager as one of its tests, and determine if 
"ESC" appears on the output.

Yuri
