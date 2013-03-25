From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/3] git-merge-one-file: revise merge error reporting
Date: Mon, 25 Mar 2013 15:24:12 -0400
Message-ID: <CAPig+cRu8-6pNWbDXrPqU-yW5NDKY9WsE2wFY65303t2RpzZvQ@mail.gmail.com>
References: <CAJDDKr4swZzzv3e+Huz72CVmisFKU8T74jFj3-uGmZHReRGVBw@mail.gmail.com>
	<1364127985-13366-1-git-send-email-kevin@bracey.fi>
	<1364127985-13366-4-git-send-email-kevin@bracey.fi>
	<7vk3ovz9zb.fsf@alter.siamese.dyndns.org>
	<7vfvzjz9ej.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kevin Bracey <kevin@bracey.fi>, Git List <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 20:24:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKD0e-0001AL-Kh
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 20:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758862Ab3CYTYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 15:24:15 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:56026 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758853Ab3CYTYO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 15:24:14 -0400
Received: by mail-la0-f43.google.com with SMTP id ek20so12152958lab.30
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 12:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=L4MIMyDZH/YSko4HyrBg8p8qpEVpb8WyvGpf6KgfUyY=;
        b=DE9SaE5UgqqOfUKvfjOfb93i56uiTMpN/Ps4pST8jp7r/jlPSNghuPwBLIT0+/Da7g
         YEdgGzooroyleGkLZ1QjQSE4ZHRShRiKmqZhl/dMccNE4Zllk04nJqjt17+1cho6dTvK
         HSaRdixxoRhGQpQGzoFo7st/mZZyD/SN1/Nq7SguUGQLrcnRR9/xty/jjdDoSP1GWb0T
         Rg/QwjSfLcj4GNT2kyFF0DL4cr8/bYWnUS6klO8eWyyoe1vKbYLK53hDK7NhRTXpi4BZ
         txNnYZ5lFwTPSmeAGBXgm+xEzqAI+nwTtszWUMEsAjAZgOuh7Z9NRU9V4kIi4HKljMxG
         4sDQ==
X-Received: by 10.112.143.129 with SMTP id se1mr730181lbb.120.1364239452375;
 Mon, 25 Mar 2013 12:24:12 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Mon, 25 Mar 2013 12:24:12 -0700 (PDT)
In-Reply-To: <7vfvzjz9ej.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: rHsQrodkntNQWWAFkYFcYeJhsKk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219068>

On Mon, Mar 25, 2013 at 1:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] merge-one-file: force content conflict for "both side added" case

s/both side/both sides/

> Historically, we tried to be lenient to "both side added, slightly

Ditto.

> differently" case and as long as the files can be merged using a
> made-up common ancestor cleanly, since f7d24bbefb06 (merge with
> /dev/null as base, instead of punting O==empty case, 2005-11-07).
> This was later further refined to use a better made-up common file
> with fd66dbf5297a (merge-one-file: use empty- or common-base
> condintionally in two-stage merge., 2005-11-10), but the spirit has
> been the same.
>
> But the original fix in f7d24bbefb06 to avoid punging on "both sides

s/punging/punting/

> added" case had a code to unconditionally error out the merge.  When
> this triggers, even though the content-level merge can be done
> cleanly, we end up not saying "content conflict" in the message, but
> still issue the error message, showing "ERROR:  in <pathname>".
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
