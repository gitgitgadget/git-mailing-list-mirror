From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCH/RFC 0/4] Providing mechanism to list available 
	repositories
Date: Wed, 14 Jul 2010 15:29:31 -0400
Message-ID: <AANLkTilCoyOcm8cvW06UTWJk7P4m6WNLeZICHrTp5-aI@mail.gmail.com>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu>
	<7viq4hyj3g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 21:29:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ7eH-00043U-Is
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 21:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779Ab0GNT3g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 15:29:36 -0400
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:60856 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754734Ab0GNT3g convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 15:29:36 -0400
X-AuditID: 12074423-b7be0ae000000a83-7d-4c3e101f4029
Received: from mailhub-auth-2.mit.edu (MAILHUB-AUTH-2.MIT.EDU [18.7.62.36])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Brightmail Gateway) with SMTP id 4D.28.02691.F101E3C4; Wed, 14 Jul 2010 15:29:35 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o6EJTY7C010529
	for <git@vger.kernel.org>; Wed, 14 Jul 2010 15:29:34 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6EJTW5O022853
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 14 Jul 2010 15:29:34 -0400 (EDT)
Received: by wwi17 with SMTP id 17so2399822wwi.1
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 12:29:31 -0700 (PDT)
Received: by 10.227.147.135 with SMTP id l7mr16534619wbv.37.1279135771785; 
	Wed, 14 Jul 2010 12:29:31 -0700 (PDT)
Received: by 10.227.129.16 with HTTP; Wed, 14 Jul 2010 12:29:31 -0700 (PDT)
In-Reply-To: <7viq4hyj3g.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAARUsEms=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151030>

>> We find this mechanism useful in that it requires no extra
>> infrastructure on either our end or the user's end. =A0Our
>> implementation is extensible, allowing the system administrator to
>> place arbitrary commands in ~/git-shell-commands (if the directory i=
s
>> omitted, no extra functionality is exposed), and also supports an
>> interactive mode.
>>
>> What do people think of this approach? =A0I'd love to get this
>> functionality merged in some form.
>
> It seems to me that any time you need to add a new helper command, th=
e
> administrator needs to make sure that appears in ~$user/git-shell-com=
mands
> of all the users who need it. =A0When adding a new user, a similar
> management action needs to happen. =A0Perhaps that is done by making =
a
> symlink from all the users' home directories to one shared place. =A0=
Is that
> the general idea?
That's correct.  Our particular environment only has a single git
user, but if we were to add more we would probably make
git-shell-commands a symlink as you suggest.

> In any case, I'd prefer that the sample command implementations like =
list
> and help to live in contrib/ somewhere. =A0They are not part of what =
the
> main Makefile needs to know about, right?
Also correct.  I'll look for a reasonable place within contrib/ to put =
them.
