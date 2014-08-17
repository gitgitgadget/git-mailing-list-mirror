From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] run-command: introduce CHILD_PROCESS_INIT
Date: Sun, 17 Aug 2014 09:25:58 +0200
Message-ID: <53F05906.9070909@web.de>
References: <53EFE15B.7030805@web.de> <20140817071230.GB23808@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 17 09:27:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIuro-0004Fq-Nz
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 09:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbaHQH05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Aug 2014 03:26:57 -0400
Received: from mout.web.de ([212.227.17.11]:54926 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbaHQH04 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 03:26:56 -0400
Received: from [192.168.178.27] ([79.253.143.177]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MS2D8-1WvE8P0xdC-00TGAF; Sun, 17 Aug 2014 09:26:43
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140817071230.GB23808@peff.net>
X-Provags-ID: V03:K0:Omn1GsOlWsNqPLezHQ4fkhGHpMZqg07TYRb5vSR6Z1pjX0F8EuQ
 1rRKqx1vVYI+ro5vO0hM3UNXjGN7TfE1tgYtTEUiOnA6pgtmihjCHmfFKwHBJ3r18dnFQSG
 gpte1lvHLmVP/y61WEtBU6QlZ0jor6B51R5aUSKQrvOr1aAfUTtVTm/jkFZk6QjpQdKzm1n
 Q/93lib2qjyEyWaNyMsnw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255351>

Am 17.08.2014 um 09:12 schrieb Jeff King:
> On Sun, Aug 17, 2014 at 12:55:23AM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Most struct child_process variables are cleared using memset right a=
fter
>> declaration.  Provide a macro, CHILD_PROCESS_INIT, that can be used =
to
>> initialize them statically instead.  That's shorter, doesn't require=
 a
>> function call and is slightly more readable (especially given that w=
e
>> already have similar macros like STRBUF_INIT, ARGV_ARRAY_INIT etc.).
>
> I think one reason we never had an INIT macro here is that you cannot
> simply use the struct after zero-ing it anyway. That's just the first
> step, and then you have to tweak a bunch of fields to get what you wa=
nt.
> So the memset is just one setup line out of many.

Some (or most?) of these steps could be converted to named
initializers -- once all supported platforms provide them..

Ren=C3=A9
