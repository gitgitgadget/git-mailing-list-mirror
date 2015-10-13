From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/10] ref-filter: add support for %(upstream:track,nobracket)
Date: Tue, 13 Oct 2015 12:09:34 -0700
Message-ID: <xmqqmvvma8lt.fsf@gitster.mtv.corp.google.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<1444295885-1657-9-git-send-email-Karthik.188@gmail.com>
	<CAOLa=ZRZszOqHqJfOHhFqa-XDZbrcPCuSdvM_zMEYHURv8kW_A@mail.gmail.com>
	<vpqeggy61ma.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 13 21:09:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm4xA-0004Ys-JI
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 21:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbbJMTJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 15:09:36 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35299 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbbJMTJf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 15:09:35 -0400
Received: by pabve7 with SMTP id ve7so29732149pab.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 12:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Wo6EWRJnyNtm+xkdblCeKr3SVsamVQ/hXHq00TCKp3E=;
        b=JHyak1Sp6Fu2xnBEW65OUFDCMYDSpPdPeSYdzzIHTfvD+R9k4AER+PKRadrjKP/p40
         MxlToU7BF1Dv4DCIJMxZS55c58BaIkwE+rVGhf+R7s5Ye8+Rrt+OYub3BHtrMbvLLdll
         o+P0QA7iOnK18n2OgTSWIcn5/d92tUmlossDvyim4up+chQO2urVvMbkwvXICB5YtJqe
         J9eyDTU5S+2frDpfpdl3LZ1TUHLvvW2wG1eM7Xxr8GIdvKvg3Jd6K+sIQRREs29EDDwa
         Dt4S77rDhhC7RsQ5mj+4dT2DFmI2oxLKg46OmEwPUzj/hiO1SifWZEcc/B+o9bsQV3EG
         F6Qg==
X-Received: by 10.68.91.193 with SMTP id cg1mr42344872pbb.98.1444763375384;
        Tue, 13 Oct 2015 12:09:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:495:58e7:6a27:bf4d])
        by smtp.gmail.com with ESMTPSA id uc1sm5292111pab.20.2015.10.13.12.09.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 12:09:34 -0700 (PDT)
In-Reply-To: <vpqeggy61ma.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Tue, 13 Oct 2015 20:54:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279515>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> If you see here, we detect "track" first for
>> %(upstream:track,nobracket)
>
> Yes, but I still think that this was a bad idea. If you want
> nobracket to apply to "track", then the syntax should be
> %(upstream:track=nobracket). I think the "nobracket" should apply
> to "upstream" (i.e. be global to the atom), hence
> %(upstream:nobracket,track) and %(upstream:track,nobracket) should
> both be accepted.

That makes sense to me, as I think what is being discussed would be
%(upstream:track=yes,bracket=no) when it is fully spelled out.
