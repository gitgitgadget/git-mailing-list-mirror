From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 19:38:05 +0200
Message-ID: <38b2ab8a0808111038q686c9581pb277ab6d2229afd@mail.gmail.com>
References: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com>
	 <48A06659.6010004@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Aug 11 19:39:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSbMR-0004RT-B1
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 19:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbYHKRiM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2008 13:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbYHKRiM
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 13:38:12 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:34949 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbYHKRiK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Aug 2008 13:38:10 -0400
Received: by py-out-1112.google.com with SMTP id p76so1178524pyb.10
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ji1LO5r6SzFh1pavAyRxODhVoorZDYV5SsoIFIeBziQ=;
        b=pMj3ELToOPhQsafSwAIRrg/MLnP7nuMYp2Y4zY3D+dxr4KccgvBsGXsVqqsq9OjEaR
         vu5C6saqb5ZCzKNnHLZguGRjCVGNTASKK6RoXbA8U1kYCbVxyo6tSjH4HnAsptP4liOL
         65sHLllXp8/3LgbTscp9npFbJ41FfM/qc6BUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QFbwSxism3aoVpYVbZ1bYXiF3ekM1WqdpQ0n4urUFAr8IB7ovWiJtNgyyh0Quqa6MP
         is+2JwX4XyFJu+JO+UPBE2pbxCwgovkPV7lrpXHEl7dTgmx7JSW86jNkbzLZhS5aiD5S
         OsFZWeVifa3jjCo2cT9QNlNlR9SbM/8Us6408=
Received: by 10.140.127.13 with SMTP id z13mr3675488rvc.194.1218476285519;
        Mon, 11 Aug 2008 10:38:05 -0700 (PDT)
Received: by 10.140.170.16 with HTTP; Mon, 11 Aug 2008 10:38:05 -0700 (PDT)
In-Reply-To: <48A06659.6010004@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91966>

On Mon, Aug 11, 2008 at 6:18 PM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Francis Moreau schrieb:
>> I found this in git bisect:
>>
>>               printf >&2 'Are you sure [Y/n]? '
>>               case "$(read yesno)" in [Nn]*) exit 1 ;; esac
>>
>> which looks very weird since read(1) returns a status and not the
>> string reads from std input.
>
> Good catch.  You need to press Ctrl-C in order to exit, answering "no=
"
> means the same as "yes" here -- not very nice.  Care to send a patch?
>

done.

--=20
=46rancis
