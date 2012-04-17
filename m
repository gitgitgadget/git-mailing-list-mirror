From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] fetch: Use the remote's ref name to decide how to
 describe new refs.
Date: Tue, 17 Apr 2012 02:57:40 -0500
Message-ID: <20120417075740.GE20017@burratino>
References: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
 <1334614130-31826-1-git-send-email-marcnarc@xiplink.com>
 <1334614130-31826-4-git-send-email-marcnarc@xiplink.com>
 <20120416223429.GA13440@burratino>
 <4F8D2195.9030507@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: marcnarc@xiplink.com, git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Apr 17 09:57:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK3IO-00032P-IH
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 09:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab2DQH5p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 03:57:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36393 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab2DQH5o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 03:57:44 -0400
Received: by iagz16 with SMTP id z16so8596789iag.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 00:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ndIY4BFsdCmlkeTLR24N9qSg7MN5TDPOqGkP10khd6k=;
        b=tai3N303Z8D1DzppFM81TXhqEvtYlg0Wtu3ScbrgYdKd1+MEz5JhfFQmpK7YoFy3Rv
         /XgVSjdYNwpsZd8kCT3Gbi8ZkE9E3fvLxwcHJ0E3JkJxDqCR0bwkhWW5r+81EI3YO76k
         Fd/uKRfCyxigLakJrDouszfgHcjUk1tghqUYOJyBRJZKYI6uFJnVjQEqjYnNO96jzIk5
         5krSaqnscdtYxiqmbq34f3Tp8Isy4wegyB9BAFfiYytwBFxXyDFUMJooZ3N99DA/3L2M
         8StT4vGz7btSjeXXCxk1nTt4tlqasUWtR8crHYTV0kmWDzVgMOOwc1ZgtAusmHEvSQ5m
         AiLA==
Received: by 10.50.153.132 with SMTP id vg4mr8247010igb.2.1334649463664;
        Tue, 17 Apr 2012 00:57:43 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i7sm14434265igq.11.2012.04.17.00.57.42
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 00:57:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F8D2195.9030507@in.waw.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195741>

Zbigniew J=C4=99drzejewski-Szmek wrote:
> On 04/17/2012 12:34 AM, Jonathan Nieder wrote:
>> marcnarc@xiplink.com wrote:

>>> +	echo "Nuts" >> crazy &&
>>> +	git add crazy &&
>>> +	git commit -a -m "descriptive commit" &&
>>> +	git update-ref refs/others/crazy HEAD &&
>>> +	(
>>> +		cd descriptive &&
>>> +		git fetch o 2> actual
>
> redirections should be without spaces between '>' and the filename
> (>>crazy, 2>actual), for portability.

I think you mean for consistency.  A space between the operator and
filename is perfectly portable, though git's tests tend to use a
style without the space.

Thanks,
Jonathan
