From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 3/3] push: Add the --no-recurse-submodules option
Date: Fri, 29 Jul 2011 22:19:50 +0200
Message-ID: <4E3315E6.8060501@web.de>
References: <1311790250-32454-1-git-send-email-iveqy@iveqy.com> <1311790250-32454-4-git-send-email-iveqy@iveqy.com> <7vy5zikw6e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	hvoigt@hvoigt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 22:19:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmtXJ-0006Bf-M2
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 22:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372Ab1G2UTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 16:19:53 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:46224 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab1G2UTw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 16:19:52 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id 0A50A1A7532FA;
	Fri, 29 Jul 2011 22:19:51 +0200 (CEST)
Received: from [91.48.126.63] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QmtXC-0008F4-00; Fri, 29 Jul 2011 22:19:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <7vy5zikw6e.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18LYg979pngoaypYDmu63xQN6KQ8LtXAQLgnG9x
	cBH7hGRHNhEIgzerOo8kclUua0yOgzth1wTVrHz4/NuNZeVER/
	ihl3uogNDqrnOqiBZdLw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178165>

Am 28.07.2011 22:05, schrieb Junio C Hamano:
> Fredrik Gustafsson <iveqy@iveqy.com> writes:
>> diff --git a/transport.h b/transport.h
>> index 161d724..c6ccf8c 100644
>> --- a/transport.h
>> +++ b/transport.h
>> @@ -101,6 +101,7 @@ struct transport {
>>  #define TRANSPORT_PUSH_MIRROR 8
>>  #define TRANSPORT_PUSH_PORCELAIN 16
>>  #define TRANSPORT_PUSH_SET_UPSTREAM 32
>> +#define TRANSPORT_PUSH_NO_RECURSE_SUBMODULES 64
> 
> Also naming the constant with NO will invite an unnecessary double
> negation, like this:
> 
> 	if (!(flags & FROTZ_NO_NITFOL))
>         	do_nitfol_to_frotz();

Right, we'll drop the "NO_" from that constant.

> Besides, I would be moderately annoyed if this check were the default.

We will skip the check for submodules without remotes, does that lessen
your annoyance? We still think it is a good idea to have that test enabled
by default, but it might be a good idea to wait with that until we provide
a central config option to enable users to turn that off with a simple
"git config push.recurseSubmodules off". What do you think?
