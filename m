From: Stefan Beller <sbeller@google.com>
Subject: Re: publish from certain commit onward, keeping earlier history
 private, but provable
Date: Wed, 9 Dec 2015 14:29:12 -0800
Message-ID: <CAGZ79kYv0qJ==n3TCxTeNkenzKn5msRtR1jAiKEy1mECwUaAuA@mail.gmail.com>
References: <35583CFA-3BEE-4844-9F85-ED73A412A97F@joernhees.de>
	<20151209222041.GB21751@sigill.intra.peff.net>
	<20151209222412.GC21751@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?J=C3=B6rn_Hees?= <dev@joernhees.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 09 23:29:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6nEd-0006jS-TB
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 23:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbbLIW3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 17:29:15 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35736 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbbLIW3N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 17:29:13 -0500
Received: by mail-ig0-f173.google.com with SMTP id su19so545444igc.0
        for <git@vger.kernel.org>; Wed, 09 Dec 2015 14:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6FP6Z+rzFg+z8pj8kelCLp6CDxn0OqZvCVIlUoiwSRc=;
        b=CeKjcTAnK8IQlsLfyreQLDdL2z63mQbDQVDJLV+3h1lSPebtleEya7S33rzlspFqSf
         QFtQIQdvUp7lGcr8cE/+1g7kpiTZtsaoYcPBwE2ikfA80Pdhx6+B84NSMDlsHaPCKEdB
         iwyxK7OP7xPf71Ei8rkqUSlFXb5D6O90G+b7HL2ZYgTBoUPk2QmOBL+QPxSLZU/Pe2zA
         zZ7bfcZ6gD6pPv/YtPByaUkd+TUpevtBqjVS98Ns5UP/wrvEwyP/cHJxwiELpFrdJjaF
         6kniewR0oKKK/lG592GuiBzCVDrG54/ovdCTB9iuzudH0HlFhFrEO9MKu0pXg+lQoX4Z
         g36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6FP6Z+rzFg+z8pj8kelCLp6CDxn0OqZvCVIlUoiwSRc=;
        b=h15P/wzDXJwSPh2zn4e7pQL2plMrlM9fnEMNPAuopjgCswuxxzLPsqrSjtEwxraSX7
         KGOa/XqGBGsjxlLj2Pz0xV3hjrvm6j11h7ihDWEOn5aFam3PUKBEpMIuJYvcLc+7mTg4
         /AtNcnmyPwlGvGyWS4qRMN7oJYP3/et3pXYFVRqkARpJ2JnRjBtuBRz+7OENZoOI2yYp
         Nn0hKOncRZpsJmrZyjPait+bLcpOW/5rL/8T6NYDqp//0uKVaiTBBzj0NCqPq50saPlP
         DA6c/j4lmeivRZ4N1lPk77z9NuBso77QlhqEGGXNFUQVMKc1N81E5xK81+achMsH0Fmg
         yhAA==
X-Gm-Message-State: ALoCoQmQLnj9fbO7QOHVG4FrGmIOWvPtFjdCf7KR344ocXPCrqqHcO7P6gkW4L9ZotxkScnblNvIscNOuIEz6SZO3Ywll7AaJOR80k+bQVz1Wb4Ek8F0xhI=
X-Received: by 10.50.20.8 with SMTP id j8mr24811305ige.94.1449700152899; Wed,
 09 Dec 2015 14:29:12 -0800 (PST)
Received: by 10.107.19.26 with HTTP; Wed, 9 Dec 2015 14:29:12 -0800 (PST)
In-Reply-To: <20151209222412.GC21751@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282203>

On Wed, Dec 9, 2015 at 2:24 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Dec 09, 2015 at 05:20:41PM -0500, Jeff King wrote:
>
>> Of course that is a bitter pill to swallow if you have reasons for
>> wanting to use the old sha1s. E.g., you have internal development
>> proceeding against the old tree and want to share a truncated version
>> with the public.
>
> After re-reading your email, it looks like your use case is just to be
> able to later prove the existence of the original history. You could
> that by mentioning the original "C" in your truncated "D", but in a way
> that git does not traverse reachability. For instance, amend D's commit
> message to say:
>
>   This is based on earlier, unpublished work going up to commit C.
>
> Then retain C for yourself, and show it only to those you want to prove
> its contents to.

I'd rather keep D for yourself and create a D' which is D just without
parent and
the note above, such that the tree of D and parts of the commit message
is obvious by looking at D'. All that is secret is Ds parent and the commit
information such as exact date. (committer could be guessed easily)

>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
