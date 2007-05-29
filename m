From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 3/3] builtin-pack-object: cache small deltas
Date: Mon, 28 May 2007 17:33:51 -0700
Message-ID: <56b7f5510705281733q2f5e7063j7e349b1a3821acc0@mail.gmail.com>
References: <11803872591522-git-send-email-mkoegler@auto.tuwien.ac.at>
	 <11803872591103-git-send-email-mkoegler@auto.tuwien.ac.at>
	 <11803872602056-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	danahow@gmail.com
To: "Martin Koegler" <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue May 29 02:34:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hspf1-0000pZ-Fs
	for gcvg-git@gmane.org; Tue, 29 May 2007 02:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbXE2Ady (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 20:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbXE2Adx
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 20:33:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:12976 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbXE2Adx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 20:33:53 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1736209ugf
        for <git@vger.kernel.org>; Mon, 28 May 2007 17:33:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RkC/OeHJQjxHQEbqwB+bnhnwUnEY0wmB9Hiv8UVgQFx9bpJumQ6MMIqymj9DegA/Fq+PL/mXE02Ehc9SbGkCl4gYa+ju1qnOPYzcBZz01gTzpXHJEpElJzVeNUJ31NC1U3g8K1X+7h41cu65h9WEBlaRC63ImVY2YcA6xpMcKyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gSwfZTlcIN5s19dEDZpyEE9J2WOx23NwVCZcLE4uiyXkp0RPZOH+qwoXhflJzQlEReTtWGNAUB2EnZuTDRBqsfsDYhFLTJIStNHiSyxGsKMimoGRnvYOB+BZeHdC6/RkVRUfML9QUfWpNYDk7HTR40d0OBNLFUIjHFSOEU1S784=
Received: by 10.78.136.9 with SMTP id j9mr1785832hud.1180398831745;
        Mon, 28 May 2007 17:33:51 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Mon, 28 May 2007 17:33:51 -0700 (PDT)
In-Reply-To: <11803872602056-git-send-email-mkoegler@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48657>

On 5/28/07, Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> ---
> Caching small deltas improves packing time even on small repostistories.
> Repacking git.git with a delta size limit of 1000 brings CPU time from
> 66 to 49 seconds down. A limit of 500 bytes is only two secondes slower.
>
> The implicit cache size limit is (#objects)*(delta size limit).

This patchset appears a lot more robust over more special cases.
Thanks for your extra work,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
