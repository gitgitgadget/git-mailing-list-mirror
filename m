From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Re*: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Sun, 11 Mar 2012 22:10:37 +0100
Message-ID: <4F5D14CD.6080507@web.de>
References: <201203052039.16893.tboegi@web.de> <7vzkbuzss7.fsf@alter.siamese.dyndns.org> <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com> <7vfwdkm6xs.fsf@alter.siamese.dyndns.org> <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com> <7v4nu0m5tb.fsf@alter.siamese.dyndns.org> <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com> <7vd38okmp0.fsf@alter.siamese.dyndns.org> <7vlin94dbc.fsf_-_@alter.siamese.dyndns.org> <4F5BD585.5050007@web.de> <4F5CC08C.90703@web.de> <7vzkbnvt6m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 22:11:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6q2b-0007jS-7r
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 22:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500Ab2CKVKx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 17:10:53 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:35068 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab2CKVKw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 17:10:52 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate04.web.de (Postfix) with ESMTP id 4ADA573928A5
	for <git@vger.kernel.org>; Sun, 11 Mar 2012 22:10:51 +0100 (CET)
Received: from wanderer.site ([194.22.188.61]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MOSAP-1S12k83LaX-00659i; Sun, 11 Mar 2012 22:10:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120208 Thunderbird/10.0.1
In-Reply-To: <7vzkbnvt6m.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:VnTZkB8P2C8qH6Tq87E/Bhd2D7cIL82l0JdOWMPGvEz
 UUxNkXSABSPwrs3h4bg9sRyLdXS2WLiswJfEQuU4xzN9za0+U7
 gIeiEKLTZPqzY8J4Q5VJh1OHmByNTpA/xk3T6T2hXl39W6/ufP
 Lok72pyNVVBFKkZWAoQ+PLzDFeXL0lMI63I9MgsjooZ8COl4CP
 GYd+L3dLZbfsShF8jwbOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192830>

On 03/11/2012 08:22 PM, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen<tboegi@web.de>  writes:
>
>> Here the results of my investigations:
>> a) git-sh-i18n is used by the test suite, not git-sh-i18n.sh
>>     git-sh-i18n is generated from git-sh-i18n.sh when running make
>
> Yeah, that is the correct behaviour.
>
>> b) When running
>>     make clean&&  make USE_GETTEXT_SCHEME=3Dgnu&&  (cd t&&  make)
>>    the log of t0204 looks like this:
>> ...
>> Summary: test OK,
>
> Now, the last remaining issues appear to be these:
>
>   * Is USE_GETTEXT_SCHEME=3Dgnu the right thing for Mac OS X?  It may
>     make this test pass, but does it not break other things?  Does
>     Mac OS X come with a working gettext.sh to help i18n of shell
>     scripts?  Does it also give eval_gettext?
When I remember it right, the following comes from the Fink installatio=
n=20
on my machine:
which gettext
/sw/bin/gettext

which gettext.sh
/sw/bin/gettext.sh

None of the machines here (Mac OS X, Ubuntu 10.04.4 LTS, OpenSuse 12.1)
has a eval_gettext

>   * If so, Mac OS X users shouldn't have to say that from the command
>     line of "make". Do we need a Makefile update?
Good question.
I couldn't find any setup of USE_GETTEXT_SCHEME in Makefile
(except when NO_GETTEXT is set), do I need to run configure?
So far the Makefile worked for all my systems here.

>
>   * If not, what is the appropriate value for USE_GETTEXT_SCHEME on=3D
>     Mac OS X?  If the answer is not "fallthrough", do we need a
>     Makefile update?
My guess is that "gettext_without_eval_gettext" would be right
(if we have Fink installed)

But again, what did I overlook in the Makefile?
Should there be some hard coded default for e.g. Darwin?
With a switch when Fink is installed?
