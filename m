From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] Simplified the invocation of command action in submodule
Date: Wed, 9 Jan 2008 14:23:51 +0600
Message-ID: <7bfdc29a0801090023s437b681ak435f4e31ee649b72@mail.gmail.com>
References: <1199851140-31853-1-git-send-email-imyousuf@gmail.com>
	 <7vsl17l8bi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 09:24:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCWEY-0005CR-Tk
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 09:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbYAIIX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 03:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbYAIIXz
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 03:23:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:31916 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbYAIIXz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 03:23:55 -0500
Received: by fg-out-1718.google.com with SMTP id e21so170922fga.17
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 00:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fDcXJyqtR9PJm4BWHrRVZfxdv8p9JadivJfleeGQfKs=;
        b=k+w8NbQAb2R9LCgGvmFpcBo16AAaANG/lvKr1CIZzCHm00Z4hd4wNLf+9jTEzNSpcTdSxODtTh8Uz+qeTP9c+JpSSBT4jPuzPCkeiCirvDDBANQLY03RgP22Xw2JhSSTirsTP1lMn/qcvyFRDqkKj+AXowtJGCh/+zH+KO2Z6nY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O5EEJAbplJwnDiuFIoims6i+MYLUAyTWsNpYU0QSbihYX9y1N/9soQkXS9P++KrZxD3ceJ7eKXC3nX83hiWidujLRA7QBSba8uyqRMNDbgg87TZroL0KaLKwMkNy1foySgU/ApMCW+4mWIHpq9gRq827tW2asFY37VPp2TgKxP4=
Received: by 10.78.184.2 with SMTP id h2mr148721huf.27.1199867031462;
        Wed, 09 Jan 2008 00:23:51 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Wed, 9 Jan 2008 00:23:51 -0800 (PST)
In-Reply-To: <7vsl17l8bi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69965>

Hi Junio,

Firstly, $add is still used later in the code.
Secondly, yes the variables should be deleted. Will make the change
and send the patch again; I forgot to clean the unused variables from
the declaration, sorry.

Best regards,

Imran

On Jan 9, 2008 2:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> imyousuf@gmail.com writes:
>
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index ad9fe62..8a29382 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -16,6 +16,7 @@ update=
> >  status=
> >  quiet=
> >  cached=
> > +command=
>
> Doesn't the patch make some if not all of the above variables
> unused?
>
> >       case "$1" in
> >       add)
> >               add=1
> > +             command="module_$1"
> >               ;;
> >       init)
> > -             init=1
> > +             command="modules_$1"
> >               ;;
>
> Does the remaining code still use $add?
>



-- 
Imran M Yousuf
