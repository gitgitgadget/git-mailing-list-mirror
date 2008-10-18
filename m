From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [Q] submitting patches from gmail
Date: Sat, 18 Oct 2008 15:00:37 +0200
Message-ID: <4ac8254d0810180600t7e06d05ya635d60c3e8ec8e6@mail.gmail.com>
References: <ee2a733e0810180508m466f3ea1i9c63b47177f6e12d@mail.gmail.com>
	 <gdcm3d$f3k$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 15:01:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrBRG-0005Li-U0
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 15:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbYJRNAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 09:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbYJRNAj
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 09:00:39 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:60771 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbYJRNAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 09:00:39 -0400
Received: by wx-out-0506.google.com with SMTP id h27so427829wxd.4
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=L6YytFfnvINfT1OpF2wMsa/YQJaKf4Y+0QIjV/kvqME=;
        b=fTvT1+d8CSzsCZXXoVJ2WEby0ZtZs6EA5lIDP9cJXyrN3gtCsYnYE3PnowYmFrd9uX
         zo3XNotBX/bbBSxq2fMXArG9LL7jG1xN8t2Jiv0Dj/yl1XC5M9H6ZU9CyQMHAkOBySqT
         SzkJ4XsbYNl6X8XCb0w4X1n76rBy5fdnqABGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dnHZY1xVXVFSj8M0I981O7GPmfxVcEMp60IUc7P8m3kkV79sJTf5r+FeTHVqIfl0Ne
         ShoVJPU2hYo0eNLw4+xEad3vOrYdmB3u28HUlnz/6hv8t/yVDxbnPN7PYUN+jHiGG4QX
         aroBrSAoN8cfbk63goxOp0vZtitvz7GTctp5s=
Received: by 10.64.76.15 with SMTP id y15mr2389481qba.92.1224334837473;
        Sat, 18 Oct 2008 06:00:37 -0700 (PDT)
Received: by 10.65.114.10 with HTTP; Sat, 18 Oct 2008 06:00:37 -0700 (PDT)
In-Reply-To: <gdcm3d$f3k$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98545>

On Sat, Oct 18, 2008 at 2:50 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> On Saturday 18 October 2008 14:08, Leo Razoumov wrote:
>
>> Hi Everyone,
>> I wonder what is the preferred way to submit patches from a gmail account.
>> Google mail auto wraps long lines and there is no way to change this setting.
>> Safe way would be to use attachments. Are they allowed on git mailing list?
>
> I've been sending patches from gmail for a while without problems. It took me
> a while to find a working configruation, but I finally managed to do it using
> msmtp. I have
>
> [sendemail]
>        smtpserver = /usr/bin/msmtp
>
> in my ~/.gitconfig
>
> and the following ~/.msmtprc
>
> ======
> # Example for a user configuration file
>
> # Set default values for all following accounts.
> defaults
> tls on
> tls_trust_file /etc/ssl/certs/ca-certificates.crt
> logfile ~/.msmtp.log
>
> # My email service
> account gmail
> host smtp.gmail.com
> from yourgmailusername@gmail.com
> auth on
> user yourgmailusername
> password yourgmailpassword

as the password is stored in plaintext I prefer
to leave it out and get asked every time I
use mstmp :-).

> # Set a default account
> account default : gmail
> =========
>
> And to send patches I just use something like
>
> git send-email --to "git@vger.kernel.org" --cc "whoever" 00*
