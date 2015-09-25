From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v7 0/7] git-p4: add support for large file systems
Date: Fri, 25 Sep 2015 10:00:10 +0100
Message-ID: <56050D1A.2000204@diamand.org>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com> <CAE5ih7_PBRMgobhBATUMOaRH8yPWWnEVDiFVdk+qjRzoyPq+CQ@mail.gmail.com> <CE59FE83-4EE1-41EF-85B6-63EA51BD9E3B@gmail.com> <A29B974F-2B42-475F-92B6-8B25A54FCDEE@gmail.com> <CAE5ih7-NqSd+zSqTungDt5oWzy4QT--vjYaShd=YDzGxHosz3A@mail.gmail.com> <ECBECF84-28A9-4E10-907C-8E670F864A25@gmail.com> <CAE5ih7_StiXA-c5yER9jhc941vsKfvEUONLXQ4E7JANOhCxMxQ@mail.gmail.com> <CAE5ih7_m050wcWZ+7UvL3GscKgSxLWGT+bj4_gSVA8R7RZm=tg@mail.gmail.com> <F05CC31A-ECE2-41E4-9805-F1747DD02713@gmail.com> <CAE5ih79OBdGP-PgoYWKBn3_xv-w6dfN-3u0iPBDjWbQb_MMbsw@mail.gmail.com> <571C8128-DFB9-457F-97AE-8F6BC0579465@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 11:00:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfOrs-0000qp-Uw
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 11:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542AbbIYJAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 05:00:22 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37060 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755490AbbIYJAU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 05:00:20 -0400
Received: by wicfx3 with SMTP id fx3so10626253wic.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 02:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=AeIrMw6lCFgLUa2JpRyBLJ9bJkNf8PcDfXoilbEQEEk=;
        b=Fk+IS28g36f/cC7dX0wxZ3u/odVSN37Dq6OqHKzYzmZrYTdUhO1IoHUo7Zm6C7ik9l
         PxivQIclLHTcejZ05fT3dWFjQAydYSaf+vp0wg45nU9Ag3dXOIGL8IS4Cqp+Dgl4mu77
         v0BMYI1GnXgB5wwhOfCNuZlWv258spd1hZuvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=AeIrMw6lCFgLUa2JpRyBLJ9bJkNf8PcDfXoilbEQEEk=;
        b=NG8GWEmFyx5u2UUsS83jZV1PLWWWopoNTR/B7YCQG7EsWl64NjLMS/a2L235bJHzSL
         TZNjcVTw0jw7+O/YsMfsUUni5F6Yf74AHmejzHsxoS5LbHZYWfwr9OYZ+G0O+hvNp/dh
         7OPFibRmFaIn+OAOLK9zEeQLJTD8QO1pKjFsYbdjWrFNMKC6p+83HYFR3lyQQylOo1jq
         Vd3mTIr50WAXa0dfxicDDxAIVY2dqIvXWhhV0Io6Swae+O8eR3apNUdmSFhWuDE6P/RR
         2dvxXo01lEsXaxh6V/G16xnYAT4/i50AKeOqHnNYph1spuO0xx26gL8guTLMZdadgqsl
         5BoA==
X-Gm-Message-State: ALoCoQkYkMmGBN2jZl/hpcSvkPJ1c+bx1QT0AIugGEQi1c6hWD2vet02lff8sEfJoQCQ3rzi/IkC
X-Received: by 10.180.210.162 with SMTP id mv2mr1936477wic.47.1443171618704;
        Fri, 25 Sep 2015 02:00:18 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id jc9sm2200493wic.6.2015.09.25.02.00.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2015 02:00:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <571C8128-DFB9-457F-97AE-8F6BC0579465@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278653>

On 25/09/15 09:35, Lars Schneider wrote:
>
>>   size: 3       flags: 0
>>
>> What's going on?
> I believe this is correct. Git-LFS uses the clean/smudge filter to replace the LFS pointer with the actual file on checkout. Therefore you see the actual file!
> You can find details here: https://github.com/github/git-lfs/blob/master/docs/spec.md#intercepting-git
>
> Can you run `du -hs .git/objects` in your Git repository? This should report a value well below 16 MB.

It does, thanks!
