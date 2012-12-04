From: Lukasz Stelmach <stlman@poczta.fm>
Subject: Re: [PATCH] gitk: read and write a repository specific configuration
 file
Date: Tue, 04 Dec 2012 21:12:37 +0100
Message-ID: <50BE5935.4040809@poczta.fm>
References: <1kujrnc.1r4khfkkpdoo1M%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, paulus@samba.org, gitster@pobox.com
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Tue Dec 04 21:13:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfyrU-0001RN-JH
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 21:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab2LDUMo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2012 15:12:44 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.205]:58751 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab2LDUMn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2012 15:12:43 -0500
Received: from [192.168.0.13] (87-207-152-6.dynamic.chello.pl [87.207.152.6])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTPSA;
	Tue,  4 Dec 2012 21:12:37 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.6esrpre) Gecko/20120825 Thunderbird/10.0.6
In-Reply-To: <1kujrnc.1r4khfkkpdoo1M%lists@haller-berlin.de>
X-Enigmail-Version: 1.3.5
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
	s=biztos; t=1354651960;
	bh=iS7r8lxJzcIOdB2Iticqd4eaA0ncmnoblKPUXEaFHqg=;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:
	 Subject:References:In-Reply-To:X-Enigmail-Version:Content-Type:
	 Content-Transfer-Encoding:X-Interia-Antivirus;
	b=ZYbNerpVEutG0kYJZijIzXOB0AsuoASB93TSGFxCnc9f9BYEcOJQN0duYw3uIwabu
	 7TYcCuO1lHK+fL/PQlWd+2+CAXQdZawctPEnAy6CxbCooMB7Fz5Q7s9UqvanUw38Ki
	 4B7BA8Ugym7jGtpIabTy69fDyhOY0lef2jKDz9CQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211095>

W dniu 03.12.2012 22:15, Stefan Haller pisze:
> Lukasz Stelmach <stlman@poczta.fm> wrote:
>=20
>> Enable gitk read and write repository specific configuration
>> file: ".git/k" if the file exists. To make gitk use the local
>> file simply create one, e.g. with the touch(1) command.
>=20
> I'm not sure I like this proposal. While it may be desirable to have
> *some* settings stored per repository, for most settings I want them =
to
> be remembered globally.

The way it works with my patch, gitk reads global settings from ~/.gitk=
=2E
So you can treat it as a template. Then, when you exit it saves to loca=
l
file if it exists. This of course means you can't override settings fro=
m
=2E/.git/k with something from ~/.gitk by simply choosing to on GUI.
However, it takes no more than removing appropriate line from .git/k to
get the value from ~/.gitk.

IMHO this is a reasonable compromise which is available at no cost as
far as data structure complexity is concerned. Choosing where to save
what would require a bit of information per configuration variable. Wit=
h
a mask saved locally surprises may come when you change a variable,
forget to localise it and it pops in a different repository. My
approach, however simplistic, avoids this particular pitfall.


> Git-gui tries to solve this by presenting two panes in the preference=
s
> dialog, so that I can choose the scope of every setting I change. Thi=
s
> still doesn't help for things that are remembered implicitly, like th=
e
> window size.
>=20
> I don't have good suggestions how to solve this; just pointing out
> problems.
>=20
>=20


--=20
By=C5=82o mi bardzo mi=C5=82o.               Czwarta pospolita kl=C4=99=
ska, [...]
>=C5=81ukasz<                 Ju=C5=BC nie katolicka lecz z=C5=82odziej=
ska.  (c)PP
