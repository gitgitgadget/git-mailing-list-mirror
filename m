From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/5] port --ignore-unmatch to "git add"
Date: Thu, 13 Aug 2009 23:51:33 +0200
Message-ID: <81b0412b0908131451q651b40a5q187257b7bda93b0a@mail.gmail.com>
References: <200908121726.52121.luke-jr@utopios.org>
	 <1250133624-2272-1-git-send-email-luke-jr+git@utopios.org>
	 <7vy6pna4lu.fsf@alter.siamese.dyndns.org>
	 <200908131540.49701.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Dashjr <luke-jr+git@utopios.org>, git@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 23:51:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbiD5-00026O-Mg
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 23:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbZHMVve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 17:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753590AbZHMVve
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 17:51:34 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:55508 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbZHMVvd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 17:51:33 -0400
Received: by bwz22 with SMTP id 22so848468bwz.18
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 14:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BU8foi5SqekP1zphQRiATl48eHUXLwo5k+VuUCp3YVY=;
        b=r/wWDUn8rWMLEyWspWyDQNguXunPMrJ58JAN88LqcTkpfPwcv6IDqlrPlUa+smhFRF
         b7jcWUR5/41lQKE8nuU6rKA1Cri8rHCI94gApJFi0O99TyWvdgwDagcdhG1fJ0Dvm1kY
         lKTF1EPIuD0RUC6N0k0eXX7ZlTG05wlRJBC3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mPcUP+IPWhrJjYnUFg4+glhpELTrs2CQa5eUnZgXHNijLjWuj4goS95SN4JXbE8pwi
         Q/aNHEbFV1FIMXCkrFl/FjeBdOz0mnhn0vd3t6ApG+Ehgd57AjRYRimH4124w7Ca0New
         x8sSznq00xe2DuewNQr81cKQTXr0740WBgsFE=
Received: by 10.204.15.6 with SMTP id i6mr868438bka.59.1250200293973; Thu, 13 
	Aug 2009 14:51:33 -0700 (PDT)
In-Reply-To: <200908131540.49701.luke@dashjr.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125882>

On Thu, Aug 13, 2009 at 22:40, Luke-Jr<luke@dashjr.org> wrote:
> On Thursday 13 August 2009 02:36:13 pm Junio C Hamano wrote:
>> Now the obligatory design level question is behind us, let's take a brief
>> look at the codde.
>>
>> > +static int ignore_unmatch = 0;
>>
>> Drop " = 0" and let the language initialize this to zero.
>
> Does C define a default initialisation of zero? My understanding was that
> uninitialised variables are always undefined until explicitly assigned a
> value.

Yes. For statics.
