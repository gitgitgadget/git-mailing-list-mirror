From: Quentin Neill <quentin.neill@gmail.com>
Subject: Re: [PATCH] blame: add blame.showemail config option
Date: Thu, 30 Apr 2015 09:03:03 -0500
Message-ID: <CACfD1vtfO_rqr4wv4oHm7W7DSn-Gk-du6nCuJzYvpPXK_d=y=g@mail.gmail.com>
References: <1429841612-5131-1-git-send-email-qneill@quicinc.com>
	<CAPig+cQrUPHOaKjNhsmLho+bFdAOQxb0NK2YK2QsFmdDBF6h4g@mail.gmail.com>
	<CACfD1vvaAGkx2P3yMfZPOZrRvG3-H96zQVOCevnd-O0rBJ7wjw@mail.gmail.com>
	<xmqqwq0xwige.fsf@gitster.dls.corp.google.com>
	<CAPig+cRTfB9aiinhSJp=jY7-__6dRvfAqhWZYVN3+Ut=Y79LcQ@mail.gmail.com>
	<xmqqmw1svigd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 30 16:03:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynp3Y-00005o-GU
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 16:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbbD3ODI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 10:03:08 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33583 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbbD3ODF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 10:03:05 -0400
Received: by qkx62 with SMTP id 62so33503182qkx.0
        for <git@vger.kernel.org>; Thu, 30 Apr 2015 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=9xPcymFyPMJI3CBccrjnwz3Bq7KgGm7VGAIQO4d2V98=;
        b=HRfA4RE33Ph4AtljghuTybA5hHFmBdpfTXH6ojQIFqzPei+Rwdt3rHMJX7lFdh4Reo
         bvWU2ozpLmczaXR/2Krn2rHYbQThJawPyHPAEfFqtHyNRMh7x+HtQLTofyCNaCicLEcx
         jGPUA2YtNVpivUjvAGXi9Wnj7hMkCGRvMAuhqPSP5Njnfyo/7LknzID+jE1haSX/7Rsj
         gSIY9vUIdQB+I2LbZ0sWtd/afa+kCWEBqIlhDz3sON0NZ+AXWcRGEq42AOzP8WdzSIZ1
         WAghvHPdnzXY/lCZ0TeEp37LjdpKtFSuw11J/KmrLIn++BSQ6xHnGmpMhetYuZexdc9Q
         gnBg==
X-Received: by 10.55.27.42 with SMTP id b42mr7514842qkb.53.1430402583854; Thu,
 30 Apr 2015 07:03:03 -0700 (PDT)
Received: by 10.140.89.229 with HTTP; Thu, 30 Apr 2015 07:03:03 -0700 (PDT)
In-Reply-To: <xmqqmw1svigd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268072>

On Mon, Apr 27, 2015 at 1:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> It's not clear why you relocated documentation of --show-email from
>>>
>> I moved it to be with the other variables that had configuration
>>
>> options, but I will move it back.
>
> Please do not do anything before you understand why there are two
> places, and if you don't understand, ask.
>
>> I followed the code for blame.showRoot and blame.blankboundary.
>
> I do not think that is quite true.

Points well taken.  I'll admit I posted the patch as a way to find out these
sorts of things, but I see I could have done a bit more digging and asking
before posting.  Apologies for the noise.

On Tue, Apr 28, 2015 at 2:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> .. instead set the OUTPUT_SHOW_EMAIL bit in git_blame_config().
>
> Don't forget to clear the bit when the bool is set to false, too.

I think I have this now, and some tests that check it, but have a pair
of questions.

On Fri, Apr 24, 2015 at 12:22 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Despite being case-insensitive and despite existing inconsistencies,
> in documentation, it is customary to use camelCase for configuration
> options, so "blame.showEmail".

I noticed while testing that git_config()/git_value() lowercase
everything, so to
be clear this camelCase custom for configuration names is for documentation
only, right?

I'm thinking of a test file that will test all the git blame options,
but for this
patch it will only test the new showEmail config.  I read t/README and
tentatively named the new test file "t/8009-blame-config.sh".

Please guide.
