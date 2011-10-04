From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] remote: support --all for the prune-subcommand
Date: Tue, 4 Oct 2011 09:18:03 +0200
Message-ID: <CABPQNSZ-ELfFuxmKMqXCQaAgMZMRsZG3S5wWJLsjkYVvK6aGug@mail.gmail.com>
References: <1317644168-5808-1-git-send-email-kusmabite@gmail.com>
 <20111004070006.GA6824@sigill.intra.peff.net> <CABPQNSZrfxhyA3em8TN2=d7pAHopZMgRg47baKnDT9h14=rxkA@mail.gmail.com>
 <20111004071332.GA7308@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 09:18:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAzH7-00063r-Kg
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 09:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436Ab1JDHSp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 03:18:45 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:51611 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab1JDHSo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 03:18:44 -0400
Received: by pzk1 with SMTP id 1so605319pzk.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 00:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=6Eohs9dESQKP4azKyJiiaTDVKXsavEaUYvJ9onpDtuY=;
        b=iuN6xJi3k6fS0I6j0GiVE5cK9R7TzJDRoTiqjkzLT25rT8idEUxp1kEVXtAMviCI7J
         7CZKalqa29YeGrcNFTfqbn8Z2iKpgPB5Fi7AzDtutG+3NXX49CRu3h5r3MhQWtgRbivV
         80XnF1Bp/M/dRPaJ08lp2HKS0SMIv74FPP1kw=
Received: by 10.68.14.105 with SMTP id o9mr7245705pbc.95.1317712724038; Tue,
 04 Oct 2011 00:18:44 -0700 (PDT)
Received: by 10.68.42.169 with HTTP; Tue, 4 Oct 2011 00:18:03 -0700 (PDT)
In-Reply-To: <20111004071332.GA7308@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182734>

On Tue, Oct 4, 2011 at 9:13 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 04, 2011 at 09:10:40AM +0200, Erik Faye-Lund wrote:
>
>> > =A0git fetch --all --prune
>> >
>> I wasn't aware that fetch could prune, but yeah, that seems much
>> better to me. Perhaps a mention of this in the "git remote prune"
>> documentation could steer other users in the right direction?
>
> Yeah, that makes sense.
>
> There is one slight difference: I think "git remote prune" will _just=
_
> prune, and not fetch into existing refs at all. I'm not sure exactly
> why you would want that, though.

Hmm, you might want to do that on, say, a mobile network to save
bandwidth; i.e throw away the stale branches, but not yet update the
non-stale ones because downloading the objects might take a long time
(and/or be expensive).

So with that in mind, I actually think my patch makes sense in some
cases, but it certainly is less useful that I originally though ;)

A mention in the documentation seems like a good move no matter what, t=
hough.
