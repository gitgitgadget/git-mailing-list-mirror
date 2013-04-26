From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 12/20] remote-bzr: split marks file
Date: Fri, 26 Apr 2013 18:36:19 -0500
Message-ID: <CAMP44s2dzV428+_ZENg_Z5n=rnvqz1ZNAxnjsqCtLSJK-9PZZg@mail.gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
	<1366938488-25425-13-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 01:36:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVsBl-00043f-Q6
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 01:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab3DZXgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 19:36:22 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:50831 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890Ab3DZXgV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 19:36:21 -0400
Received: by mail-la0-f45.google.com with SMTP id el20so1099338lab.18
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 16:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=y974gZiP9pNzMuSnmuVwvmkvq7i9bpUpQJcAIWwGgEU=;
        b=hlCf3JH8FdHyNpf28OQW5MKsGRLJpdkpb3Wo9sSh6s2bViSX/N/3/l2KOTELXAA7vf
         jk5Yq1SgVzqf8nZy+O8x1x15h6R9Ry7QXf57XO+yRNhYzQQ7A14Ky9JRnjS7wTvDvALM
         zQ4wsSSY1pzuTI6+O7itZnwt1d605U1weKI5UEIq1rkFoGDaPHETRsTnL/qxzyySdjfm
         yQlL8nNPD65Wz324DsQeZIqY9i0olR+xVUwUxM01wT3rzIxBmATdK/GBL/0IZUC5pIRP
         LKRBF2j6PIr2cFZtrqPwX/lW/5bj8WalEKcemhSIy8bqI5notrb07EOCeCBdI42Q7mn3
         zRGA==
X-Received: by 10.112.146.133 with SMTP id tc5mr22773193lbb.88.1367019379833;
 Fri, 26 Apr 2013 16:36:19 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 16:36:19 -0700 (PDT)
In-Reply-To: <1366938488-25425-13-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222607>

On Thu, Apr 25, 2013 at 8:08 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This way all the remotes can share the same git objects, and the same
> marks. The information we want to store per remote is very small.
>
> The code transparently converts from one organization of marks, to the
> other. It's rather smooth and there shouldn't be any issues.

Please drop this patch. While testing essentially the same
functionality in remote-hg I noticed that it doesn't work when dealing
with more than one remote. It's not clear if the marks can be shared
at all, and if possible, it would be very tricky.

Better drop it for now. I've tested that dropping this patch doesn't
cause an conflicts for the rest of the series.

And in case anybody is thinking that remote-bzr is really a too fast
moving target; even if this managed to land in 'master', it's likely
that people were not able to push at all, and in fact, many were not
even able to clone in 1.8.2. So, hardly could be considered a
regression. Nevertheless, I caught it in time.

Cheers.

-- 
Felipe Contreras
