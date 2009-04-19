From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH RFC3.5 08/12] send-email: Move Subject sanitization from 
	--compose code to send_message
Date: Sat, 18 Apr 2009 21:54:07 -0400
Message-ID: <76718490904181854o380fe118y9f3a52c926bd1f6d@mail.gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-8-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-9-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 03:55:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvMFz-0005Nt-5C
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 03:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbZDSByL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2009 21:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbZDSByJ
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 21:54:09 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:52536 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977AbZDSByI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Apr 2009 21:54:08 -0400
Received: by yw-out-2324.google.com with SMTP id 5so997437ywb.1
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 18:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WExvd8DQYgdfg1V8G+MMsLV0Fpf7GtboRBWXAv9/M98=;
        b=C81B8MkcfryT0EVuCRJm2zv+qRYyLQuOjBkNRIdSYiVThgzcDFr4OUo2RDwnOeNNmD
         k8ZmUIJlqHwWpKhIT3xYiQvxH5PrK5Os2aQAdyTQIlxe48SOhT0lyy3s4/dF62Lh1ig5
         g/lazq1y3ZxRIpVEh5/FnqmuBNas4+Q5lYic4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HtupCI0IuA06nqyxkg0QsO0rdLKreubexd1SObKEgT/mFPYgEcs9etj3z/J0mfh9WJ
         mfbZev0mOEjhQbZJ0SvLDU522U74wPPs5lVR9Zo1KoI2eZC03wGT3qUmCKOjMINkpIQT
         BUqvGyWmTrXhHS4KG8DhyACw93CzCYCbmmolI=
Received: by 10.150.149.19 with SMTP id w19mr5464657ybd.79.1240106047225; Sat, 
	18 Apr 2009 18:54:07 -0700 (PDT)
In-Reply-To: <1240074128-16132-9-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116875>

On Sat, Apr 18, 2009 at 1:02 PM, Michael Witten <mfwitten@gmail.com> wr=
ote:
> + =C2=A0 =C2=A0 =C2=A0 my $sanitized_subject =3D ($subject =3D~ /[^[:=
ascii:]]/) ? quote_rfc2047($subject) : $subject;

I wonder if it would be clearer to always call quote_rfc2047, then
have that function just return its input unaltered if quoting is not
needed.

j.
