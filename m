From: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
Subject: Re: [PATCH] commit: add commit.signoff config option
Date: Thu, 25 Jun 2015 11:55:25 -0300
Message-ID: <CADstYCZ6aDN=CNsX_fEnJmB1xF4L_M=j=G2RuKyfK5wxNkH41g@mail.gmail.com>
References: <1435217558-5866-1-git-send-email-cmarcelo@gmail.com>
	<CAP8UFD1kbu4uB1Xaf_jWdQUBzkSJ-Z3_o3NT0Wb6GNyRG=jSLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 16:55:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z88Yw-0000wD-6G
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 16:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbbFYOz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 10:55:28 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34406 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbbFYOz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 10:55:26 -0400
Received: by ykfy125 with SMTP id y125so41865409ykf.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1udY/+xuQuP29zrF/Og2r28T0OUhLcNKNRyLjkTn4kc=;
        b=VbAemnQuJBTOMaNyZZhyVVCfE0V4uiibgzgX97WGCZEhGpiNmEBbZHGp1iIMI++/hx
         364FH3VJgB5r3URMlxcYd8PXdEbSqQ0f2w7H9D/kMOavjNm6O0aas0iTFnE6YolQZ2lU
         ZhXDGn+j82/ICb37uj6H23mcITDSNxVgjOKh1G1nLPBb8pqeioMFVfGZTfzBouKbruqA
         yZLSGugACgyrihfQeoGUwLWxylk8Pe69ZkpyDWqOJHg2mu0x7U2gGlUOQqZPpkrBxKIx
         kF6fI2e0ftAM76UrZyTU7RdjpgRafY4HlEn3VDLvOyywCTxpD6XRMBj4i37/NXBQUZAF
         pEVw==
X-Received: by 10.129.16.215 with SMTP id 206mr34846797ywq.13.1435244125588;
 Thu, 25 Jun 2015 07:55:25 -0700 (PDT)
Received: by 10.13.213.142 with HTTP; Thu, 25 Jun 2015 07:55:25 -0700 (PDT)
In-Reply-To: <CAP8UFD1kbu4uB1Xaf_jWdQUBzkSJ-Z3_o3NT0Wb6GNyRG=jSLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272679>

On Thu, Jun 25, 2015 at 5:43 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> You can use a commit template.
>
> Or you can use the "commit-msg" hook. For example with commands like:
>
> grep "^Signed-off-by:" "$1" ||
> echo "Signed-off-by: $(git config user.name) <$(git config user.email)>" >>"$1"
>
> If you have more complex needs, there is also "git interpret-trailers"
> (see the examples in the man page).

Thanks for the references. I was initially using a commit template to solve
the problem. But I've considered that since we already handle
"Signed-off-by" somewhat specially (e.g. "commit -s"), and how common this
case is, it was worth adding a config option.


-- 
Caio Marcelo de Oliveira Filho
