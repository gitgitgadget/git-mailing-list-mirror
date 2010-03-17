From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 11/16] revert_or_cherry_pick(): get oneline_body from 
	get_oneline()
Date: Wed, 17 Mar 2010 13:09:55 -0700
Message-ID: <780e0a6b1003171309k75b33d3cpb4b1c6370d67942f@mail.gmail.com>
References: <20100317113655.GA25470@progeny.tock> <20100317121546.GK25641@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Monnier <monnier@iro.umontreal.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 21:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrzZK-0008Ob-VJ
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 21:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab0CQUKM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 16:10:12 -0400
Received: from mail-pz0-f200.google.com ([209.85.222.200]:34738 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab0CQUKL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Mar 2010 16:10:11 -0400
Received: by pzk38 with SMTP id 38so1200146pzk.33
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 13:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Lvkig28/gBGdh6vrHgRVxKX1kWhK6dgvr7RV2MLNmAs=;
        b=ulkShf6ZBcp3d7VOLnKvideQLcxBKEaABZ9l1kEHtDXD/ky6rGR6QjwVgWzzNWCA6k
         rzeTx1bh8xaqncFd3z6D7xHCGLc5nQUhE1GXXfZxPXlwSLllUZWlRTAB4mT1+HrdaLis
         c42s1ZGeP1ulEoSZnaZnUAzUn6uCRpxJXxkls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sfqSetEKrvgyxknuF2yBMvAXsENNavN7xFOXszIG9NCR28JA2TRBIsjiybiCV+DyKr
         /fEkWr+cMXVvnzNq1WAVLdgp4coZfRhD77CRTmaULYJn8COYrTJA+lieCD4XED6a+lCi
         zv8hjrWFhtJN6N7P3j9KPJqOMgrDSvyKgI4/I=
Received: by 10.142.2.20 with SMTP id 20mr785756wfb.233.1268856610140; Wed, 17 
	Mar 2010 13:10:10 -0700 (PDT)
In-Reply-To: <20100317121546.GK25641@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142437>

On Wed, Mar 17, 2010 at 5:15 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>
> Maybe the next few patches should be squashed. =C2=A0They are separat=
ed one
> commit per idea, but they affect the same code.
>

Could all this code just use the custom format printing routines in
pretty.c? It might not be super efficient but at least it wouldn't
duplicate a bunch of code.
