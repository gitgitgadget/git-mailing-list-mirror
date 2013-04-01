From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 0/3] remote-helpers: trivial test fixes
Date: Mon, 1 Apr 2013 23:48:29 +0200
Message-ID: <CALWbr2wAJGemYziPsOkArJveK0F+4Pv80gdR1SGUxchb0ci-sg@mail.gmail.com>
References: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 23:49:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMmb9-000458-QB
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 23:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759047Ab3DAVsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 17:48:32 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:49177 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759021Ab3DAVs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 17:48:29 -0400
Received: by mail-qc0-f175.google.com with SMTP id j3so1260918qcs.20
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 14:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=tBAKksPcSY4tmeYm4SaBwuM1EMvXGP+DvGtcQD19lRs=;
        b=y02y3OFNZjLlT+CQgNkW//5DlVjyeX0JleW6ru5B6ZhQ3Y5cgDHbd79i2BqZJMVKd9
         fZDc8tSvpscIVOZjwcYRBCbjQ4Z0fBYk7/bqSJxjnZxLGon3Fh3kzlmIEv5tHon3FyPJ
         37TlKyA/c6cO2Tlx/HhMgYryHx4ls1VLXjh0MgwqpYO0+jGQWOInpYLVJXWRLQVNKeOu
         h72vkFpvD43fz9bG2XAwJcwVmN2qDXlkOsdsONtIBGQH0ATeIXAs/Mq0vfyFzKgFMXHW
         97eWL0QjTeVuNXAmfzlHxctOtpY6DtdVrileHrgihRMmJ6SL3HYee96/KpbCobBveYvk
         4xKA==
X-Received: by 10.224.52.68 with SMTP id h4mr13772080qag.17.1364852909138;
 Mon, 01 Apr 2013 14:48:29 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Mon, 1 Apr 2013 14:48:29 -0700 (PDT)
In-Reply-To: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219716>

I'm having an error in "contrib/remote-helpers/test-hg.sh" and it
reproduces on every version I tested since you implemented it. Is it
something in my environment that would make it wrong ?

Cheers,
Antoine

---
expecting success:
  test_when_finished "rm -rf gitrepo*" &&

  (
  cd hgrepo &&
  hg update -r 0
  ) &&

  git clone "hg::$PWD/hgrepo" gitrepo &&
  check gitrepo zero master

1 files updated, 0 files merged, 0 files removed, 0 files unresolved
Cloning into 'gitrepo'...
--- expected 2013-04-01 21:46:32.086796549 +0000
+++ actual 2013-04-01 21:46:32.086796549 +0000
@@ -1,2 +1,2 @@
-zero
-refs/heads/master
+feature-a
+refs/heads/feature-a
not ok 4 - cloning with detached head

On Mon, Apr 1, 2013 at 11:14 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> Here are a few fixes for the test framework on the remote-helpers.
>
> Felipe Contreras (3):
>   remote-helpers: fix the run of all tests
>   remote-bzr: remove stale check code for tests
>   remote-hg: fix hg-git test-case
>
>  contrib/remote-helpers/Makefile          |  1 +
>  contrib/remote-helpers/test-bzr.sh       | 14 --------------
>  contrib/remote-helpers/test-hg-hg-git.sh |  1 -
>  3 files changed, 1 insertion(+), 15 deletions(-)
>
> --
> 1.8.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
