From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 15:56:35 -0700
Message-ID: <CA+55aFyKWLUMQFfaeKJKGFPV_7kfOGjf+pSZ1Y8afzkT4OYQ9Q@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <4EAF1F40.3030907@zytor.com> <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com>
 <4EAF2245.90308@zytor.com> <CA+55aFzedaAzzWfzhqVf8y8ZW0jeb56hZwdV3UodSp8Q_Qhc2A@mail.gmail.com>
 <7vvcr4ojvp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-ide-owner@vger.kernel.org Mon Oct 31 23:57:00 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RL0mp-0003wr-Kk
	for lnx-linux-ide@lo.gmane.org; Mon, 31 Oct 2011 23:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934751Ab1JaW46 (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Mon, 31 Oct 2011 18:56:58 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59691 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934704Ab1JaW45 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2011 18:56:57 -0400
Received: by wwi36 with SMTP id 36so2248773wwi.1
        for <multiple recipients>; Mon, 31 Oct 2011 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=jLbjxwwKZLWofH5flRsVYvCeJwSPJMt+ngzCQvqDNGY=;
        b=JslepSAHFrXJxx9spZXEX0BStZ6Sgl+jlj3p2WbWWbRoE9VIggDTSlo1hXi1lfKB0P
         b7F2+xkFNunXZr7MZBb3sSQRhDhdSpB83v8gWjqyaHPMiyYuhygoibd2rChl6wMPWn+A
         iTV+86kf+ykdBCKwebF1iWUVNXqD70UcU3Ls8=
Received: by 10.216.188.83 with SMTP id z61mr3556122wem.82.1320101816144; Mon,
 31 Oct 2011 15:56:56 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Mon, 31 Oct 2011 15:56:35 -0700 (PDT)
In-Reply-To: <7vvcr4ojvp.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: ttY3rzU154frN_-764RPAb-6eOo
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184541>

On Mon, Oct 31, 2011 at 3:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Some cut-and-paste (or piping the e-mail to a command) would be necessary
> evil, though, as you would have GPG keys from more than one trusted person
> in your keyring, and when you are responding to a pull-request from person
> A, finding a valid commit signed by person B should not be a success, but
> at least should raise a warning.

Why?

The signer of the message needs to be printed out *anyway*. I can
match that up with the pull request, the same way I already match up
diffstat information.

So any extra cut-and-paste is (a) stupid, (b) unnecessary and (c) annoying.

It's also "bad user interface". The whole point is that we should make
the user interface *good*. Which means that the pushing side should
only need to add a "-s" to ask for signing, have to type his
passphrase (and even that would go away when using gpg-agent or
something), and perhaps a message (which would not be about the
signing, but about something that could be added to the merge commit.

And the receiving side would just do the "git pull" and automatically
just get notified that "Yes, this push has been signed by key Xyz
Abcdef"

                     Linus
