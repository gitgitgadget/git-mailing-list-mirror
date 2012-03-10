From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Sat, 10 Mar 2012 07:16:08 +0100
Message-ID: <4F5AF1A8.4050604@alum.mit.edu>
References: <vpqobs65gfc.fsf@bauges.imag.fr>  <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr> <1331288715.21444.38.camel@beez.lab.cmartin.tk> <4F5A4C45.7070406@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 07:17:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6FcF-0007LZ-54
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 07:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab2CJGQn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Mar 2012 01:16:43 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:57373 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab2CJGQm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 01:16:42 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEAC66.dip.t-dialin.net [84.190.172.102])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q2A6G8aq014344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 10 Mar 2012 07:16:09 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.27) Gecko/20120216 Lightning/1.0b2 Thunderbird/3.1.19
In-Reply-To: <4F5A4C45.7070406@xiplink.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192767>

On 03/09/2012 07:30 PM, Marc Branchaud wrote:
> On 12-03-09 05:25 AM, Carlos Mart=C3=ADn Nieto wrote:
>> On Fri, 2012-03-09 at 09:31 +0100, Matthieu Moy wrote:
>>> This patch prepares a transition to 'upstream', unlike the previous
>>> version which was advertizing 'current'. In most case, this would b=
e
>>> the same, but 'upstream' is probably more sensible in case it point=
s
>>> to a branch other than 'current'. I don't care much either way.
>>>
>>
>> For people using git as VCS that happens to have local history rathe=
r
>> than taking full advantage of the distributed nature (or who aren't
>> aware of it or don't get it), 'matching' is bound to be confusing.
>> However, IMO 'current' makes more sense. Consider
>> [...]
>=20
> I disagree and consider "upstream" to be the more reasonable default.
> [...]

I think that either "current" or "upstream" would be an improvement on
the current behavior, but each of them is inappropriate in certain
workflows (even among centralized workflows).

I propose that the default should be even stricter: like "current", it
would push to an branch with the same name as the current local branch,
*but only if that branch already exists on the remote*.  It would only
be possible to create a new branch on the remote by calling "git push"
with an explicit branch argument.  I believe that such a policy would d=
o
the right thing in the cases where the "right thing" is pretty
unambiguous, and would require a user decision in other cases.

Of course, users who have a strong preference for what is the "right
thing" in the ambiguous case can fine-tune their local preference to
"current" or "upstream"; this would amount to a relaxation of the stric=
t
default policy.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
