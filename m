From: Matthieu Stigler <matthieu.stigler@gmail.com>
Subject: Re: Confusion using git on svn server
Date: Sun, 21 Jun 2009 11:09:18 +0200
Message-ID: <4A3DF8BE.2050504@gmail.com>
References: <4A3D4665.9040003@gmail.com> <87zlc258nj.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Weimer <fw@deneb.enyo.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 11:09:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIJ3M-0005wC-93
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 11:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbZFUJJW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Jun 2009 05:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbZFUJJV
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 05:09:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:52609 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbZFUJJU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 05:09:20 -0400
Received: by fg-out-1718.google.com with SMTP id 16so840470fgg.17
        for <git@vger.kernel.org>; Sun, 21 Jun 2009 02:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=yGEflWbT6EcCzcGF7LE50bjNnfHm9kVq8mlTdNkNQi0=;
        b=asYaPrpENtTUs44jnkr/SRxQp2e2qjYbDhk3fnz57Kk6ZfRTM3lqDEJRlcx/IgGqA6
         Kq8c563nl7pEWafTnRWcrZwYMCHhFrdYpWbp7OhKMP8qmlaZjw+vJr/aWSTuY5fBjDJ2
         3eTd/0vaZfFCDuF08uCl4umbcZrh2m4oKi9lg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ZDiuR3TVMAFPAbHHySOZ1SYnjdcDgpE3y1Tk+BYbl59u/8RhLeAJS/O534+sKecpCJ
         rGMR6fm37/GBL16+fUVyaosNG1jqJ8kbShjTN3QEw5nrN/3RLZgJSiYlEC3XQ1m3aZ0V
         fMelr7wGxNxrp0Pa69b+1UkLgVQXe+AKg0V/4=
Received: by 10.86.23.7 with SMTP id 7mr2545078fgw.8.1245575361282;
        Sun, 21 Jun 2009 02:09:21 -0700 (PDT)
Received: from ?192.168.1.4? (adsl-188-155-122-1.adslplus.ch [188.155.122.1])
        by mx.google.com with ESMTPS id 4sm3303962fgg.2.2009.06.21.02.09.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Jun 2009 02:09:20 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
In-Reply-To: <87zlc258nj.fsf@mid.deneb.enyo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121973>

=46lorian Weimer a =E9crit :
> * Matthieu Stigler:
>
>  =20
>> My main concern is that in my git log, I have a commit and its
>> "revert", will it be sent as two different commits to svn? I would
>> love they are not sent at all as they represent a "neutral" operatio=
n.
>>    =20
>
> They will be sent as a separate commits by default.
>
> You can use "git rebase -i git-svn" to edit your local history before
> submitting it, though.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  =20
Excellent! This is exactly what I was looking for, thanks!

I had a minor issue as the commits I wanted to remove (a modif and its=20
revert) were the last one, so I could not remove both in the same time,=
=20
as said:

However, if you remove everything, the rebase will be aborted.


So I just added a minor third commit in order to remove the two first.=20
Is there a better way to do than this workaround? Something with git=20
rebase --onto (two last?)

Thanks a lot!
