From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list 
	available repositories
Date: Wed, 28 Jul 2010 00:06:58 -0700
Message-ID: <AANLkTikE16GnoRmJ2mxzYJ7hB+5tUbBjvFmZkj12k9+C@mail.gmail.com>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
	<20100726232855.GA3157@burratino>
	<AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com>
	<201007270916.59210.j.sixt@viscovery.net>
	<20100727174105.GA5578@burratino>
	<AANLkTikr5jjZJa2irLb2rNew8ngJcv3rhcFV+pNRpRrw@mail.gmail.com>
	<20100728003336.GA2248@dert.cs.uchicago.edu>
	<AANLkTik1D45_cHPapbmMMys-V544ssCyoxrs5Fxck7oP@mail.gmail.com>
	<20100728064251.GB743@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 09:07:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe0jP-0001oF-2a
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 09:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768Ab0G1HHF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 03:07:05 -0400
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:43840 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751374Ab0G1HHD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 03:07:03 -0400
X-AuditID: 12074424-b7c35ae000000a07-51-4c4fd71735b3
Received: from mailhub-auth-2.mit.edu (MAILHUB-AUTH-2.MIT.EDU [18.7.62.36])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Brightmail Gateway) with SMTP id 86.81.02567.717DF4C4; Wed, 28 Jul 2010 03:07:03 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o6S7706n022487
	for <git@vger.kernel.org>; Wed, 28 Jul 2010 03:07:01 -0400
Received: from mail-gw0-f46.google.com (mail-gw0-f46.google.com [74.125.83.46])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6S76xXv018606
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 28 Jul 2010 03:07:00 -0400 (EDT)
Received: by gwb20 with SMTP id 20so807880gwb.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 00:06:59 -0700 (PDT)
Received: by 10.150.175.11 with SMTP id x11mr12202262ybe.222.1280300818987; 
	Wed, 28 Jul 2010 00:06:58 -0700 (PDT)
Received: by 10.231.144.140 with HTTP; Wed, 28 Jul 2010 00:06:58 -0700 (PDT)
In-Reply-To: <20100728064251.GB743@dert.cs.uchicago.edu>
X-Brightmail-Tracker: AAAAAhVhoAcVYaj0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152043>

> Agh, it=92s getting late. =A0In my last message I completely
> forgot about the make_cmd() step. =A0Sorry to waste your time
> on that.
No problem.  It was good to have some pushback so I had to justify my
assumptions.

>> This will be an arbitrary directory if a user can 'su' to the
>> git-shell user.
>
> That would be an odd setup, but I guess with shared repositories
> there's a reason to do it.
>
>> (I am however starting to lean towards always
>> chdir'ing into the git-shell user's $HOME, do people feel strongly
>> about this in either direction?)
>
> I don't feel strongly either way. =A0It would be a good way to
> put the worry about that attack vector to rest (if you use
> getpwent instead of getenv to fetch $HOME).
Sure, I'll add some logic to do this.

> Thanks for the patient explanations.
No problem.  Thanks for taking the time to read them :).

Anyway, I'll create an updated version of this patch series that deals
with the chdir'ing to the user's home directory, and that includes the
2>/dev/null line in 'list'.
