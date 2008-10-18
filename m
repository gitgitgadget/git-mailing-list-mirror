From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: [Q] submitting patches from gmail
Date: Sat, 18 Oct 2008 10:12:06 -0400
Message-ID: <ee2a733e0810180712k42a4dbb6m3d4e9de717a79b53@mail.gmail.com>
References: <ee2a733e0810180508m466f3ea1i9c63b47177f6e12d@mail.gmail.com>
	 <gdcm3d$f3k$1@ger.gmane.org>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 16:13:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrCYr-0001wu-Gu
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 16:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbYJROMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 10:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbYJROMM
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 10:12:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:34564 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbYJROML (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 10:12:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so762955fgg.17
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OvJutyCDd2JWpwWL5ZMQN25RLtP2EQMtjvEaftzG8SE=;
        b=Ifk/dEBQetkI8r7yGWXpPSTcc/QKEjf8jo4vpmslNY1PTw8obhteZf+bVT9wnNgxam
         yV7zCGj3wUJhYAArcdOh3jNmIN3AWZT65ZrnRr6/qtVzGZBVfdkorpkzZu5hxnL408eL
         NbvfktDkfAcpYSXgXS6NULYm6NOQsEqeyo3E4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=mIG2iY/V6wgWbpIk63kgHyWaBNCAVjK58e+a+VXPyCLI8Ge607zrwFaoaYr+g5AG/G
         +CgYfJugToVVsdca/mv9hBZVHtDe9ZXoBsiQ4rgVu/kT33U8wQ1lnw7DpenB+38Tizws
         kwXHWXG67HklbZ3olOVv/ws32BWJpqS3tef+A=
Received: by 10.187.243.17 with SMTP id v17mr799140far.77.1224339126522;
        Sat, 18 Oct 2008 07:12:06 -0700 (PDT)
Received: by 10.187.193.16 with HTTP; Sat, 18 Oct 2008 07:12:06 -0700 (PDT)
In-Reply-To: <gdcm3d$f3k$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98552>

Giuseppe,
Thanks for the help!

BTW, what is  /etc/ssl/certs/ca-certificates.crt and how to generate it?

--Leo--

On 10/18/08, Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
> On Saturday 18 October 2008 14:08, Leo Razoumov wrote:
>
>  > Hi Everyone,
>  > I wonder what is the preferred way to submit patches from a gmail account.
>  > Google mail auto wraps long lines and there is no way to change this setting.
>  > Safe way would be to use attachments. Are they allowed on git mailing list?
>
>
> I've been sending patches from gmail for a while without problems. It took me
>  a while to find a working configruation, but I finally managed to do it using
>  msmtp. I have
>
>  [sendemail]
>         smtpserver = /usr/bin/msmtp
>
>  in my ~/.gitconfig
>
>  and the following ~/.msmtprc
>
>  ======
>  # Example for a user configuration file
>
>  # Set default values for all following accounts.
>  defaults
>  tls on
>  tls_trust_file /etc/ssl/certs/ca-certificates.crt
>  logfile ~/.msmtp.log
>
>  # My email service
>  account gmail
>  host smtp.gmail.com
>  from yourgmailusername@gmail.com
>  auth on
>  user yourgmailusername
>  password yourgmailpassword
>
>  # Set a default account
>  account default : gmail
>  =========
>
>  And to send patches I just use something like
>
>  git send-email --to "git@vger.kernel.org" --cc "whoever" 00*
>
>  --
>  Giuseppe "Oblomov" Bilotta
>
>
>  --
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
