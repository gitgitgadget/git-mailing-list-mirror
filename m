From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] files given on the command line are relative to $cwd
Date: Wed, 06 Aug 2008 13:19:07 -0700
Message-ID: <7vtzdxnbgk.fsf@gitster.siamese.dyndns.org>
References: <48997D2E.9030708@obry.net>
 <20080806104432.GG7121@bit.office.eurotux.com> <4899848C.6030800@obry.net>
 <7v3alirw6b.fsf@gitster.siamese.dyndns.org> <4899D119.1080403@obry.net>
 <7vy73aqe9m.fsf@gitster.siamese.dyndns.org>
 <7vr692oufw.fsf@gitster.siamese.dyndns.org> <489A061B.7010508@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>,
	Luciano Rocha <luciano@eurotux.com>, pascal@obry.net,
	Pierre Habouzit <madcoder@debian.org>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Wed Aug 06 22:20:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQpUd-0001WM-Bt
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 22:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbYHFUTT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 16:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbYHFUTT
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 16:19:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbYHFUTS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Aug 2008 16:19:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EE6CF4DFC0;
	Wed,  6 Aug 2008 16:19:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5171E4DFBC; Wed,  6 Aug 2008 16:19:10 -0400 (EDT)
In-Reply-To: <489A061B.7010508@free.fr> (Olivier Marin's message of "Wed, 06
 Aug 2008 22:14:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F252D0D0-63F4-11DD-B3BE-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91538>

Olivier Marin <dkr+ml.git@free.fr> writes:

> Junio C Hamano a =C3=A9crit :
>> =20
>>  static int parse_and_validate_options(int argc, const char *argv[],
>> -				      const char * const usage[])
>> +				      const char * const usage[],
>> +				      const char *prefix)
>>  {
>>  	int f =3D 0;
>> =20
>>  	argc =3D parse_options(argc, argv, builtin_commit_options, usage, =
0);
>> +	logfile =3D parse_options_fix_filename(prefix, logfile);
>
> It breaks the "git commit -F -" case, no?

Does it?  Ah, yeah, t7500 #15 does not go down to a subdirectory.
