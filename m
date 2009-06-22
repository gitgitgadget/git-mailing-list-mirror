From: Filip Navara <filip.navara@gmail.com>
Subject: Re: git-mailsplit and TortoiseGit bugs
Date: Mon, 22 Jun 2009 23:46:35 +0200
Message-ID: <5b31733c0906221446m1a82b39fkd5d25ea413697138@mail.gmail.com>
References: <5b31733c0906221053k4b2659bev1da861b8e997eb5f@mail.gmail.com>
	 <20090622202939.GA11912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	tortoisegit-dev@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 22 23:46:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIrLg-0002hs-5J
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 23:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbZFVVqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 17:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbZFVVqe
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 17:46:34 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:62236 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbZFVVqd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 17:46:33 -0400
Received: by fg-out-1718.google.com with SMTP id d23so675206fga.17
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 14:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uVa1UW8J+ijaef8nuKFDETmTWBL1Z4jA3SBJ3wK4VnQ=;
        b=llL5IU4NhjK/cADCp+66gngoid2breWtkjVMZmqedFXHkQ8XcQZQRUplG8awsROizF
         6Jtynj48ueozLu90lFFAI60rfx9Mj4kctRr2hLOqA5queE6LHRUdEhhUF6DBpTk7H0wH
         4lrQVs4gyj8Slpyb+hnZmKEiKTJQV/CAinJxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qrVh/XbqcYeXM9cbFVRu3v4r+qPm1ArnE6DI6jkCgJruRfeJJ5vybWdwFsTwxwPMGH
         vInnMwDVbUfwLupj/yPPLQEwcWUKqifuNo82ACqlvRZGcCo/WIOWtsiKP7rRwqbto/IS
         OSF/JxzDQ1T/TmZ1Grj8AhMsgnvOaV6SeFKzA=
Received: by 10.216.36.73 with SMTP id v51mr2311162wea.215.1245707195333; Mon, 
	22 Jun 2009 14:46:35 -0700 (PDT)
In-Reply-To: <20090622202939.GA11912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122063>

On Mon, Jun 22, 2009 at 10:29 PM, Jeff King<peff@peff.net> wrote:
> On Mon, Jun 22, 2009 at 07:53:51PM +0200, Filip Navara wrote:
>
>> I'd like to report a bug. There's an incompatibility between the way
>> TortoiseGit sends patches by e-mail and their handling by
>> git-mailsplit. The mail sent by TortoiseGit specifies the Content-Type
>> header as "Content-Type: text/plain;
>> boundary=WC_MAIL_PaRt_BoUnDaRy_05151998". git-mailsplit then
>> misinterprets it and treats it as empty patch. While TortoiseGit
>> should not be sending the boundary parameter, it is perfectly valid
>> e-mail according to RFC 5322 and MIME RFCs. The "boundary" parameter
>> should be ignored for anything but "multipart" Content-Types.
>
> That seems like a bug in TortoiseGit, and I don't know if it is worth
> git trying to work around problems in something that is not even close
> to a 1.0 version.
>
> Still, it is good to be liberal in what we accept. So maybe the patch
> below is worth applying (I assume from your description it will fix the
> problem you are having, but I didn't actually test it with TortoiseGit;
> please confirm that it helps).

Yes, this patch helps. While TortoiseGit shouldn't send the parameter
in the first place it's still prefectly valid e-mail that should be
accepted. Of course I will report it in the TortoiseGit issue tracker
for fixing.

Thanks,
Filip Navara
