From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to 
	efficiently lookup sha1
Date: Sun, 5 Apr 2009 12:17:32 +0200
Message-ID: <fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 12:19:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqPRk-0004tK-4s
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 12:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756952AbZDEKRv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 06:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756248AbZDEKRv
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 06:17:51 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:25640 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756196AbZDEKRu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 06:17:50 -0400
Received: by fk-out-0910.google.com with SMTP id 18so686215fkq.5
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SqMNGumhNeupra7ggIJ8KlL8Vl02MfkSw1ieuttcO38=;
        b=vbyqbd/qhv/PCDEYB0BShyqorZOQwpuZs36kohdAYPkM0LWwjcoWV6DlPvk4ZH1pir
         XpAVrYFC3Z24JbSXYd+9e8auIywa4ldB5qyQpd4m86wjBfjLbBIvhml9SVkGQp2/j/xr
         XHDqDUoiz/iuKRmblXSKpXR+Qty52JJZUzO0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dApHKTVSBJsKjekWMLuEtleyCDSX89knB1cf2qy7yY/DR+plv10AI4vj5JRnfCAttp
         1QzX2o0E2pE+M56EXUOZgNY1EbJIURVgtn2ETnhfi9PX6NK6jsTr1nGt2mQhfqG3m2F/
         4M33XcDSK8YUz1uH+iplLm7M4mGyE5eGfwJoQ=
In-Reply-To: <20090404225926.a9ad50e0.chriscool@tuxfamily.org>
Received: by 10.103.225.11 with SMTP id c11mr1395857mur.115.1238926667204; 
	Sun, 05 Apr 2009 03:17:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115653>

Heya,

On Sat, Apr 4, 2009 at 22:59, Christian Couder <chriscool@tuxfamily.org=
> wrote:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lo =
<=3D mi && mi < hi)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("oo=
ps");

That's going to be an official git error message? Why not make it "The
fatal error oops has occured, press ctrl-c to lose all your work, or
press any other key to do the same"?

--=20
Cheers,

Sverre Rabbelier
