From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3 05/13] send-email: Cleanup the usage text and docs a 
	bit
Date: Mon, 13 Apr 2009 17:42:45 -0500
Message-ID: <b4087cc50904131542q7354fa05wb763f70e4baf9abb@mail.gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
	 <7vhc0se0pc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 00:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtUtd-0001NV-LN
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 00:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbZDMWmr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 18:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbZDMWmq
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 18:42:46 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:24197 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbZDMWmp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 18:42:45 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2633638qwh.37
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 15:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uL8J8x0hlH+KfYevwbUyPJ1k3HEzCor96jGSQnfU7CA=;
        b=SSZHO4+jjAXqiOb9l3+TC8A5OwM66pHdSHVODK97VQlv+BlS8WdtIdiK+y9lFqLUi0
         agUjzGWHocyJyD1uT6QHDHU5MACpQLZ3QFs3gxxyrbJVC8Wg9/sxGpo7OmhtxXLz3ZfV
         QpJCrW1UAB/1z94KsIGmBZa6pXSiCCPdDyPGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MvChio5IT6/NoNrVHPQzQeP8h/JeLBiKhj1YPQ4RO4UEtRmu/x1CJBBReHjFZM4d47
         Qcp9r5eDBNYCsgCoW8Fh/JKUB4HYCbnhmYNu+ghLPF2RQVjVCAWtQlHQQ4/penEr52qv
         8GjgPc3lhFsUtxS4oMcZXQ5ZICi3ijJOc3thE=
Received: by 10.224.67.83 with SMTP id q19mr6800296qai.40.1239662565188; Mon, 
	13 Apr 2009 15:42:45 -0700 (PDT)
In-Reply-To: <7vhc0se0pc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116499>

On Mon, Apr 13, 2009 at 15:51, Junio C Hamano <gitster@pobox.com> wrote=
:
> Michael Witten <mfwitten@gmail.com> writes:
>
>> All usage text lines should be < 80 characters.
>>
>> A port number in --smtp-server is no longer handled,
>> so the suggestion has been removed.
>
> That makes it sound like there is a regression.
>
> =A0 =A0 =A0 =A0require Net::SMTP;
> =A0 =A0 =A0 =A0$smtp ||=3D Net::SMTP->new((defined $smtp_server_port)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ? "$s=
mtp_server:$smtp_server_port"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : $sm=
tp_server);
>
> and because Net::SMTP is a subclass of IO::Socket::INET, I'd assume t=
hat
> this use will accept smtp_server=3Dthere:submission when $smtp_server=
_port
> is undef.

I may have been concerned that the SSL connection code doesn't support
a host:port specification, so I thought it would be easier not to
advertise it:

>    if ($smtp_encryption eq 'ssl') {
>        $smtp_server_port ||=3D 465; # ssmtp
>        require Net::SMTP::SSL;
>        $smtp ||=3D Net::SMTP::SSL->new($smtp_server, Port =3D> $smtp_=
server_port);
>    }


>> ---in-reply-to=3D<identifier>::
>> +--in-reply-to=3D<message-id>::
>
> Changes along this line in your patch looked sensible, except for the
> "identity" one which is a bit iffy.

The change to <id> ? Well, I did so, because the usage text uses <id>
for compactness; I think everything else matches.
