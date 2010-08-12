From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [RFC/PATCH] git-add: Don't exclude explicitly-specified tracked 
	files
Date: Wed, 11 Aug 2010 22:11:35 -0400
Message-ID: <AANLkTimg8_YAVR0ncz71Mr1+b8Q9kL9oxjjYEOpqFMoK@mail.gmail.com>
References: <1281510236-8103-1-git-send-email-gdb@mit.edu>
	<AANLkTikPSR36SdUuzWsXxZsy9jsKOnp=_iz43BF-6nYe@mail.gmail.com>
	<4C630D23.5090001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 12 04:11:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjNGk-00070u-9p
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 04:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932933Ab0HLCLk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 22:11:40 -0400
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:55843 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754445Ab0HLCLj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 22:11:39 -0400
X-AuditID: 1209190f-b7b0aae000000a7d-c7-4c63585dbcbc
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id C0.2F.02685.D58536C4; Wed, 11 Aug 2010 22:11:41 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o7C2BcuV001272
	for <git@vger.kernel.org>; Wed, 11 Aug 2010 22:11:38 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7C2BadV024919
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 11 Aug 2010 22:11:37 -0400 (EDT)
Received: by wwj40 with SMTP id 40so930014wwj.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 19:11:36 -0700 (PDT)
Received: by 10.216.157.81 with SMTP id n59mr17395151wek.84.1281579095910; 
	Wed, 11 Aug 2010 19:11:35 -0700 (PDT)
Received: by 10.216.19.142 with HTTP; Wed, 11 Aug 2010 19:11:35 -0700 (PDT)
In-Reply-To: <4C630D23.5090001@web.de>
X-Brightmail-Tracker: AAAAARWXE7o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153324>

> Are we talking about two different issues here?
>
> Am 11.08.2010 14:24, schrieb =C6var Arnfj=F6r=F0 Bjarmason:
>> On Wed, Aug 11, 2010 at 07:03, Greg Brockman <gdb@mit.edu> wrote:
>>> Currently, 'git add' will complain about excluded files, even if th=
ey
>>> are already tracked:
>
> I'm all for not complaining when adding an ignored file that is
> already tracked, as the user already told us he wants to track
> this file despite .gitignore.
>
>>> ... so it feels natural to me not
>>> to require extra user confirmation when an explicit path has been p=
rovided.
>>
>> I like it. I keep a /etc in git with .gitignore "*". This would help=
 a
>> lot for use cases like that. Explicitly specifying a full path shoul=
d
>> override gitignore IMO.
>
> I'm not so sure if we should silently add ignored files just because
> they appear on the command line. For me having to force the first tim=
e
> I do a "git add" for an otherwise ignored file looks like a feature.
Correct me if I'm wrong, but I read =C6var's use to be exactly the one =
I
described.  In particular, he presumably has a few interesting files
in /etc that he tracks but wants to ignore the rest.  So as far as I
can tell we are all talking about the same issue.

To be clear, I certainly agree that having to force the first time you
run 'git add' is a feature, and my patch explicitly does not change
this functionality.

Anyway, modulo further discussion, I will add some tests and send the
revised version to the list.  Thanks all for looking this over.
