From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/3] "-x" tracing option for tests
Date: Tue, 14 Oct 2014 10:52:30 +0200
Message-ID: <543CE44E.5050009@alum.mit.edu>
References: <20141010060636.GA15057@peff.net> <xmqqd29v4yl1.fsf@gitster.dls.corp.google.com> <20141013210729.GA15969@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 10:52:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdxqU-0002eY-RF
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 10:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbaJNIwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 04:52:38 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45014 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751265AbaJNIwh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Oct 2014 04:52:37 -0400
X-AuditID: 12074414-f79f06d000000daf-7a-543ce44ffec1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.80.03503.F44EC345; Tue, 14 Oct 2014 04:52:31 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96A79.dip0.t-ipconnect.de [79.201.106.121])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9E8qTV8003951
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 14 Oct 2014 04:52:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20141013210729.GA15969@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqOv/xCbE4Nx7a4uuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3Bl7jz5nKpjEXvF14VXmBsbN
	rF2MnBwSAiYSr383MEPYYhIX7q1n62Lk4hASuMwo0XPrOQuEc4FJ4v3za2BVvALaEjOOtoN1
	swioSjw+foMFxGYT0JVY1NPMBGKLCgRIfOh8wAhRLyhxcuYTsBoRAUeJC1uOANkcHMwC4hL9
	/8BMYQEzie5GeZAKIYE6iVfTLoFt4hTQk3j9dw0biM0soC7xZx5EnFlAXmL72znMExgFZiFZ
	MAtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Vro5WaW6KWmlG5ihASuyA7GIyfl
	DjEKcDAq8fAWRNqECLEmlhVX5h5ilORgUhLlnfcAKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	13ghUI43JbGyKrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxWhoNDSYL38GOgRsGi1PTU
	irTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQnMYXAyMVJMUDtLcapJ23uCAxFygK0XqKUZej
	peltL5MQS15+XqqUOK83SJEASFFGaR7cCliaesUoDvSxMO9NkCoeYIqDm/QKaAkT0JLXxdYg
	S0oSEVJSDYw+xuF9eU5RQR3BV6/HuBztmfT4WgrzyqjVlvtbsmTNLfaLiwefq1i36eN/6fs2
	jnrdJtYraydvrp17jbHXyauucg/3lW1N8reKn/HlGDOISagrizjsKApyq7tstXC+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/2014 11:07 PM, Jeff King wrote:
> On Mon, Oct 13, 2014 at 11:24:42AM -0700, Junio C Hamano wrote:
>> [...]
>> Is your plan to reroll the prune-mtime stuff on top of these?  The
>> additional safety those patches would give us is valuable and they
>> are pretty straight-forward---I was hoping to have them in the 2.2
>> release.
> 
> Yes, I've delayed while thinking about the issues that Michael raised.
> There are basically two paths I see:
> 
>   1. These do not solve all problems/races, but are a solid base and
>      sensible path forward for further changes which we can worry about
>      later.
> 
>   2. There is a better way to provide prune safety, and these patches
>      will get in the way of doing that.
> 
> I wanted to make sure we are on path (1) and not path (2). :)

FWIW I think we are on path (1).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
