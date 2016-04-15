From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] fsck: detect and warn a commit with embedded NUL
Date: Fri, 15 Apr 2016 15:43:52 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604151541580.2967@virtualbox>
References: <20160414180709.28968-1-gitster@pobox.com> <20160414180709.28968-2-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 15:44:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar42g-0004YT-5G
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 15:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbcDONoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 09:44:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:60198 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443AbcDONoB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 09:44:01 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MVIva-1bGo7w2qJa-00YlUz; Fri, 15 Apr 2016 15:43:54
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160414180709.28968-2-gitster@pobox.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:XH03Y+W8SbMh6LLsPOORwP8LgRh/+no2oleXc06cqkrd5mw7rP9
 ax3tlaGbv0w01V60IKn380ifIVX9QcxVQ/12Iiiwv+3awuoh2cElGNMeWdxWzwTRhxndGqJ
 8CFczsJiRCbn0dLkdQLtD9MahwCD3SGC/Jk15uRGLW9Lm+MPRGaazU6yYG/5pe+8Z9R4v9I
 EV/IfFQHoPIF2hHstmWfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AFLWU447jrI=:DPivbkmu4EMSUuZQSCtah7
 p2Cz2580uAT6rZreivDYfBAFiYs5dXI0eGb02Eyujbe/gvePaBEZ58YMlivlNGX3MLZevsImE
 R0cUJZ9QkUxFqnrnmEzn7nPNjQ2QiUXvgNprnbec560gQyuQUwqImLSpa5FaBTjACIxV+xkbd
 OXi2ZXxVVQhiCTJ5zk20EzU1xuIgBI3hQieNNuTMZ9oEpy1baQmb5IBrejzwcBMrUzK2/PaSz
 oak4LKGA3GxVuNXdOSg+MzA++v096Pc7d9w5c6zUmgSTpjJF4zpPtUAX84BkoIr5wIzxJTUwW
 OyBpEvBHYleyR5yAZZUampxs5aNGjuguZinTIdnrPrnGZmDCaCqBhcP0/jffdHVV+x9yL3kSQ
 kFDBm8YFXfoU18s58ByySx0hCSsJweFdCw41nFO0EfCrCN2UkvZDfuDwOqR+KUEQM4btinvZL
 tiTJLNtLPt3/lcsWq0ZhA27EgffgwsEFY1MYhS+jSRYRoZ357GJs6buq4QrYwinzJvaJyIsL7
 KEqjYsmKH9db08z3Lr6llmquwrMK7aIE/Sf9juCRvDpy7ju88aVUhof0GKcS45tewESZRTiOj
 3a8BFGfllKK5Jbjzeqqjdu8Sj6kX3Ag7q4tGoNKD3//uxzrOv5nzodG6yliNLhFNrXiuNOEpP
 DAZ9MLuD4cqaNy+R/2BgYc2l+r6en05iUVOtdQZ2oDD57tt5wuoF+381RNdh5Gw48dfrMdSkq
 fAVOaXHy7AWKrsKBGFmTr8BPR7FBTT4DbFwaK5qbfh5+FYXApahh2k2g39WUh+9RIN9cc9Ou 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291605>

Hi Junio,

On Thu, 14 Apr 2016, Junio C Hamano wrote:

> Even though a Git commit object is designed to be capable of storing
> any binary data as its payload, in practice people use it to describe
> the changes in textual form, and tools like "git log" are designed to
> treat the payload as text.
> 
> Detect and warn when we see any commit object with a NUL byte in
> it.
> 
> Note that a NUL byte in the header part is already detected as a
> grave error.  This change is purely about the message part.

IIRC there was some discussion going on about this, and since it was 1)
legal and 2) not checked before, I decided not to make this an error.

But of course it is good to introduce a warning!

Thank you,
Dscho
