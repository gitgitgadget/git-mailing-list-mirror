From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] push: add recurseSubmodules config option
Date: Mon, 16 Nov 2015 20:05:42 +0100
Message-ID: <564A2906.7010902@web.de>
References: <1447680294-13395-1-git-send-email-mac@mcrowe.com>
 <CAGZ79kacpWFFWiE-KjwEQZC+3PZw2MrpsgQWLJyS82X5LF+Lqw@mail.gmail.com>
 <20151116183106.GA31731@mcrowe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Mike Crowe <mac@mcrowe.com>, Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 20:05:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyP6C-0004iD-FA
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 20:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbbKPTFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 14:05:52 -0500
Received: from mout.web.de ([212.227.15.14]:58689 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbbKPTFv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 14:05:51 -0500
Received: from [192.168.178.41] ([79.211.113.40]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MIvJx-1ZwT9i1Vu5-002VkR; Mon, 16 Nov 2015 20:05:43
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <20151116183106.GA31731@mcrowe.com>
X-Provags-ID: V03:K0:h9J0z5pl4H3mVWDbaDlOeU8QZ9mfhCWVsX3EdDDccmMzpxqie24
 XsIJWK9gKAeKwlv6SGZCwiO9Ph5g6+6wN2D74/VS50Eq+l+jyrt6Ko3WntJlcYh1rQDp3fJ
 UFS3tLT1iRrPhwOWBtO6h5Z4l8wI7hYxOptjLrzB4Bo4eGzypfjPCn2d0uZHiX086Ub9JXa
 rR87ayxJntKpWSWJCv6SQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ME1WEKQOmPo=:zv4nk6QkNCWLoRYmLVqHGq
 U/5TYJDsLOhCZBmqOjagKfvcb3aD6YBS++VCflIOEfCmJJqWLGBfoK8PXJpQHzu5u/HptAcCv
 J309vq8yiD7JJ6MwubkLTZ5N/QrRocDafWBHbqSaspJmnnt4+a2tDcHu26yLigLBmQMlgXQdp
 ApjXMcVqfSy770Y4IYoiiigiqw0cxHnlj55efBbp3qnNls2gop7MqHD4G71JcJo5lWK5Rjyr1
 ec4qqo9MsOrQfb9HiW49yDENuTjWzUs5gMzUDrrh6A8oWn2a0U04BxLkyVGEcPWz3MJsh2q9w
 32otjdjadRp3BxiJEtVArCLfyB3q1mP8FKXU20Dfl1376q1OFLqhb5ztjja8CWP+nxXDoC61Z
 w8BT8mCK8x3lYQxXdKX3x1ytUCwEqa9NYfARyQHLkPnx0scptv5cczcktLf6tpU0aSPaLxhdM
 HAMRhHSensCrOPGvXJakLBL/pE2ula6ouRHN4wPJPpdL1/QYRbn+7ZRqqMZ5/FI02elsm38ph
 xutitoqVT9LL2ZWMYjLBiaX+fHySy5WbtuRZB/NE8550flJFgG1Gyq+eCVwYqKG8d+eGIAFyX
 F7wyRsuHC5942eI6oT6SKk2oVafSoMrzOMggR/flUuskOLQuXOTtG1whO7X5Y7J/GLsoUb3ip
 Bz3GJJn1tJh1aNyobP5ATB+bbHQaBI9bDDuHEYDHAJAeN4ebn17mQfdL3uNyZ4dU3cVPyLqlu
 Mr8Q28TxmF3S8XZOStKaRoqJ6SuFBN8lMT1Xd/oq9nt96L0fG2kU8ajG+C0Xp+sGljY2jtzq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281353>

Am 16.11.2015 um 19:31 schrieb Mike Crowe:
> On Monday 16 November 2015 at 10:15:24 -0800, Stefan Beller wrote:
>> The code itself looks good to me, one nit in the tests though.
>>
>>> @@ -79,6 +87,119 @@ test_expect_success 'push succeeds after commit was pushed to remote' '
>>>          )
>>>   '
>>>
>>> +test_expect_success 'push succeeds if submodule commit not on remote but using on-demand on command line' '
>>> +       (
>>> +               cd work/gar/bage &&
>>> +               >recurse-on-demand-on-command-line &&
>>> +               git add recurse-on-demand-on-command-line &&
>>> +               git commit -m "Recurse on-demand on command line junk"
>>> +       ) &&
>>> +       (
>>> +               cd work &&
>>> +               git add gar/bage &&
>>> +               git commit -m "Recurse on-demand on command line for gar/bage" &&
>>> +               git push --recurse-submodules=on-demand ../pub.git master &&
>>> +               # Check that the supermodule commit got there
>>> +               git fetch ../pub.git &&
>>> +               git diff --quiet FETCH_HEAD master
>>
>> Missing && chain here.
>
> Oh, well spotted! I'll provide an updated version.

Looking good for me too!

Cool, another issue from my Wiki that's being worked on!
