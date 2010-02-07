From: Aaron Crane <git@aaroncrane.co.uk>
Subject: Re: [PATCH] Documentation/SubmittingPatches: fix Gmail workaround 
	advice
Date: Sun, 7 Feb 2010 20:03:31 +0000
Message-ID: <bc341e101002071203x52bceaach8d42c6188630f1d1@mail.gmail.com>
References: <1265555642-40204-1-git-send-email-git@aaroncrane.co.uk> 
	<7v8wb4gaef.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 21:03:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeDMJ-0007CM-MV
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 21:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155Ab0BGUDu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 15:03:50 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:11873 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab0BGUDt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 15:03:49 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1189145eyd.19
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 12:03:48 -0800 (PST)
Received: by 10.216.93.78 with SMTP id k56mr1080099wef.102.1265573028238; Sun, 
	07 Feb 2010 12:03:48 -0800 (PST)
X-Originating-IP: [87.194.157.167]
In-Reply-To: <7v8wb4gaef.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: ad592cf2297804fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139250>

Junio C Hamano <gitster@pobox.com> wrote:
> Aaron Crane <git@aaroncrane.co.uk> writes:
>> The suggested approach to dealing with Gmail's propensity for breaki=
ng
>> patches doesn't seem to work. =C2=A0Recommend an alternative techniq=
ue which
>> does.
>
> Do you know _why_ it does not work? =C2=A0For example, does it not wo=
rk _at
> all_ for you? =C2=A0Or only certain things does not reliably work (io=
w, perhaps
> you are seeing a bug in imap-send)?

What happens for me is that `git imap-send` successfully puts the
message into the gmail Drafts folder, but when it's sent it's been
line-wrapped (and any line-end spaces are deleted, which breaks diffs
containing empty context lines).

I've verified that it's not `git imap-send` at fault, by tweaking it
to tee all socket-written data to a local file; all whitespace in the
mail prepared locally is sent to Gmail unchanged.  So Gmail is
mangling the message when it gets uploaded (or possibly when it's
opened in the web interface, or when it's sent).

I've tried this both with a vanilla Gmail account, and with Google
Apps For Your Domain Standard Edition, and I get the same behaviour.

> What I am trying to get at is to see if the current imap-send suggest=
ion
> is fundamentally unworkable with gmail. =C2=A0Perhaps they stopped su=
pporting
> imap. =C2=A0Perhaps the procedure never worked.

As far as I can determine, the current imap-send suggestion is
fundamentally unworkable with gmail at the moment.  I don't know
whether it ever used to work, though I've been assuming that it did.

--=20
Aaron Crane ** http://aaroncrane.co.uk/
