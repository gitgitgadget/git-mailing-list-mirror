From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 00/11] Untracked cache improvements
Date: Tue, 19 Jan 2016 15:43:43 +0100
Message-ID: <CAP8UFD27rFvCrPPs7q+bve9VoyXcg2bBjkz96VfaUm8TDh4c9w@mail.gmail.com>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
	<569A5A66.3090907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 19 15:43:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLXVe-0004s0-15
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 15:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbcASOnq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jan 2016 09:43:46 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33060 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbcASOno convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2016 09:43:44 -0500
Received: by mail-lf0-f65.google.com with SMTP id z62so14075624lfd.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 06:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ID1v4NfZbtpS/O2JLKJG61oVUwVB6JCfna63/8tw5HY=;
        b=nArYjDsBL6G4tejH++TgHGmKacGYpLSg8r7VGJrCOjk387dcf+/6f+U6mDLNflf+RO
         0C7tfS8CPISTIfOvIK/7QegFYtgdCNrMMO4M8y9LSTMlnTaPo3jWlU1lCOpqO7GOYZHE
         Bv25pgbWhds0NT1qiJCfU7sSWvfGKsNXSIyHpMkOXOjQElo7eEF8AGk3V1jMwOe5Glcd
         Fjk2DUxJPiPKIiOwhAFyBVyUULjii43ClpsYn3roEkzX/gUGvKyuo8yFFzH/yBiMRXKs
         fSni8bZ+SNfpS+BJfmeUd5+sX6kp+DNS2R8FgI5Y/K2QkF18+Uj/LYKzvjK5irpIGHWH
         wTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ID1v4NfZbtpS/O2JLKJG61oVUwVB6JCfna63/8tw5HY=;
        b=fMhBsBNu4EyaOrkB0jubWixo/v/y+0Y0GSmjmg/UMGZzMJ+iXUp3SXtwdNCvylSGOb
         GkEFw7TQeK0k8YuqQgC8M8viI8Z0W63r1FQTbtFSpZCbbZ6vX8yG0h1/zB6RxXEj+07e
         7BDqpJgcpluwwMz9+XflnopjXTEgXiJq5PYXFdIZrqqHEARnXLtvY59u6PXlrSEwPDCX
         kZqbGbUepGcNUaZ0CnyRcySEqB5IDdjCxekWoAgPwyCLfuIMN2etR7+A4bz2EEc3L0AF
         skxvSL8oxv0eYIgqqiVvY82UN63qQNzkmoZs/iXwGTsNkHPyTNETAEVA9q81DlFNwDA5
         F+Pg==
X-Gm-Message-State: ALoCoQnQ2tAGFk6hAfN13JpP9KX8E9cWvELVu60BXu7+Gr/DWdviLXv319txQQdLmJxd9JOdi1L4Wy8MvVtAiXLekL5UkrnbJg==
X-Received: by 10.25.205.76 with SMTP id d73mr10774436lfg.76.1453214623495;
 Tue, 19 Jan 2016 06:43:43 -0800 (PST)
Received: by 10.25.216.143 with HTTP; Tue, 19 Jan 2016 06:43:43 -0800 (PST)
In-Reply-To: <569A5A66.3090907@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284358>

On Sat, Jan 16, 2016 at 3:57 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> General question after testing UC on a slow network share:
>
> time ./git status
> On branch uc-notifs63
> Your branch is up-to-date with 'cc/uc-notifs63'.
>
> It took 6.27 seconds to enumerate untracked files. 'status -uno'
> may speed it up, but you have to be careful not to forget to add
> new files yourself (see 'git help status').
> nothing to commit, working directory clean
>
> real    0m19.159s
> user    0m0.085s
> sys     0m0.293s
> ----------------------
> Does it makes sense  to hint the user about the untracked cache ?

I don't think it makes sense to hint about it for now.
When more people will have used it for a significant time perhaps.
