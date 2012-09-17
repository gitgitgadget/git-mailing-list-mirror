From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] perf: export some important test-lib variables
Date: Mon, 17 Sep 2012 06:15:28 -0700
Message-ID: <CALkWK0=1_2RfR5_xzjKANEB-DjdGhZ9dVZqwRwaWdSmRqg6X9g@mail.gmail.com>
References: <14709b4345420da36a9152904bef4cc4503f78e4.1331196679.git.trast@student.ethz.ch>
 <1c5b174027fc70f084a6547352596d8c0305f6c9.1331196679.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Sep 17 15:15:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDbB8-0000tZ-87
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 15:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061Ab2IQNPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 09:15:49 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:59078 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab2IQNPt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 09:15:49 -0400
Received: by qaas11 with SMTP id s11so1525644qaa.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 06:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=28jO0owLd+1zPKzTDu6Eirhv0tQ1vn8pprUkHsVh+iA=;
        b=ECKhQUv6BsPMxYB3vDi7nMT6rwLBHlEQrmB4ep46Xe5ChnQxbtvdC2NbpIF6IBr14o
         PnQvCcNEjBoPnRSwd00/JAVVZ5mOkZZXYNio+eIOwPOnWDbNno4XhVcHk+El8JhVnlca
         WJlc/mRslsChSqyxZbH2eJRjUWAl7z3DiijsazrhUO2CMWOxch7AJ/YEgaObG8Cv4U25
         VSiyr8qbAPEnYWzCqGz97PZriv9vdjnKPJ4WS9kv6b12rnD6/geuZQDULe9AHLGeZFJK
         jLRM7WHihZQbe8vZx2EXjrua4w3oDJGk8VUzD4h1hoW0nY+NKixdkLU3YtEt8yKEbiQ5
         ogJw==
Received: by 10.224.31.210 with SMTP id z18mr27230721qac.95.1347887748589;
 Mon, 17 Sep 2012 06:15:48 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 17 Sep 2012 06:15:28 -0700 (PDT)
In-Reply-To: <1c5b174027fc70f084a6547352596d8c0305f6c9.1331196679.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205685>

Hi Thomas,

Thomas Rast wrote:
> The only bug right now is that $GIT_TEST_CMP is needed for test_cmp to
> work.

What bug?  You're exporting it, right?

>  test_perf 'test-lib-functions correctly loaded in subshells' '
>         : >a &&
> -       test_path_is_file a
> +       test_path_is_file a &&
> +       : >b &&
> +       test_cmp a b
>  '

This test fails, presumably because of test_cmp.

Ram
