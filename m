From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Thu, 08 Nov 2012 11:03:51 -0500
Message-ID: <509BD7E7.2010807@xiplink.com>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu> <50092C8C.3000305@alum.mit.edu> <CACBZZX6=e6_qO=wMcxLdUAc6XxYpdiP-9RPRsCXrVC_iuJ11Jg@mail.gmail.com> <509B7E6B.1030407@alum.mit.edu>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Nov 08 17:11:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWUhk-0000H0-6h
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 17:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235Ab2KHQLb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2012 11:11:31 -0500
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:53005 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191Ab2KHQLa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 11:11:30 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Nov 2012 11:11:30 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp28.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 71150E0F1C
	for <git@vger.kernel.org>; Thu,  8 Nov 2012 11:04:20 -0500 (EST)
X-Virus-Scanned: OK
Received: from smtp154.ord.emailsrvr.com (smtp154.ord.emailsrvr.com [173.203.6.154])
	by smtp28.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTPS id 466C0E0F27
	for <git@vger.kernel.org>; Thu,  8 Nov 2012 11:04:20 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp24.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 3F01B198149;
	Thu,  8 Nov 2012 11:03:48 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp24.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C5DB8198236;
	Thu,  8 Nov 2012 11:03:46 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <509B7E6B.1030407@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209168>

On 12-11-08 04:42 AM, Michael Haggerty wrote:
> On 11/07/2012 10:47 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Fri, Jul 20, 2012 at 12:01 PM, Michael Haggerty <mhagger@alum.mit=
=2Eedu> wrote:
>>> On 07/14/2012 08:59 AM, mhagger@alum.mit.edu wrote:
>>>>
>>>> Add a new Python script, contrib/hooks/post-receive-multimail.py, =
that
>>>> can be used to send notification emails describing pushes into a g=
it
>>>> repository.  [...]
>>>
>>>
>>> Thanks to everybody for your feedback.  I will try to incorporate i=
t in a
>>> new version of the script, which I will put forward as a replacemen=
t for
>>> contrib/hooks/post-receive-email rather than as an alternative.  Bu=
t I have
>>> very little open-sourcing time these days, and will be on vacation =
next
>>> week, so please be patient (or feel free to lend a hand if you are =
so
>>> inclined).
>>
>> I'm curious as to whether you got around to this? I'd be interested =
in
>> updates on this script.

I installed the script in our main repository here.  Some folks complai=
ned
about the "flood" of emails for large pushes, but having separate maili=
ng
lists solved that.

Others really appreciate the individual messages with full patches.  It=
's a
challenge to create one script that can satisfy all users, but IMHO thi=
s
comes pretty close.

> Thanks for asking.  I have made many of the changes that were request=
ed
> and/or I had planned:
>=20
> * Tentatively renamed the system to git-multimail
>=20
> * Store the configuration in namespace "multimailhook.*" instead of
> "hooks.*".
>=20
> * Reinstated (optional) support for including shortlogs since the las=
t
> tag in announce emails.
>=20
> * Script to migrate post-receive-email configuration to the equivalen=
t
> git-multimail config.
>=20
> * Better documentation (including of the migration process).
>=20
> * Made it easier to use Python code to customize the script's behavio=
r
> (by allowing it to be imported as a Python module), plus a demo scrip=
t
> showing this usage.

I look forward to trying out your updates.  One thing I had to do to th=
e
original script was override get_envelopesender() in GenericEnvironment=
 to
use $USER if hooks.envelopesender is not set.  (This is what the old
post-receive-email script does.)

This script is one of a couple of things on my git back-burner.  Hopefu=
lly
things will settle down here soon and I'll be able to get back to some =
git
hacking in the next few weeks.

		M.
