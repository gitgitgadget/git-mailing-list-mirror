From: "Cedric Vivier" <cedricv@neonux.com>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Sat, 7 Jun 2008 02:43:29 +0200
Message-ID: <d45085aa0806061743w65df3cd7pe4cf5fa29f83930a@mail.gmail.com>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>
	 <alpine.DEB.1.00.0806051946100.21190@racer> <484969F0.1030704@gnu.org>
	 <alpine.DEB.1.00.0806061911300.1783@racer>
	 <Jx4nZtFGdU-iUxlX24G6lzMyWe99Z53jtjQp9T9qkMJ1iZC0eZW6xg@cipher.nrlssc.navy.mil>
	 <d45085aa0806061417ue3f1f51i6580acbb51070e5b@mail.gmail.com>
	 <alpine.DEB.1.00.0806070006150.1783@racer>
	 <d45085aa0806061713k72108a87qa6635a5935732f20@mail.gmail.com>
	 <7vej7aqetd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Brandon Casey" <casey@nrlssc.navy.mil>,
	"Paolo Bonzini" <bonzini@gnu.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 02:44:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4mXf-0003Gs-QF
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 02:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbYFGAnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 20:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbYFGAnb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 20:43:31 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:56341 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbYFGAna (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 20:43:30 -0400
Received: by wa-out-1112.google.com with SMTP id j37so922099waf.23
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 17:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=ep455IuLIQEHWdXfXxShQ4GL8j1mEmQqaKPk3pQpz00=;
        b=UDJmEgEKIOhaqh186uMFTLabR1rT2TT0nFJ/gpLPcV4ltHEOmwgHGotYDaFTgObtL6
         wvwC1j1N4UBkqDtDpzCMvQ16rOCRvftqxQ699yVz5u+VAv9fPEs46lvUaY/3Y4Jl/zUn
         DTz0ndv9B/fgpD79ibtX8RNsfuvtU+fL1BJTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=jIyuuURckmcEMfe1m5xNNQrLwQxrdGUCYb6sUiiRzhkSB8pab4fEHFedgZyn+C6g5/
         Apth+l9nsc+EchmDaN5KluV7tVOGNEnUTNGhch00ma3p9SQaWtrPyufEIg+d4oGjfr2e
         pHj1o5WyWVL+qcHjbnuxBtL5G2RUuXbiddd/c=
Received: by 10.114.158.1 with SMTP id g1mr893119wae.203.1212799409320;
        Fri, 06 Jun 2008 17:43:29 -0700 (PDT)
Received: by 10.115.33.3 with HTTP; Fri, 6 Jun 2008 17:43:29 -0700 (PDT)
In-Reply-To: <7vej7aqetd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 78cef75d886aa025
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84158>

On Sat, Jun 7, 2008 at 2:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Somebody suggested strvercmp(); how does the natcmp() compare with it?
>

Yeah I did, as a heads-up from the discussion on the apache
mailing-list linked earlier.
I've just checked out glibc's implementation, the result would be the
same, the code seems better to me, and there is no doubt the license
is 100% compatible this way [1], sounds cool.

[1] as I guess we'd still have to borrow the code from glibc and put
it into git's compat/ directory (or whatever name is choosen in the
end for this kind of borrowed stuff) to make it work on non-glibc
platforms (?)
