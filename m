From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v8 0/9] connect: various cleanups
Date: Fri, 27 May 2016 16:24:20 +0200
Message-ID: <a6f4bf06-a52b-dcdf-9407-0c03b8b1dfe1@web.de>
References: <20160527022756.22904-1-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tboegi@web.de
To: Mike Hommey <mh@glandium.org>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 27 16:24:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Ih2-00066V-N7
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 16:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245AbcE0OYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 10:24:48 -0400
Received: from mout.web.de ([212.227.15.4]:65482 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbcE0OYr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 10:24:47 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MMFFF-1b9r3K1pHx-007z73; Fri, 27 May 2016 16:24:23
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.0
In-Reply-To: <20160527022756.22904-1-mh@glandium.org>
X-Provags-ID: V03:K0:ORReHgVwd1tDZ9Uewk5Ho0giSFW0mRUlSashvAvV2+3odzZ3HBD
 +fRaJ2n99tVT1e4lKIWrSoBAquyGanUh6ksqIVVTYdgrj50xS6lCIf0qX9vFy7HagTZEzEV
 q6mXBxuQSVrviUk2w1LFLuFgLrYoZg7Qn3AJ+WhWtWnvZbgtDCH6C+WkiAa1MFfHFar+WnX
 RA71CVOI13UXgerVNDskw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a3gIuzlvAfI=:lhcX2q0dZfRFK8vq4wwXXo
 gRYsjYwkpVunkbgpcYXYpd4oYVS9j2cjNHT3u3RcYf7d9ZBMCUv52kd74Momyn2LED8CO7vqb
 FDAYdamcNplVvyKT6IR1I21o8WR+FXCmStf7SvXI77Zg8bIRgIWHuI/DEJLSH6i1A5lMjmvrT
 nf9BqtncFv3QIr5xLUCWAhkefXx1h2Clipg+cpHukXA5oZVIvxO6T9t3y/dbRUByr2uWVC9SK
 rF7FEauu5xAffpuliH38yVYY/LaS3DMMkDAeYbPahAGLc+YVBXWg7ictCICOYz/JKXiooVNsk
 V0sULIGXJI/p3hXaezqaIYEAloBypwOu8iCTb/wbw8YSY/Qo3fIxOVAmQOIsBBpx2gHe1yxQx
 ahpbBF/emlMhbdyPg6YHX+DgXq+0b2ST7yePtxT5Trd3lS83Ui6Hebgi5FlZfJTvlemXC23bt
 495HcGdgnrGCTTfQz6MxhQavrnH5x6HinKzZS4tEPBOf3xVOxnYM5xpM2x8VwljoSO+99iGCt
 gmWoJsRJJTpOI8B8PtG/jQ9JLcLrSoYhIiHbL5jU9gsh6VzAEFmwEgeqsEgqqSDewCdp+3rKd
 zZfqR+eig1K+bDlvhCgZy7AnHwcrShCRHHQfEdp3n3gYLqlM4SUbp/fEtk5uIyw/nfNPa8l75
 7L7xgmUMetW4ogjzaNoRu4e4BtMtuYwHoTpWpINCaA4Xsyailtp1ouy3/OjpikBXvaLKVYbHE
 YVZg7vjDLqmSx8pisxb+7b2hkH6VMIrwUOURHDOaCY9m/Vy7258SnpZYlMTcKzX3OHiKuwKT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295757>

On 27.05.16 04:27, Mike Hommey wrote:
> Changes from v7:
> - Fixed comments.
> 
> Mike Hommey (9):
>   connect: document why we sometimes call get_port after
>     get_host_and_port
>   connect: call get_host_and_port() earlier
>   connect: re-derive a host:port string from the separate host and port
>     variables
>   connect: make parse_connect_url() return separated host and port
>   connect: group CONNECT_DIAG_URL handling code
>   connect: make parse_connect_url() return the user part of the url as a
>     separate value
>   connect: change the --diag-url output to separate user and host
>   connect: actively reject git:// urls with a user part
>   connect: move ssh command line preparation to a separate function
> 
>  connect.c             | 235 +++++++++++++++++++++++++++++---------------------
>  t/t5500-fetch-pack.sh |  42 ++++++---
>  2 files changed, 170 insertions(+), 107 deletions(-)
> 
Is the whole series somewhere on a public repo ?
No major remarks so far, if possible, I would like
to have a look at the resulting connect.c
