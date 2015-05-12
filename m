From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git-pull --tags with no merge candidates case gives confusing
 error message
Date: Tue, 12 May 2015 21:52:05 +0200
Message-ID: <555259E5.4040304@alum.mit.edu>
References: <CACRoPnQvNvBv1_wBzWQH6A8XRvWZ+HURvtkqtgYpwjjNXuCERg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 21:52:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsGE6-00080F-P0
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 21:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbbELTwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 15:52:20 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:46919 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753472AbbELTwR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2015 15:52:17 -0400
X-AuditID: 1207440e-f79bc6d000000c43-0c-555259e7f90f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B7.2A.03139.7E952555; Tue, 12 May 2015 15:52:07 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1C91.dip0.t-ipconnect.de [93.219.28.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4CJq5EJ019960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 12 May 2015 15:52:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CACRoPnQvNvBv1_wBzWQH6A8XRvWZ+HURvtkqtgYpwjjNXuCERg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqPs8MijUYNoSPYuuK91MFg29V5gt
	Wj/cYXJg9tg56y67x8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGd0L+xlK1jGVbH54XqmBsYJ
	HF2MnBwSAiYSbTcvskHYYhIX7q0Hsrk4hAQuM0qsftAPlhASOM8k8XkaM4jNK6AtcejZOlYQ
	m0VAVeLNr7ksIDabgK7Eop5mJhBbVCBIovXaVEaIekGJkzOfgNWICLhKfP3YADaTWUBJov/y
	b7C4sECUxLejOxghdgVIdHfcBbM5BQIlDt+fxApRry7xZ94lZghbXqJ562zmCYwCs5CsmIWk
	bBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI31cjNL9FJTSjcxQkKXbwdj+3qZQ4wC
	HIxKPLwTngWGCrEmlhVX5h5ilORgUhLlldQMChXiS8pPqcxILM6ILyrNSS0+xCjBwawkwrvK
	CCjHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLg3RYB1ChYlJqeWpGW
	mVOCkGbi4AQZziUlUpyal5JalFhakhEPitT4YmCsgqR4gPYaR4LsLS5IzAWKQrSeYlSUEuet
	B5krAJLIKM2DGwtLSK8YxYG+FOYVAmnnASYzuO5XQIOZgAY7xgWADC5JREhJNTBmcrWEbp1r
	/PtpZ2OVl0arz9Q/VWwMK3lzPygethJM0mco2bfAWbt24aQV7z82r5hXeHX7v6apR+S/rYyz
	nNR/QrvqzO6NMk/OHGOfNmm+J3ui0NmsBznmHx41R/h/MY+PX7Ag20vbaeGbyk1y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268875>

On 05/12/2015 07:59 AM, Paul Tan wrote:
> Calling git-pull --tags, and hitting the no merge candidates case,
> currently gives the following error message:
> 
>     It doesn't make sense to pull all tags; you probably meant:
>         git fetch --tags
> 
> [...]
> Given that as of c5a84e9 (fetch --tags: fetch tags *in addition to*
> other stuff, 2013-10-30), git-pull --tags will fetch tags in addition
> to the configured refspecs, so if there are no merge candidates, it
> would not be because --tags was specified on the command line.
> 
> As such, I wonder if the error message should be removed, since it
> conceals the actual reason of why there are no merge candidates.
> Unless there is a reason why this special error message was kept?

Thanks for the bug report and the careful analysis.

I never use pull so I'm not really acquainted with its semantics. But it
seems to me that when you remove the special "--tags" error message, you
might also have to adjust the logic later in the function that looks at
"$#". Specifically, unless the presence of a "--tags" option can provide
candidates for merging, then in "[ $# -gt 1 ]", "$#" might need to be
changed to "the number of arguments *not including --tags arguments*".

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
