From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v2] git-submodule add: Add -r/--record option.
Date: Mon, 29 Oct 2012 13:38:28 -0400
Message-ID: <CABURp0pFLi+2A+9wi-ZamiRze2u6z+6oyoCsNpWOLq_cq2L1rQ@mail.gmail.com>
References: <1f6ee2966ffe0f58f4b96ae0efb2ffb13e2fa2d8.1351029479.git.wking@tremily.us>
 <50883E54.4080507@web.de> <20121025005307.GE801@odin.tremily.us>
 <508D9A12.6010104@web.de> <CAJo=hJt_A5FCCcvR=sZ5Ni+-ZGq+MjxqkONbh9k+A46xBH9jzA@mail.gmail.com>
 <20121028223431.GF26675@odin.tremily.us> <20121029053401.GB30186@sigill.intra.peff.net>
 <20121029104544.GA2424@odin.tremily.us> <20121029105855.GA15075@sigill.intra.peff.net>
 <20121029112945.GD2424@odin.tremily.us> <20121029114310.GA16046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "W. Trevor King" <wking@tremily.us>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 18:39:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TStIl-0002Z1-JV
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 18:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070Ab2J2Riv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 13:38:51 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:39207 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab2J2Riu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 13:38:50 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so3962551lag.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gVKfntSJdUBVuCrV55trkxrlcxwxRlji5UXSq8ZifQA=;
        b=bJIl2SfvrabdnIbIGNSg6SAm73HYEE6J/a4N5Am7OXJ88leUNOOflLF5H3yvNFVqvd
         FY2SN85VXsanILYQ29y1Md5m/qiCeqmDpIQuivaxqI1QrDkl9RnSdQTtitZqEoDs+iwK
         Hw1NtiPwnPCUBkpKs53wkpyAew7JZ+7aFLgduwrqnxKnmrKfWFllsS2iQ7LAukvSNEHB
         2yWRiA2jZvj7CrTyPpEVC9QZaXVy7WvU0zlcYkJT3OebO7De/7EohK0tnQXbkEbWqBDS
         X8s/PS72gRazAepQW4J/lp7yzT/gMUrVK16/XhYSGEgYryE3jYazDOYqMzeos25adEHS
         H9Wg==
Received: by 10.112.30.163 with SMTP id t3mr12256126lbh.56.1351532329054; Mon,
 29 Oct 2012 10:38:49 -0700 (PDT)
Received: by 10.114.26.166 with HTTP; Mon, 29 Oct 2012 10:38:28 -0700 (PDT)
In-Reply-To: <20121029114310.GA16046@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208631>

On Mon, Oct 29, 2012 at 7:43 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 29, 2012 at 07:29:45AM -0400, W. Trevor King wrote:
>
>> On Mon, Oct 29, 2012 at 06:58:55AM -0400, Jeff King wrote:
>> > Can you send an updated version of the patch that summarizes the
>> > situation in the commit message?
>>
>> Sure.  Should I include Phil's $submodule_<var-name> export, or would
>> you rather have that be a separate series?
>
> I think it probably makes sense as a separate patch in the same series,
> since it is meant to support the same workflows.

I agree.  I did expect to clean it up some, but also to suffer some
review.  Feel free to clean it up as you see fit and submit it with
your series.

> I am not sure it is sufficient as-is, though. It does not seem to ever
> clear variables, only set them, which means that values could leak
> across iterations of the loop,  [...] E.g., when
> the first submodule has submodule.*.foo set but the second one does not,
> you will still end up with $submodule_foo set when you process the
> second one.

Good point.  That should not happen.

> or down to recursive calls.

Frankly, I consider that to be a feature.  However, I can see how it
would be considered inconsistent in many ways, so it's probably best
to squash it.  :-\

Phil
