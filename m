From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] general style: replaces memcmp() with starts_with()
Date: Thu, 13 Mar 2014 17:05:47 +0100
Message-ID: <5321D75B.5020600@alum.mit.edu>
References: <1394631854-11208-1-git-send-email-quintus.public@gmail.com> <CACsJy8DUhqn_ESzT-KpAdrWvWcLbPUiXDmBZXu7UtHU+M0GLgw@mail.gmail.com> <CALs4jVFM58Yiku4B8NrVeac0Hmt5YsPNYb_EjY6bOr=JO6pP+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Quint Guvernator <quintus.public@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 17:06:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO88q-000159-Hq
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 17:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbaCMQFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 12:05:51 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55626 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752289AbaCMQFu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Mar 2014 12:05:50 -0400
X-AuditID: 12074413-f79076d000002d17-c2-5321d75d97fa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 71.92.11543.D57D1235; Thu, 13 Mar 2014 12:05:49 -0400 (EDT)
Received: from [192.168.69.148] (p57A24737.dip0.t-ipconnect.de [87.162.71.55])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2DG5lE5004420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 13 Mar 2014 12:05:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CALs4jVFM58Yiku4B8NrVeac0Hmt5YsPNYb_EjY6bOr=JO6pP+A@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqBt7XTHY4McWU4uuK91MFt1T3jJa
	vOvuZ3Zg9tg56y67x+dNcgFMUdw2SYklZcGZ6Xn6dgncGdvnnGItWMlacWTiV/YGxhUsXYyc
	HBICJhKzzkxkhbDFJC7cW8/WxcjFISRwmVHi8+tP7BDOOSaJH719YFW8AtoSn85+BetmEVCV
	ePjhFjuIzSagK7Gop5kJxBYVCJZYffkBC0S9oMTJmU/AbBEBfYkpe+aygdjMAl4SU9ZeZgSx
	hQU8JLp/LWcGsYUELjFKfLmv1sXIwcEpECixeRUviCkhIC7R0xgEYjILqEusnycEMUReYvvb
	OcwTGAVnIdk1C6FqFpKqBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfVyM0v0UlNKNzFC
	glh4B+Ouk3KHGAU4GJV4eGccVQwWYk0sK67MPcQoycGkJMrLfgEoxJeUn1KZkVicEV9UmpNa
	fIhRgoNZSYRX5jJQjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwfv3
	KlCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCh244uB0QuS4gHam34NZG9xQWIu
	UBSi9RSjLsfttl+fGIVY8vLzUqXEeX+C7BAAKcoozYNbAUtZrxjFgT4W5i0HGcUDTHdwk14B
	LWECWvIjQB5kSUkiQkqqgXGJ7KOpJZwH1nKxaGuFPnojkdVmarjWJMRoWtFlna7X2exTzaUr
	wpUWp67uKIqYdn1LpKOjyq6wpc/m1Qa8rI6J+Zq1LqFIakaE7dOaXYcWpkw4uG7v 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244034>

On 03/12/2014 03:06 PM, Quint Guvernator wrote:
> 2014-03-12 9:51 GMT-04:00 Duy Nguyen <pclouds@gmail.com>:
>> starts_with(..) == !memcmp(...). So
>> you need to negate every replacement.
> 
> My apologies--it doesn't look like the tests caught it either. I will
> fix this and submit a new patch.

It is very, very unlikely that you inverted the sense of dozens of tests
throughout the Git code base and the tests ran correctly.  I rather
think that you made a mistake when testing.  You should double- and
triple-check that you really ran the tests and ran them correctly.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
