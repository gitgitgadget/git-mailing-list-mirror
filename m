From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Tue, 12 May 2015 10:11:42 -0700
Message-ID: <xmqq7fsd201d.fsf@gitster.dls.corp.google.com>
References: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
	<CAGZ79kYjES6DXmvQdmXLAXrKMGrnvQ-vqJuHQU2QxVC4+6M0aA@mail.gmail.com>
	<20150509014152.GA31119@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150509040704.GA31428@peff.net>
	<20150510231110.GA25157@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150511011009.GA21830@peff.net>
	<xmqqmw1bg2dd.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1Aq54dWvxo5JTP4Fqy5u-qhA0LAm3vRrw9=jYg3o_F+g@mail.gmail.com>
	<xmqqfv73f420.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3LzM3uuUzWYS-o6mhtH-x5+-kyGhDvYnv6ZPRTC18C6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Trevor Saunders <tbsaunde@tbsaunde.org>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 19:11:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsDig-0002El-0A
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 19:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932947AbbELRLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 13:11:45 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38691 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932814AbbELRLo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 13:11:44 -0400
Received: by igbhj9 with SMTP id hj9so20839110igb.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QhZq1iD2nXjeApiqnRqB+QPaHSveCncye+QDUTtPiYQ=;
        b=I/btjlXH5XRZARchPrPLWLpCGWOFYSyUHGktCwsiOSeA4L8MpmICJI0AHwSnXmuf4g
         sFRBsV5eFIMeETkHOPIOFRdWKNYijnlIPN8T21ZQ+Sn71xmX/3Y9YO0wUmPsJXu6mgPG
         fyQrtCCi1qBJCSSLby0RtquOiP7jKNkjl519qNy2S+WhfPozwYa3CaS1NGLMZEQQqiYY
         GsZJtv7QBsW/ikh6BRhVtAkaMJ2SEU3E7Wv9CkGMuonyZh3hJJUkj3a+r8mJfukn6Q42
         npNca/+JMBJ1nt6u8qqcwVy7sngw8WxOf6P/NitoE6OedjDeZM9rClX3QWm+fo0EUi+x
         63aA==
X-Received: by 10.50.143.97 with SMTP id sd1mr616334igb.25.1431450703988;
        Tue, 12 May 2015 10:11:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id v4sm12268151ioi.40.2015.05.12.10.11.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 10:11:43 -0700 (PDT)
In-Reply-To: <CAP8UFD3LzM3uuUzWYS-o6mhtH-x5+-kyGhDvYnv6ZPRTC18C6w@mail.gmail.com>
	(Christian Couder's message of "Tue, 12 May 2015 11:21:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268858>

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, May 11, 2015 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> To be bluntly honest, I think the current one is sufficient as a
>> good-enough default.  The first thing I would do after seeing that
>> message is to either "git checkout <commit-object-name>" or "git
>> show <commit-object-name>", and the current full 40-hex output gives
>> me an easier mouse-double-click target than the proposed abbreviated
>> one, so in that sense the original proposal may even be a usability
>> regression.
>
> Yeah, it might also be a regression if some users have scripts that
> depend on the current behavior.
> ...
>> It is tempting to say that the output can be eliminated by always
>> checking out the first-bad-commit (i.e. only when the last answer
>> that led to the first-bad decision was "good", do a "git checkout"
>> of that bad commit), but in a project where a branch switching is
>> not instantaneous, that might be problematic (unless the first step
>> the user would have done is to check it out anyway, of course).
>
> Yeah, and speaking of regressions, elimiting the output might be a
> more serious regression.

I am getting somewhat annoyed by this line of thought.

Who said bisect output is meant to be parseable and be read by
scripts in the first place?  If that were the case, we wouldn't be
having this discussion thread in the first place.
