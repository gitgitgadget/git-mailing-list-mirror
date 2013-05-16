From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Fri, 17 May 2013 00:04:39 +0530
Message-ID: <CALkWK0=LuycRpuwBMjfiSk9qy2Y6VZsmmhNLpKdovKX4rZ=hTA@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
 <1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
 <CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
 <7v7gj77nt9.fsf@alter.siamese.dyndns.org> <CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
 <CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
 <7vwqqy7v8g.fsf@alter.siamese.dyndns.org> <CAMP44s17aD_ryeGWQazTcJ3nrhe6C9TLhKHhrUnys=Yj_ATa0A@mail.gmail.com>
 <7vzjvu6faq.fsf@alter.siamese.dyndns.org> <CAMP44s3c1vdCn43S=nSzfj=znZ9L_7jH9-+EOY0+SZNnSBTVbw@mail.gmail.com>
 <7vfvxm6biv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 20:35:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud31e-0004n5-B4
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 20:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871Ab3EPSf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 14:35:27 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34507 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab3EPSfU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 14:35:20 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so7299231iej.2
        for <git@vger.kernel.org>; Thu, 16 May 2013 11:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=96bcsn7pxh/agw5owCUqowSzBrnchkle46CqO2OoDME=;
        b=erIIZC3ksZrGkM5cW9TYv15sUzB61dITsQJPlv0oLdOxQKnCqRFq2AKx7fxaKG2YZ6
         IA4rDfx/Oxacb9eo0KliVywGzNY8r5QjNAYFSaVyePhxg+tggKMcHrYfRpuyuCJWR0ov
         G3mNIFtVE2VwcvFTM2dihu2Tvp4U7QDYAZLkR9Z0SYXMdkzRuU1HcwAUwGbmyW2xITXk
         Du8lIg8JWei9UzIjN/ej3bjgTKWjwHO3aqdyLegjI9gRXB+sMHq9y3xaHqJX/dBpuTOT
         EZyl1PFbLR8LlO2PTzvM0Mo7cgbSX77syrPAzN8o0kG5uteDXMocVVKjc+NAkUHxtozB
         uQxg==
X-Received: by 10.50.73.65 with SMTP id j1mr10500466igv.49.1368729319783; Thu,
 16 May 2013 11:35:19 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 11:34:39 -0700 (PDT)
In-Reply-To: <7vfvxm6biv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224609>

Junio C Hamano wrote:
>     (defun linux-style ()
>       "C mode with adjusted defaults for use with the Linux kernel."
>       (interactive)
>       (c-set-style "K&R")

There's actually a "linux" style you can inherit from.

May I suggest looking at Documentation/CodingStyle in linux.git for this:

(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	 (column (c-langelem-2nd-pos c-syntactic-element))
	 (offset (- (1+ column) anchor))
	 (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match (expand-file-name "~/src/linux-trees")
                                       filename))
                (setq indent-tabs-mode t)
                (c-set-style "linux-tabs-only")))))

I use this for everything.
