From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Does cloning a shallow repo require special setting in the cloned  one?
Date: Thu, 26 Feb 2009 16:42:22 -0800 (PST)
Message-ID: <m3prh4vhdg.fsf@localhost.localdomain>
References: <1235620146513-2387799.post@n2.nabble.com> <87tz6hn1tg.fsf@iki.fi>
	<20090226104657.GB4226@coredump.intra.peff.net>
	<6eac7f470902260501v6d826af7rbc5afd1df7b214a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Teemu Likonen <tlikonen@iki.fi>,
	git@vger.kernel.org
To: Roy Lee <roylee17@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 01:43:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcqpW-0008Hd-FF
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 01:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbZB0Am1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2009 19:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbZB0Am0
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 19:42:26 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:58142 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbZB0Am0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 19:42:26 -0500
Received: by fxm24 with SMTP id 24so812714fxm.37
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 16:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=UTKxk7DETJFBVUZCje+CcytVzAVUIJTZg64hm1wHWVE=;
        b=SmI+wtl9LUmnyPlg6kBEWXQmKGg9q+S9w85enBDVS4D4z7Uiu5BUv74yzVVR7jEdXx
         Rl+Jard2BHTItga4tJtEgkkajVoe9n73myOeIMBaHOre9At2FMBRFfJLozn+q4AiLKVb
         ItpVSS4It8ziBUEBHZOYLyHfFNELEFaVhjXk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=dV5YM1xYAzHqQCrlJTzXILdyXOa5rUFY+YINtRg7wEioiatX/aUVdqlkTmMWxBDE45
         MoXPQt9XXKE+J0eErlsEVkto81wEvbdm5Gq0sSkQNqYsZCo+8G3rJo+4TIfm66uNQqQU
         /c9Teim/N1GsQObcQUHduNVCLBXKB9GJgJKe4=
Received: by 10.86.4.2 with SMTP id 2mr476525fgd.34.1235695343209;
        Thu, 26 Feb 2009 16:42:23 -0800 (PST)
Received: from localhost.localdomain (abvt245.neoplus.adsl.tpnet.pl [83.8.217.245])
        by mx.google.com with ESMTPS id l12sm4910302fgb.31.2009.02.26.16.42.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Feb 2009 16:42:22 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1R0i0rg011635;
	Fri, 27 Feb 2009 01:44:01 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1R0hu0g011632;
	Fri, 27 Feb 2009 01:43:56 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <6eac7f470902260501v6d826af7rbc5afd1df7b214a3@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111622>

Roy Lee <roylee17@gmail.com> writes:
> On Thu, Feb 26, 2009 at 6:46 PM, Jeff King <peff@peff.net> wrote:
>> On Thu, Feb 26, 2009 at 08:34:51AM +0200, Teemu Likonen wrote:
>>> On 2009-02-25 19:49 (-0800), roylee17 wrote:
>>>
>>>> $ git clone --depth 1 git-full git-shallow2
>>>> 'git log' still gives a full history
>>>>
>>>> Why can't I clone a shallow repo from the git-full?
>>>> Does it requires some settings in the git-full repo?
>>>
>>> I don't know the "why" part but using file:// URL should work:
>>>
>>> =A0 =A0 git clone --depth 1 file:///path/to/git-full git-shallow2
>>
>> I don't think the behavior is intentional, but a side effect of the
>> fact that git takes some shortcuts when cloning locally. In particul=
ar,
>> it will try to copy or hardlink the object database rather than
>> transmitting over the git protocol locally. Using file:// has always
>> been the way to suppress that shortcut.
>>
>> Perhaps to avoid surprise, that optimization should be turned off fo=
r
>> options which cause it to behave differently (like --depth). But I h=
ave
>> to wonder what the point of --depth is locally; if you are worried a=
bout
>> space, hardlinks (the default) or alternates ("clone -s") are a bett=
er
>> solution.
>=20
> Actully, the original intention was to find a quick way to checkout a=
nd
> build several projects regularly. The first thing came to me was clon=
ing
> shallow repos for saving some time. So I tried it with my local repo =
first.
>=20
> Later, one of my co-works suggested me to try git archive, and that d=
id
> reallly fit my needs.

Perhaps you would be interested then in contrib/workdir/git-new-workdir
script then, which allows for multiple checked out copies from a single
repository?  Be aware that if you work in those copies, and are not
careful, it can lead to confusion; but if all but one of checkouts are
read only it could be the best solution.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
