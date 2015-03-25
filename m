From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH, RFC] checkout: Attempt to checkout submodules
Date: Wed, 25 Mar 2015 21:16:21 +0100
Message-ID: <55131795.1050308@web.de>
References: <1426681643-7516-1-git-send-email-tbsaunde@tbsaunde.org> <xmqqy4msizu1.fsf@gitster.dls.corp.google.com> <20150319201509.GB21536@tsaunders-iceball.corp.tor1.mozilla.com> <xmqq3850it94.fsf@gitster.dls.corp.google.com> <20150320001345.GC21536@tsaunders-iceball.corp.tor1.mozilla.com> <5510712C.5090906@web.de> <20150324183013.GA15658@tsaunders-iceball.corp.tor1.mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 21:16:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yarj9-0006Vx-Jz
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 21:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbbCYUQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 16:16:31 -0400
Received: from mout.web.de ([212.227.17.11]:65100 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058AbbCYUQa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 16:16:30 -0400
Received: from [192.168.178.41] ([79.211.117.156]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LyUkU-1ZWpQu2G7K-015p8u; Wed, 25 Mar 2015 21:16:22
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150324183013.GA15658@tsaunders-iceball.corp.tor1.mozilla.com>
X-Provags-ID: V03:K0:w1jJ5CxNyluMMBmYaoB6AwsyakqcbxnIeH5Mh8qg/i0mL4pUI16
 kfiunvHPxHUSS/YudeC9XNaAJxCcOEfyaCvY8XvktPv8GWqksqV7kyODS5De9xw08N2vrjN
 3It5gIJdYAiIg7JEbBEPh2vJ+0ixMxVHH/08CXUDK64049r2Km0f8+423p5YMZf5cp5mk5w
 Z94Rv+UBsEAw9rG07bNFQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266296>

Am 24.03.2015 um 19:30 schrieb Trevor Saunders:
> On Mon, Mar 23, 2015 at 09:01:48PM +0100, Jens Lehmann wrote:
>> Using -f here is ok when you extend the appropriate verify functions
>> in unpack-trees.c to check that no modifications will be lost (unless
>> the original checkout is used with -f). See the commit 76dbdd62
>> ("submodule: teach unpack_trees() to update submodules") in my github
>> repo at https://github.com/jlehmann/git-submod-enhancements for
>> the basic concept (There is already a fixup! for that a bit further
>> down the branch which handles submodule to file conversion, maybe one
>> or two other changes will be needed when the test suite covers all
>> relevant cases).
>
> ah, I see your already working a more complete solution to this sort of
> issue.  I'll get out of your way then unless you want help.

Help would be very much appreciated. I'm currently separating teaching
the builtin commands to recursively update submodules from my branch to
submit these changes first. The reason for that is not only that there
are current efforts to make pull and am builtin commands, but that we
need an extension to git diff for the scripted commands to work. If you
could help implementing "--ignore-submodules=noupdate" (which would only
ignore changes to those submodules that are not going to be updated)
while I'm working on the builtin commands, that would help a lot. This
would enable the scripted commands (e.g. rebase) to not ignore changes
to submodules that are supposed to be updated (like they still do in
the current version of my branch). And another pair of eyes on code and
tests would also be very good to have.
