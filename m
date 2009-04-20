From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3.5 03/12] send-email: Interpret --smtp-server "" as 
	"use a default".
Date: Sun, 19 Apr 2009 21:52:58 -0500
Message-ID: <b4087cc50904191952x27ec0269nd12849688f720fb3@mail.gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
	 <7v7i1gp0di.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 04:54:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvjeV-0004yy-A2
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 04:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbZDTCxA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Apr 2009 22:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbZDTCxA
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 22:53:00 -0400
Received: from mail-qy0-f126.google.com ([209.85.221.126]:63652 "EHLO
	mail-qy0-f126.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbZDTCw7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Apr 2009 22:52:59 -0400
Received: by qyk32 with SMTP id 32so1274864qyk.33
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 19:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3yfPRCCL1BtvggOgghcJb2WqWqN2XoO7IIG7rxJjVVQ=;
        b=jX3JMhBM0Q/OqTw4SIShlFXC9P+L3xf+XpXlgkVB1LB2taldVEIA9osEKVzFbFHIbr
         RbrNYv3w31K40tJhsvn52O6EDyPydbYA1N9nTli7TlI89t4BE3ABE8qniNvM2bSASAb3
         xz1kUEPF3cuPzQgjdf5T/1PMVEUI1FkYnOdMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=c3GVnp9oXgAtxFLjVWRamdE86D4Fe95SdJkGBFLKxqg2dAZbOYgfsd1ygbKF3Rrw3N
         GbxnQWQ4eSRCRNN/FPA6ZwdNQvnH4t6/qTfB9/da06B34NfwJpmQLZnPnhWU+RWKnhZ+
         hzePzevoJOc8S8pAVvTZGJ7ry8fil5kQScCi8=
Received: by 10.224.67.76 with SMTP id q12mr5715438qai.279.1240195978741; Sun, 
	19 Apr 2009 19:52:58 -0700 (PDT)
In-Reply-To: <7v7i1gp0di.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116929>

On Sun, Apr 19, 2009 at 20:41, Junio C Hamano <gitster@pobox.com> wrote=
:
> Michael Witten <mfwitten@gmail.com> writes:
>
>> Why not? It's at least useful for testing.
>
> Why so? =A0"Use a default" as opposed to using what?
>

Use a default as opposed to using the nonsensical empty string.

> It is unclear what "a default" is in this context. =A0Do configured v=
alues
> count as "a default"? =A0I suspect not.
>
> I think you meant "allow overriding the configured values and use the
> default", but then you should spell what the defaults are (an availab=
le
> local MTA binary, or SMTP port on localhost, I think). =A0That is muc=
h more
> informative than your "Why not?..."

I see your irritation is derived from my carefree (careless?) commit
message. However, the patch doesn't do anything but trigger the
already present default-selecting code; there are already docs that
specify what those defaults are.

> In any case, I find it counterintuitive to trigger "use the default" =
with
> an option. =A0Something like "--ignore-config=3Dsmtp-server,smtp-port=
" might
> make sense, though.

I can get behind that kind of solution; however, I see no problem with
the shorthand --smtp-server "" either (other than the fact that it
requires an extra test in order to work).
