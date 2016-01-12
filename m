From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v10] ls-files: add eol diagnostics
Date: Tue, 12 Jan 2016 07:25:23 +0100
Message-ID: <56949C53.5030605@web.de>
References: <1452446203-20693-1-git-send-email-tboegi@web.de> <xmqq8u3wxb0i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Tue Jan 12 07:26:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIsPJ-0002Nk-FS
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 07:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbcALGZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 01:25:46 -0500
Received: from mout.web.de ([212.227.15.14]:56798 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbcALGZl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 01:25:41 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0M52ju-1ZyQnC3N2U-00zE4l; Tue, 12 Jan 2016 07:25:32
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqq8u3wxb0i.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:5NhS43MgM/TiVTNkAaJv+rZY+s4d3/LFJfSKWMY1TWGKXYqhHYH
 iYdlh6XwATdLXiLzgH6q72Um8JF/PB7qcoCZnPGiLBc3Zq+lFUZ5wi1dsfdPlD/JwhhJ4/u
 JxG9nePOALLQ2NjrXertBC1fkg38zehOdIW9q2GAhm65VV0da2FDpcvhsp6J3Q6CYJA7XcF
 xPrqUZRQCUkzVVNhscePg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eLdOohVVR90=:E/p6UnUyQC/h1qop5VFg54
 qVMoMLezUvnLq8RU7ZTq77RkpkKvi9fSn1oziSHSdEtmQv6wkikpVSRPybuDwrttQy5W37sK9
 8fxYMlP80KPy4MyBWK+vFEG9C53as6LQK3Xr1UmBxgO4UWwOGJEK5SEzVFjamQI2Hk6i2QyKr
 DDoYbInJBsMhGBFW3Q17VxiSaRLoMOK4V1BcXUetGwRaD4zMZ0ZSC39A+zSuitgkxJIGBH/lH
 UDa1jeP0oFkedoYPe8xpD4oJFO55yr5bUiVHz4PD8KciBrJyJQuuf+kYOb/YSQwCPVUzICmsW
 3ysZUN4Jy9HtPfpYBNnf9ViL6pL7bk184Cmz+ZkpxamBd1LtyIcy+G5+hj5jvGuBsyxwRtD0H
 x1keAc6GWUPZJFI3GJOKNqNEffUI44Q4dcmgDZ7djNIrlINDhVVFGBmNMj/adFaYqklw/UkVT
 /0oLFFBPnF847boVvKlTSMBV/vZuUjvt+txjmBf37xzOKl/0TgQmp8mKes3SQeLQOc9X/wSMq
 8HYRAfgMLlvuRFPFii2zPM52HnaA5jdqQqUGWaWTNWmXJaVTXRO5GqlSI06dYcqQwY8uphIUJ
 ySQr/zjwqkdiJh9VpMOw1vTXehp6wsbEa2S5uniDtk4K5MjqRepnmZSIZIki9/v/jUSLdbxCU
 f0Nov/5qr5h+OElUhIjZdGjbNvKWKILDqvI9xBzuOHHIa0CqvyO5+PoOzwDQsbCjhUPK0Y6ox
 xLbzuUlr9UK55solopPxj9A+TzbMKaQoFprKzy+ukgcSbRTPaA3bU97ANzDdUdWZFQVECJm7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283768>

On 01/11/2016 06:48 PM, Junio C Hamano wrote:

Thanks for comments
>> +		if (line_terminator == '\n')
>> +			printf("i/%-6s w/%-6s attr/%-9s ", i_txt, w_txt, a_txt);
> Can we do something better than these hard-coded constants?  Why
> can't the "one HT between each" approach be used for both?
v11 will make more clear, that currently "eol=crlf" is the same as "text 
eol=crlf".
The shortest attr is then "", the longest "text eol=crlf".
Using '\t' as a separator makes the output cluttered for a human reader.

When parsing the output, the '\t' is much more convenient (and that's 
what t0027 wil use).
Is there any chance to have a selection between human-friendly and 
script-friendly ?
Would an option -e (eol info using spaces) vs --eol (eol info with TABs) 
make sence ?
