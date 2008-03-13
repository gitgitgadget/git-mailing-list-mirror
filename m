From: Luke Lu <git@vicaya.com>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 13:06:13 -0700
Message-ID: <8F9BA906-777F-4B7D-BA19-D0848D1886B3@vicaya.com>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com> <51ED164C-2269-48B7-B8C9-0E819BFD63EC@vicaya.com> <20080313151532.20d72b14@gmail.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Thomas Harning <harningt@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 21:07:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZtho-00062e-4W
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 21:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094AbYCMUGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 16:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754848AbYCMUGY
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 16:06:24 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:47392 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578AbYCMUGX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 16:06:23 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2168370rvb.1
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 13:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=T0EvRZRsgIyNCQQOumH3rxmiUW2jmpwZPO7o2vsQ+j8=;
        b=jbDaTgexFIF4oRxHAiXLQxGbSwiow4rIJmUMjq0LXb7fmR8KQjf/BvSwQRE7fUKwk1nRYI2FSjpZjgesaU3DRcLgcaUYbLQJKIVfUlgMo4QkpAY/L6kyl3zmrXOC41d60ypTT+jXm+rcU5wOuLLkZMjZ/ieAirS1vh6Rzyck3qs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=Fvn9f0nBzL6LoRWRG2Ouvv3Ue9O09/LM1VxGTx5InUcKLVG1foqdaB9XpO7YCDwhtbS4u6/fRKB+vk2QH5oPKzWRJQW1OV+E0yWfFYaJSfd9MFV4m2q8n1samyAfdlbEQuXF8DgwQ5H1Aq2v2jmQFZfeH1LxNSuucXC6MmiZo9E=
Received: by 10.141.153.17 with SMTP id f17mr4049444rvo.267.1205438782430;
        Thu, 13 Mar 2008 13:06:22 -0700 (PDT)
Received: from ?192.168.100.58? ( [68.167.202.98])
        by mx.google.com with ESMTPS id 43sm19575360wri.27.2008.03.13.13.06.19
        (version=SSLv3 cipher=OTHER);
        Thu, 13 Mar 2008 13:06:20 -0700 (PDT)
In-Reply-To: <20080313151532.20d72b14@gmail.com>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77133>


On Mar 13, 2008, at 12:15 PM, Thomas Harning wrote:

> On Thu, 13 Mar 2008 11:36:46 -0700
> Luke Lu <git@vicaya.com> wrote:
>
>> An obvious and easy solution: use an encrypted partition on the
>> remote server and ssh as transport. Last time I checked, git on
>> encrypted volumes is plenty fast.
>
> If its an encrypted partition on the remote server... then its visible
> @ that server.. which I don't think is desired in the situation.
>
> An encrypted partition is fairly useless on a remote server unless the
> remote server is expected to be physically removed/powered down...
> otherwise anything can get into that data while its alive (pending
> permissions, lack-of-holes, etc..)
>
> The encfs solution makes sure that nothing is ever revealed
> remote-side... all data is prevented from even going over ssh in its
> unencrypted form.

Yes encfs over an sshfs is probably the safest. But it is intolerably  
slow if you need any kind of random access of data, which git does  
all the time. You can mount the encrypted partition using a key over  
ssh per git push or pull to minimize exposure while get the  
performance you want.

__Luke
