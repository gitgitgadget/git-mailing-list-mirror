From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 3/4] dir: introduce file_size() to check the size of file
Date: Sun, 12 Jun 2016 12:44:38 +0200
Message-ID: <3db60187-4b44-85b2-f714-f836e3c3bc6e@web.de>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-3-pranit.bauva@gmail.com>
 <CAPig+cTgnp3tm_S7ybDBiGfesw9mh3J4_OtEV7timnsgL0AGjA@mail.gmail.com>
 <CAFZEwPPWMdOahMP4f0=Lm_n+ZmEtGHg=zHaZAyQjSf9oL8X2ew@mail.gmail.com>
 <5757D49A.304@web.de>
 <CAFZEwPMiyHqFa0+Z1EAfwG4APcCjJ+1qBeSHjyuOhc6QMb3hLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jun 12 12:44:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC2t0-00053R-8o
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbcFLKoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2016 06:44:54 -0400
Received: from mout.web.de ([212.227.17.12]:57614 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbcFLKox (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:44:53 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Mgwhg-1aq6BA0zku-00M5Rg; Sun, 12 Jun 2016 12:44:44
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
In-Reply-To: <CAFZEwPMiyHqFa0+Z1EAfwG4APcCjJ+1qBeSHjyuOhc6QMb3hLA@mail.gmail.com>
X-Provags-ID: V03:K0:1TvOmDdj/Ow29KX2dxk1jXr0thBiEebazHViG/hLMvzVgkkVpcH
 gfVuVWm9E1Z59RgjXWE8LKlcbX66aUh7Iib2hckSOzUVUeMBeiZlo9hTxDQ7iY4fwwIWu2y
 H0tXgS4so4aXZxtm6nvrRRyl+c6LK8qZ+GJNPkI9capnxEpRoJhjS2bt8KHDMf+kkD/7PEY
 VvIF884AcCTIKAHyT367g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zh39rMDQE8Y=:tXgiCubKIEeevG7GRBm/qy
 BCBxEZNmKxULQK4BwWnY/++7k/O6b62TfqpHL9yS91E73CIl4LKNLNo+du04tKGE3OyJxDv9i
 vCvvDS5OUwvYi/XsWnxh/mrmYxLL7D56U04keQ1M9Nht8poJsWhtnO6ht7vMpsX14kMyzLyv6
 H9ZD19si94uRAL4mmnWhyVj+fD+m/eB5v3pS/bLbxWHs5+SsTaBxROytZp34Y0BjHj0YIH9Kc
 dCTKLD+6RfSEGzqWOB8wfrO6BN7tJWy2gUF2/GNs9BYj8xgpGqwx3wgV0IgKXVJ4lVDXDyhex
 j+xrewFkMJiVL2DcqSUJIafADTlz7+/4brar6adSNFpPecRWB/hzytH8AfdTxPp/8oe8G7uEU
 RsWm7qxc9Jvh4WiKLRRNvZGs5V7fxqP5zAvi02K3aYT1HL+xibXCyvUvi3LQk0XnZ6puXPOpx
 /9uYRtKaUcyBawAtJtC39Ag4m97ts63Yo0FUqFmY5wFqjaV9INxhBmyN1ltaG6sNq2KPNYBDF
 H1b/fgYGHm5vm39ko2yeVqCX1PbDUjRQNqn1WIWisveBwTGXUdOL9GGWcA8ufFomm2a7Ws1Oa
 WIPSiyuOFW1xs8bVHQWuFtNXVi5YLx0tCx+DZpA/SedK0OjvXRVAYM9ttqSXIZfui9RmcIRCR
 hkBaQ6ukNXhrMyt2iAYWSDCFe837MTSqn3W2W93lzcMu4Sh8NCLwhiVb2L+dxlELjd4SU7dTT
 nZxvYBUwPmN4G3z5jW8wHr3tvTErYZG55U1d0i+qwBsx/+4Og0iabhlU5gvM46cEV1pDz94E 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297105>

>> So what I understand, you want something like this:
>>
>> +ssize_t file_size_not_zero(const char *filename)
>> +{
>> +       struct stat st;
>> +       if (stat(filename, &st) < 0)
>> +               return -1;
>> +       return !!st.st_size);
>> +}
> 
> For the purpose of bisect_reset(), Yes. BTW a similar function exist
> in builtin/am.c with the name is_empty_file(). But as Christian points
> out file_size() could help to refactor other parts of code.
> 

Please allow one or more late comments:
If is_empty_file() does what you need, then it can be moved into wrapper.c
and simply be re-used in your code.

If you want to introduce a new function, that can be used for other refactoring,
then the whole thing would ideally go into a single commit,
or into a single series.
That may probably be out of the scope for your current efforts ?

What really makes me concern is the mixture of signed - and unsigned:
ssize_t file_size(const char *filename)
+{
+       struct stat st;
+       if (stat(filename, &st) < 0)
+               return -1;
+       return xsize_t(st.st_size);
+}

To my understanding a file size is either 0, or a positive integer.
Returning -1 is of course impossible with a positive integer.

So either the function is changed like this:

int file_size(const char *filename, size_t *len)
+{
+       struct stat st;
+       if (stat(filename, &st) < 0)
+               return -1;
+       *len = xsize_t(st.st_size);
+       return 0;
+}

Or, if that works for you:

size_t file_size(const char *filename)
+{
+       struct stat st;
+       if (stat(filename, &st) < 0)
+               return 0;
+       return xsize_t(st.st_size);
+}

Or, more git-ish:

size_t file_size(const char *filename)
+{
+       struct stat st;
+       if (stat(filename, &st))
+               return 0;
+       return xsize_t(st.st_size);
+}

(And then builtin/am.c  can be changed to use the new function.

 
