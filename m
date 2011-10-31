From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 15:30:32 -0700
Message-ID: <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <4EAF1F40.3030907@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: linux-ide-owner@vger.kernel.org Mon Oct 31 23:30:59 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RL0Nd-0001pq-MN
	for lnx-linux-ide@lo.gmane.org; Mon, 31 Oct 2011 23:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269Ab1JaWa4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;lnx-linux-ide@m.gmane.org>); Mon, 31 Oct 2011 18:30:56 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57672 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab1JaWaz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2011 18:30:55 -0400
Received: by wwi36 with SMTP id 36so2227232wwi.1
        for <multiple recipients>; Mon, 31 Oct 2011 15:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=DiuZD3E9CutLSMOrizk4xEqGuwvsFlJF9ShgBo5ZrV8=;
        b=SRrtyhajNN+H4XmzznKmhjeCFGbrRblfcjmEB6gWMVRfsSyqcjOOqwoSsaRnUPNXhA
         aiXpZ+7BVOqV0WeGfNtMlIcWkKirhXeCMCj9wa02BbC2drdbx0kO1z4GC0QYC+MzMvld
         iU3D+hg7dr9DuU21Cn+e6OUspk9tSuGpJV7WU=
Received: by 10.216.12.82 with SMTP id 60mr3484589wey.97.1320100254124; Mon,
 31 Oct 2011 15:30:54 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Mon, 31 Oct 2011 15:30:32 -0700 (PDT)
In-Reply-To: <4EAF1F40.3030907@zytor.com>
X-Google-Sender-Auth: vz8IO_opIPERPwPKbO9JR0nuUBA
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184529>

On Mon, Oct 31, 2011 at 3:20 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Perhaps we should introduce the notion of a "private tag" or somethin=
g
> along those lines? =A0(I guess that would still have to be possible t=
o
> push it, but not pull it by default...)

All tags are private by default.

We actually *only* fetch tags if somebody explicitly asks for them
(--tags), or when fetching from a named remote (and even then it will
only fetch tags that point to objects you fetched by default iirc -
you have to mark the remote specially to get *all* tags).

But if you do the normal "git pull git://git.kernel.org/name/of/repo"
- which is how things happen as a result of a pull request - you won't
get tags at all - you have to ask for them by name or use "--tags" to
get them all.

                   Linus
