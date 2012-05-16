From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Subject: Re: git format-patch doesn't exclude merged hunks
Date: Wed, 16 May 2012 21:13:50 +0100
Message-ID: <4FB40A7E.80705@draigBrady.com>
References: <4FB3CAE3.6040608@draigBrady.com> <7vhavgc660.fsf@alter.siamese.dyndns.org> <4FB3FA59.1010707@draigBrady.com> <7v8vgsc544.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 16 22:14:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUkbp-0004ty-Jt
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 22:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965757Ab2EPUOD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 16:14:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45132 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965745Ab2EPUOB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 16:14:01 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q4GKDrmj003062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 16 May 2012 16:13:53 -0400
Received: from [10.36.116.83] (ovpn-116-83.ams2.redhat.com [10.36.116.83])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q4GKDoHg029367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Wed, 16 May 2012 16:13:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7v8vgsc544.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.2
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197897>

On 05/16/2012 08:12 PM, Junio C Hamano wrote:
> P=C3=A1draig Brady <P@draigBrady.com> writes:
>=20
>> On 05/16/2012 07:49 PM, Junio C Hamano wrote:
>>
>>> I am not fundamentally opposed to the idea of (optionally) detectin=
g and
>>> selectively dropping parts of a patch to an entire file or even hun=
ks that
>>> have already applied, but it needs to have a way remind the user so=
mewhere
>>> in the workflow that it did so and the log message may no longer de=
scribe
>>> what the change does.  Most likely it would have to be done when pr=
oducing
>>> format-patch output, but an approach to make it a responsibility to=
 notice
>>> and fix the resulting log message to the person who applies the out=
put, I
>>> would imagine.
>>
>> Yep agreed, it would have to be optional.
>> Maybe --ignore-duplicate-changes ?
>>
>> Appending a marker to the commit message of the adjusted patch would=
 make sense,
>> similar to how a 'Conflicts:' list is auto generated for commit mess=
ages.
>=20
> These existing "conflicts:" are offered when recording manual resolut=
ions
> of a conflicting merge, and the user is actively thrown into an edito=
r
> when running "git commit" to record the result.
>=20
> A patch that is reduced in a way you propose will apply to the receiv=
ing
> tree cleanly without stopping, and does not offer an editor session t=
o
> adjust the log before making a commit.  "The user has a chance to not=
ice
> and correct" is not sufficient---nobody will spend extra effort to no=
tice
> let alone correct.  The reminder has to be a lot stronger than that, =
I
> think, to cause the patch application to "fail" and require the user =
to
> actively look at the situation.

Yes it would make sense for `git am` to balk at
such reduced patches, while allowing standard
patch utilities to process the patches as normal.

cheers,
P=C3=A1draig.
