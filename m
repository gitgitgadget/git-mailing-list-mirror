From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git cherry-pick: Add NULL check to sequencer parsing
 of HEAD
Date: Thu, 03 May 2012 14:26:46 +0200
Message-ID: <4FA27986.7010502@lsrfire.ath.cx>
References: <1336044026-16897-1-git-send-email-nhorman@tuxdriver.com> <4FA26FF2.2050607@lsrfire.ath.cx> <20120503120857.GA3085@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mmueller@vigilantsw.com,
	Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Thu May 03 14:26:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPv7U-0003Sf-GT
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 14:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab2ECM0s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 May 2012 08:26:48 -0400
Received: from india601.server4you.de ([85.25.151.105]:58298 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab2ECM0s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 08:26:48 -0400
Received: from [192.168.2.105] (p4FFDA20E.dip.t-dialin.net [79.253.162.14])
	by india601.server4you.de (Postfix) with ESMTPSA id 48F522F804F;
	Thu,  3 May 2012 14:26:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <20120503120857.GA3085@hmsreliant.think-freely.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196904>

Am 03.05.2012 14:08, schrieb Neil Horman:
>>> +	if (parse_commit(head_commit))
>>>   		return error(_("could not parse commit %s\n"),
>>>   			     sha1_to_hex(head_commit->object.sha1));
>>
>> Note: parse_commit() can handle NULL, and it already reports error
>> details itself.
> No, it doesn't.  parse_commit checks NULL already, true, but it just =
returns -1.
> No error message is provided to the user

Sorry, was too terse again: It handles NULL, without printing anything.=
=20
  And it reports details for (other) errors.  So you could return -1 if=
=20
parse_commit() returns non-zero and be done with it.  Just saying.

Ren=E9
