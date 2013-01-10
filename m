From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: t7400 broken on pu (Mac OS X)
Date: Thu, 10 Jan 2013 20:06:45 +0100
Message-ID: <50EF1145.6020002@web.de>
References: <50EDBA37.30205@web.de> <20130110062838.GA11634@duynguyen-vnpc.dek-tpc.internal> <7v38y83ooo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 20:07:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtNTA-0002Cl-5F
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 20:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130Ab3AJTGz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2013 14:06:55 -0500
Received: from mout.web.de ([212.227.17.11]:61315 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753679Ab3AJTGz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 14:06:55 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MFLB2-1TntpL278u-00ENuj; Thu, 10 Jan 2013 20:06:48
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7v38y83ooo.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:Ghmm/ZIICGKDbUnoULv+aaSo61vHNSO0ifGdOZQi4LU
 R8j8YBbS3utciFDkws/Wdj+amk03PhSVW8BZOiUQuZnDr7PVGg
 OJQUAPffbPVxRYsXRtniJXjEMEScWM2n4W+/1m4eLTf1v1Lsh3
 SINxxctIaPVzWa9ANLmXKFy8LcicScc8HGGIJ1+E0CP82RdhFO
 2oT2i7kjvWI3oqjZr8t3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213148>

On 10.01.13 18:58, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Jan 09, 2013 at 07:43:03PM +0100, Torsten B=C3=B6gershausen =
wrote:
>>> The current pu fails on Mac OS, case insensitive FS.
>>>
>>>
>>> Bisecting points out
>>> commit 3f28e4fafc046284657945798d71c57608bee479
>>> [snip]
>>> Date:   Sun Jan 6 13:21:07 2013 +0700
>>>
>>>     Convert add_files_to_cache to take struct pathspec
>>>
>> I can reproduce it by setting core.ignorecase to true. There is a bu=
g
>> that I overlooked. Can you verify if this throw-away patch fixes it
>> for you? A proper fix will be in the reroll later.
> I can see why it is wrong to let pathspec.raw be rewritten without
> making matching change to the containing pathspec, but I find it
> strange why it matters only on case-insensitive codepath.
>
> I agree with the "Hack" comment that the canonicalization should be
> done at a higher level upfront.  Then ls-files does not need its own
> strip_trailing_slash_from_submodules(), and check_path_for_gitlink()
> can (and should---the callers of "check_anything" would not expect
> the function to change things) stop rewriting its parameter.
>
> Thanks for a quick response.
>
The patch fixes t7400.
Thanks from my side as well
/Torsten
