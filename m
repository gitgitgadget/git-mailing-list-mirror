From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Branch Name Case Sensitivity
Date: Tue, 04 Mar 2014 14:23:05 +0100
Message-ID: <5315D3B9.6050602@gmail.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>	<530FA0C1.3000109@web.de> <530FBB1D.3050505@gmail.com>	<CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>	<53102FB0.6040603@viscovery.net> <5310959D.709@gmail.com>	<xmqqk3cfuksd.fsf@gitster.dls.corp.google.com>	<CACsJy8A6etyFkxn3D7hjM9JgzmokPBARXrEncVuw1x+OOHJ_Lg@mail.gmail.com>	<xmqq7g8eu891.fsf@gitster.dls.corp.google.com>	<CAJHY66EP539ZsLJcmHcnRQcOqcLqXK-M45wME9DkKkqmumg8fA@mail.gmail.com> <xmqqsiqzrwzr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Lee Hopkins <leerhop@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 14:23:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKpJR-0000KB-Vu
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 14:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757241AbaCDNXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 08:23:09 -0500
Received: from mail-bk0-f52.google.com ([209.85.214.52]:43263 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757200AbaCDNXH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 08:23:07 -0500
Received: by mail-bk0-f52.google.com with SMTP id my13so204154bkb.25
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 05:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cI6Tp7/ZSPnYrP/RghVW+ax9FSN+N6198EwruPYC8PM=;
        b=Is1LIqMfv/2dGW5kqWCygHihsmk4cOVbOpf3jR5JJrlTUVUUoQZJZHn1SyJ/CppQ11
         /9pzI3SEW2dxIR3l2mYZGyv/9DEBsjaGeoztW4t+fR+R8o/RlV7yBy8Lu18wyeh123WW
         gRuRE1Wdf7npFAtZ3ogTOEzHN5UbjGdhOAWbfZ0Bca67BX30Bb3bp3NCqx1Pkj8uiTg4
         GSX0lXVv9kKB3SNPLZnDEtpxIUXGMH5gIarpNS+E0HnEvvmhpI1k95ax+JerFmsmK/5n
         Mo4j113rJim0zxPFDJvzkkcOSEtmeUjpGJqXIFIRFGEk/RWp8duPy0aKgGlblcdc/3hp
         3xjQ==
X-Received: by 10.205.36.200 with SMTP id tb8mr642171bkb.105.1393939386421;
        Tue, 04 Mar 2014 05:23:06 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id e8sm288198bko.0.2014.03.04.05.23.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Mar 2014 05:23:05 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqsiqzrwzr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243341>

Am 03.03.2014 18:51, schrieb Junio C Hamano:
> Lee Hopkins <leerhop@gmail.com> writes:
> 
>> I went ahead and took a stab at a solution. My solution is more
>> aggressive than a warning, I actually prevent the creation of
>> ambiguous refs. My changes are also in refs.c, which may not be
>> appropriate, but it seemed like the natural place.
>>
>> I have never contributed to Git (in fact this is my first dive into
>> the source) and my C is a bit rusty, so bear with me, this is just a
>> suggestion:
>>
>> ---
>>  refs.c |   31 ++++++++++++++++++++++++-------
>>  1 files changed, 24 insertions(+), 7 deletions(-)
> 
> Starting something like this from forbidding is likely to turn out
> to be a very bad idea that can break existing repositories.
> 

Its sure worth considering what should be done with pre-existing duplicates. However, repositories with such refs are already broken on case-insensitive filesystems, and allowing something that's known to be broken is even more dangerous, IMO.

An alternative approach could be to encode upper-case letters in loose refs if core.ignorecase == true (e.g. "Foo" -> "%46oo"). Although this may pose a problem for commands that bypass the refs API / plumbing for whatever reason.

> A new configuration
> 
> 	refs.caseInsensitive = {warn|error|allow}
> 

s/caseInsensitive/caseSensitive/
Its case-sensitive refs that cause trouble, case-insensitive refs would be fine on all platforms.

I still don't see why we need an extra setting for this. The problems are inherently caused by case-insensitive filesystems, and we already have 'core.ignorecase' for that (its even automatically configured). Having an extra setting for refs is somewhat like making 'core.ignorecase' configurable per sub-directory.

> that defaults to "warn" and the user can choose to set to "error" to
> forbid, would be more palatable, I would say.
> 
> If the variable is not in 'core.' namespace, you should implement
> this check at the Porcelain level, allowing lower-level tools like
> update-ref as an escape hatch that let users bypass the restriction
> to be used to correct breakages; it would mean an unconditional "if
> !stricmp(), it is an error" in refs.c will not work well.
> 
> I think it might be OK to have
> 
> 	core.allowCaseInsentitiveRefs = {yes|no|warn}
> 
> which defaults to 'warn' (and 'yes' corresponds to 'allow', 'no'
> corresponds to 'error', in the previous suggestion), instead. If we
> wanted to prevent even lower-level tools like update-ref from
> bypassing the check, that is.
> 

Its the plumbing that's broken, so implementing checks at the porcelain level won't help much. In particular, git-update-ref currently drops branches (or resets them to an earlier state) and messes up reflogs.
