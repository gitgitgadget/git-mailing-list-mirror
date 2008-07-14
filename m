From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Added --export option to git-send-email.
Date: Sun, 13 Jul 2008 23:41:02 -0400
Message-ID: <32541b130807132041jae15352mc605c37386309a3c@mail.gmail.com>
References: <20080710170735.4c5b237a@linux360.ro>
	 <7vskudr11m.fsf@gitster.siamese.dyndns.org>
	 <32541b130807131432j78e5100dyea20893268321466@mail.gmail.com>
	 <7vbq11qxfb.fsf@gitster.siamese.dyndns.org>
	 <32541b130807131444s5e9ea0d6v9610dd5871467fc9@mail.gmail.com>
	 <7vvdz9o2wu.fsf@gitster.siamese.dyndns.org>
	 <32541b130807131521w79cbf23m5934678e68312798@mail.gmail.com>
	 <7vlk05o14i.fsf@gitster.siamese.dyndns.org>
	 <32541b130807131642k1382cf84gdf5e8bb8d2ff4ffe@mail.gmail.com>
	 <7vtzetkviy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eduard - Gabriel Munteanu" <eduard.munteanu@linux360.ro>,
	ryan@michonline.com, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 05:42:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIEwv-0000fV-PE
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 05:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462AbYGNDlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 23:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754313AbYGNDlF
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 23:41:05 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:46812 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbYGNDlD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 23:41:03 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2324704ywe.1
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 20:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JPX94MuIw1Sx6Oj7dofGRT7DDKP3TV4a8zjgkJZsjbo=;
        b=uD1CjAgPoSWESAclFGY625CX3orCKxyYuOksJetCeK1Ml42eKjTsF9VaNA+ygNdVRP
         YzUWWOgLvdfSruk2hvheS0z6kyXsi+2k7cObQa/A4C6p1/y7ATlzIoiHP8IHByXHoTvC
         ZQnU8LulGzzINTfvtgxmw4hmvzzOsWlevlFG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=br/9KQBTJJJFK6McW8nxd7p3nK84pxwXajmcnfGi8agIWG9v0W1zlE0xzaNbFfdqw9
         awczNtu3IvdHrq0WVNV8FRQ7O5PX+9BB7vbwG4rz8srERMc59Sz0VsCPYhtRdpxSenwu
         UohLlJxI3MBHnt/ko0oWPzDWMGDRrbika6eSc=
Received: by 10.150.58.5 with SMTP id g5mr19515433yba.90.1216006862374;
        Sun, 13 Jul 2008 20:41:02 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Sun, 13 Jul 2008 20:41:02 -0700 (PDT)
In-Reply-To: <7vtzetkviy.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88373>

On 7/13/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Avery Pennarun" <apenwarr@gmail.com> writes:
> > If git is going to start actually producing mbox files (as opposed to
>  > just individual messages as it does now), it should probably
>  > explicitly take a stance on the issue...
>
> Yeah, that makes one reason I should not be enthusiastic to take this
>  patch.

Eduard: perhaps instead of a --export option, what about an option to
run an external program that will take the given email on stdin and
process it however you want? ... aha, it seems this already exists in
the --smtp-server option.  So a shell script like this as your
--smtp-server should do what you want:

    #!/bin/sh
    exec sed s/'^\(>*From \)/>\1/'

Thus the result of git-send-email would be a series of emails
concatenated to stdout, with From lines escaped appropriately.

Have fun,

Avery
