From: Emil Sit <sit@emilsit.net>
Subject: Re: [PATCH 2/2] log --author: take union of multiple "author" requests
Date: Mon, 13 Sep 2010 12:17:26 -0400
Message-ID: <AANLkTinaj4AsPE9j-gS2-0Cn8jx7a1uYYGtmq5oC=YVB@mail.gmail.com>
References: <AANLkTikONxneEgF5m+m6100pwzThTnaiAB+OFzYufcC2@mail.gmail.com>
	<7veidlkxdb.fsf@alter.siamese.dyndns.org>
	<7vmxrmawg0.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 18:26:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvBrQ-0005Yq-6H
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 18:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab0IMQ0W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 12:26:22 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39260 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752970Ab0IMQ0V convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 12:26:21 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Sep 2010 12:26:21 EDT
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 96D6DB2;
	Mon, 13 Sep 2010 12:17:27 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 13 Sep 2010 12:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=mime-version:in-reply-to:references:date:message-id:subject:from:to:cc:content-type:content-transfer-encoding; s=smtpout; bh=4LIkNtqKUTVznn+ie4PrizsAPrc=; b=hdiemRoY8Dx4opEkUsMApKN8JE6x62zZn26q9Q3poeIunQI52eksO2V/LEYEriRFOyN7bDEJQLqFr1bPC0iIHjSmkTmAx5qRWbI8BsU1VzNaZaxCY5JcGcufQjlU8fiBM+6EOTN0uRYDrI8yjJY1u6k4WRHVUGOlNfqlwKPXXww=
X-Sasl-enc: eoWLbg3rxZ0FRcu9gcTy5W/wQc04M6CLPUGZSPnKF/6c 1284394647
Received: from mail-bw0-f46.google.com (mail-bw0-f46.google.com [209.85.214.46])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4889C40F569
	for <git@vger.kernel.org>; Mon, 13 Sep 2010 12:17:27 -0400 (EDT)
Received: by bwz11 with SMTP id 11so4617006bwz.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 09:17:26 -0700 (PDT)
Received: by 10.204.51.67 with SMTP id c3mr3359223bkg.69.1284394646402; Mon,
 13 Sep 2010 09:17:26 -0700 (PDT)
Received: by 10.204.73.213 with HTTP; Mon, 13 Sep 2010 09:17:26 -0700 (PDT)
In-Reply-To: <7vmxrmawg0.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156101>

On Mon, Sep 13, 2010 at 4:18 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =A0 =A0log --author=3Dme --author=3Dher \
> =A0 =A0 =A0 =A0--committer=3Dhim --committer=3Dyou \
> =A0 =A0 =A0 =A0--grep=3Dthis --grep=3Dthat
>
> into
>
> =A0 =A0(ALL-MATCH
> =A0 =A0 =A0(OR (HEADER-AUTHOR me) (HEADER-AUTHOR her))
> =A0 =A0 =A0(OR (HEADER-COMMITTER him) (HEADER-COMMITTER you))
> =A0 =A0 =A0(OR (PATTERN this) (PATTERN that)))

Both patches look good to me.  Tested fine with my use cases. Thanks
for doing this.

I'm a little confused about the implementation with regards to
--all-match; does there still need to be an all-match flag?  Seems
like it has now been deprecated (to being, essentially, the default).
In any case, there should also probably something going along with
this patch series to update Documentation/rev-list-options.txt.

Thanks again.

--=20
Emil Sit / http://www.emilsit.net/
