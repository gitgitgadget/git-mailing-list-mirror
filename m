From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v8] ls-files: Add eol diagnostics
Date: Wed, 30 Dec 2015 16:27:30 +0100
Message-ID: <5683F7E2.3070503@web.de>
References: <5683D49D.2010509@web.de> <5683E8B4.7040005@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 16:27:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEIfE-0001ur-ON
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 16:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbbL3P1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 10:27:44 -0500
Received: from mout.web.de ([212.227.17.12]:63091 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755039AbbL3P1k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 10:27:40 -0500
Received: from [192.168.2.107] ([79.223.108.227]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MF3jD-1aSpO02uQV-00GFo7; Wed, 30 Dec 2015 16:27:35
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.0
In-Reply-To: <5683E8B4.7040005@ramsayjones.plus.com>
X-Provags-ID: V03:K0:rrky0bcRaY3QAyijD36hAUKf/yJE1gb9bi4cMOvomf/J9qU+gNY
 nt7dR2F90dxk3r7C1/RVKGPtmSe3i/RrRxM+RLR7wC9PenCxW6XvrITzrQuYld3/PEH/Cb7
 2qzsChRSXL5Yrf/OzF6Fj9XIwahHnoD1FFLtAa6moyyfl9lLW2piF/22a/0hWOfdKGMKPVA
 SMkwpftmbSfJaYOBqwZ1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bbXRLcbO0G8=:6ln74y6gOBXchX7WKXdKkj
 /ASSsZcug0k305tb1Q+1ZJRVZnTL+nFKPjsWcI1+FG6LmEe3XYfFzT/rXnYhUkmfC8UBzIALH
 boqJ5rD7asu1vteQnz0/e9cEsQSyLX7j0zR3AYN+1mIeNoMw/XztoXFzyGO48GeybZMegSXNd
 svJ6MKal2H84tdsFZqmqsdZpJG2Y+l3yi6/xhPYsnnoSm3T+hr6lmffIDjfnHxq8ItJN2KGr8
 fkx6WjMEcc6GnQYOR8ly0xEfrXwU1h8DrTtWxymOUm3spQNZA1caI8KAdE/SnLAKbJzR3+R7b
 wC0cRj1D7PIaaZm357QjNVVolrLiSMcOBExNUIOL/mhUVrRH8gyvKscINOcmaLlm4ANX4I/lv
 zeWmzpazjq6anOPNaCkYYMTYHb9fn8+hjyULDLVYAJXpA0ow+DBrxe9vCDnXk6W4VHRzctdgq
 UowRkD3HBivsOD4LZJp5Muwj9WS9NLXHl7Jjzd/fv0WPydIsm8HHFByvUl5P9OTCFxe0yXD2d
 tisrXkyoj94Jj4YanqBhDtXD81Fr9j6hFXmBWT5rX0EV6LITS0usi2OaL8gySPPAchDwdv3LO
 +9kstf2w4+QSdzIm91EpxWDaOoaWOIgMCKg32m9w/JiS4YnMdoz23XQMrBCiBxX02sMTxWqWl
 qYDJaaHyBwRG4x1uSz4QzHbT/lPHUeFWzkHIqRvLXJBrAtC4wBRi71/VnbkAzlYwarxw+qBO5
 FXfwM2agiYMRFsiY6grw57fzftTmnR+oy5W5PHuCeHcUUTvjCy2kmDxbwSPBMlLmk8xDCmSU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283187>

>> "binary"       binary file
>> "text-no-eol"  text file without any EOL
>> "text-lf"      text file with LF
>> "text-crlf"    text file with CRLF
>> "text-crlf-lf" text file with mixed line endings.

> If you prefer to have 'text' in there somewhere, how about:
> 
>    binary, text-none, text-lf, text-crlf, text-mixed.

text-none could be OK.

text-mixed as well, but the you can't run
"git ls-files | grep i/text-crlf"
any more to get an impression if there are un-normalized files,
which may, may, need normalization.

Thanks for the reminder,
lets wait a couple of days and see if there are more voices.
