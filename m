From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Tabs in commit messages - de-tabify option in strbuf_stripspace()?
Date: Tue, 15 Mar 2016 17:48:46 -0700
Message-ID: <CA+55aFyXXHNrJW56A_DKkmrmGpWxeUd6row_ja3bzqhs_yswhw@mail.gmail.com>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
	<xmqq4mc76yji.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 01:48:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afzds-0000k7-KH
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 01:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965314AbcCPAst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 20:48:49 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33244 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965230AbcCPAsr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 20:48:47 -0400
Received: by mail-io0-f172.google.com with SMTP id n190so45376521iof.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 17:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=b1trVy6+54D/XLtXykiPf/HP7KK07qppoa6u1Upec5k=;
        b=xx6vQiAxppDRGc0eXfNzbCpdvzGI8AdQGieW7YV4ComSNjHSp1FzOZkNZDbKicCneI
         Bg/rhqkhjUxHZpl1yH5NHpwZlIcnnq8TIqwe6ZA8thrHTo8H8CAW+/9XIp558r3HXNnr
         hPW+69EEds77ti0NiN2qvqYaXWRWqDjtIeZBFT7Kg5oo3NqURx/77cTbCtMDC/vXspd4
         SykKZ+8c64MVFlN+EmbBfPYv0NLQ6zR3rFeube/9VL8Y+kzhmWdefaURWjYxU4AqCq53
         as7rlRJJxDgIfF0uYelQSJ/f/EsdI1czgWCZaV22hHTH2KUaDzUax4db/1Xo6l6RYLDZ
         +YpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=b1trVy6+54D/XLtXykiPf/HP7KK07qppoa6u1Upec5k=;
        b=PyFUwLYmcofESHR/53jcI7i3Mgxtl6VpJZ3nBnHzp9HllfwtjiOhcAPc2NJurmmeWj
         4lo5imzn3Gxop0/gSE63WZlaaEbxKaMBeC549NdERl0+216Usqut1UxzYvKNQxrcRrD2
         w3w670OeP/w416zhsibfiPrnV2nuchBekg0I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=b1trVy6+54D/XLtXykiPf/HP7KK07qppoa6u1Upec5k=;
        b=erYXvFcYCh/HRgSRKQk9jyQA6Oxf/aZ0gY8YoFsol5MYSAbs58uOkFix0+GG3TzOvU
         26wH811TSAaxtY8vC3aOKkaAIXqwVDPWI2udOVd+sYy3cjigXwsRd+E2P+K5Pc3+QlaQ
         510Zvxy37TV1QpKDFHacyeukeF2F6iKA9dRap5+21t9j5KVRcwx661F8hseWpykRMuDy
         aNsDxK0kNZm/TNELoaDjOISH3VX8abuLLhjO4l9Mb8zBO3v/CmwvXYgtYPUOckllH242
         B4yWbZMujJGnrjCLIGjuCYQNGnTv5JLgtM0Y/pcW010HbAqUWSAFoJ06X24U1qiAmZaM
         uhqQ==
X-Gm-Message-State: AD7BkJJM2nvx97EvcsbGOZBC9f0Tg166+Vn+8s6JE2oiTNDQfKdDnK9n1M4VTRK86rhb4dPFrbfw/n3/BtOeIg==
X-Received: by 10.107.6.224 with SMTP id f93mr1727842ioi.137.1458089326915;
 Tue, 15 Mar 2016 17:48:46 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Tue, 15 Mar 2016 17:48:46 -0700 (PDT)
In-Reply-To: <xmqq4mc76yji.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: y-PivsF6ZDY7ziDCLFW_DspKEQc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288934>

On Tue, Mar 15, 2016 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Wouldn't it be nicer to do this kind of thing at the output side?  A
> stupid way would be to have an option to indent the log text with a
> tab instead of 4-spaces, but a more sensible way would be to keep
> the visual 4-space-indent and do the expand-tab for each line of
> text.

Yes, that would certainly work for me too. It's just the "ascii boxes
don't line up" that is problematic..

(Also people including example source code etc, where the first tab
looks wildly different from the second one)

            Linus
