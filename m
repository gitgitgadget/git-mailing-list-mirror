From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Funny error with git gc...
Date: Fri, 15 May 2009 14:24:19 -0400
Message-ID: <32541b130905151124l40194e3eq78411c5b94bd9598@mail.gmail.com>
References: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302> 
	<7vmy9etey8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 20:25:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M525S-0002By-PU
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 20:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbZEOSYl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2009 14:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752981AbZEOSYk
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 14:24:40 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:17873 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbZEOSYj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2009 14:24:39 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1191395yxj.1
        for <git@vger.kernel.org>; Fri, 15 May 2009 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QGSKWXYQBiQQBfNLLVg60Wk4/tBxom6mheXOMb/YV3s=;
        b=ggPluzyfmchRnjSZuGcWdh6Ve12HB926a4mLIp3yvTlAZwRQom5LhelyI6e7UrUABp
         yZNhlIEyOhrKp5U2FXpObZIn3YyngxXca5VGeinDLZuvqlnnBLqiNNSyARSRAjhcjWka
         ARt8L0/w0YLVqszmgRdJ2qGhGcEjEn1Kdhw3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jTuVNfEJl28a/wG2vCUXMsaYYg9bd6fhLMQGWcqE3nYsnxbdcDnm2FRLpecb3z9Uia
         3oZvZ0BH7jtK6F55HR/kVopWMzvyh1HGUGIrdw+VWUpe2HGOOtmEkPLTPJ65nIwNRGgA
         KepBsp+ZCAzYRe2gEZzUy04O/knCIQWX8RW7s=
Received: by 10.151.150.21 with SMTP id c21mr6491292ybo.322.1242411879136; 
	Fri, 15 May 2009 11:24:39 -0700 (PDT)
In-Reply-To: <7vmy9etey8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119274>

On Fri, May 15, 2009 at 2:10 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> if you need a chuckle, like me, you might appreciate this story: in =
one of
>> my repositories, "git gc" dies with
>>
>> =A0 =A0 =A0 unable to open object pack directory: ...: Too many open=
 files
>>
>> turns out that there are a whopping 1088 packs in that repository...
>
> Isn't it a more serious problem than a mere chuckle? =A0How would one
> recover from such a situation (other than "mv .git/objects/pack-*;
> for p in pack-*.pack; do git unpack-objects <$p; done")?

I guess if you have root access, you could increase your file ulimit
(-n) temporarily and then repack.  Of course that's not actually
addressing the root cause of the problem.

Avery
