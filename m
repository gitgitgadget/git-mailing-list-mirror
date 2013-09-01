From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 3/4] get rid of "git submodule summary --for-status"
Date: Sun, 01 Sep 2013 15:47:43 +0200
Message-ID: <5223457F.2080608@web.de>
References: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr> <1377781536-31955-4-git-send-email-Matthieu.Moy@imag.fr> <521FA6ED.9010005@web.de> <vpqioyonqdn.fsf@anie.imag.fr> <5220F539.9050700@web.de> <5220F7D7.2000300@web.de> <5220FBD5.6020807@web.de> <20130831160759.GB899703@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Sep 01 15:47:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG80Q-0004ZD-Rl
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 15:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717Ab3IANrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 09:47:51 -0400
Received: from mout.web.de ([212.227.17.12]:55205 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020Ab3IANru (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 09:47:50 -0400
Received: from [192.168.178.41] ([91.3.187.67]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0MC6ZE-1V7MZu3nd2-008pys for <git@vger.kernel.org>;
 Sun, 01 Sep 2013 15:47:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <20130831160759.GB899703@vauxhall.crustytoothpaste.net>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:CMI5aFEr9n8Um1iEV8QVaOZG62QF2JN/e9g1ycLG9NXKBxIgiIP
 /XKIhtZJhkIYuGuGVABn9xm+c8OdSumDu9+ooown0v5XNIrwKL1HekrGO5wboFJsxbD3tXs
 jJT95Gv5ZNSs/e7bKAkOgDn7qRxASWGgdE4q6r7ad/Vl17G9nrh+X7LFk1phoJ3gJjhlyzz
 escjA8pTTrxw/lisyuFdw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233588>

Am 31.08.2013 19:08, schrieb brian m. carlson:
> On Fri, Aug 30, 2013 at 10:08:53PM +0200, Jens Lehmann wrote:
>> Am 30.08.2013 21:51, schrieb Jens Lehmann:
>>> Am 30.08.2013 21:40, schrieb Jens Lehmann:
>>>> Am 29.08.2013 23:23, schrieb Matthieu Moy:
>>>>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>>>>
>>>>>> Am 29.08.2013 15:05, schrieb Matthieu Moy:
>>>>> Because of the missing quotes around $for_status, it seems the test is
>>>>> unconditionnaly true:
>>>>>
>>>>> $ test -n t ; echo $?
>>>>> 0
>>>>> $ test -n   ; echo $?
>>>>> 0
>>
>> Right you are, I did not notice the missing "" in my review. Looks like
>> we also should add one or more tests making sure that submodule summary
>> and status never honor the ignore settings.
> 
> How do we want to handle this?  I can send a reroll and include some
> new tests, but if this code is going away, then there's no point.

A reroll would be great, as I think your patch is a bugfix that should
go in rather soonish no matter how we continue with the comment signs.
Two new tests (one for submodule summary and one for submodule status)
with both the global ignore setting and a submodule specific one set
to "all" showing no impact on the output would suffice (and trigger the
then also fixed missing "" bug ;-).
