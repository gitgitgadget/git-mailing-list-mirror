From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] buitin_config: return postitive status in get_value
Date: Sat, 28 Jul 2012 19:59:36 +0700
Message-ID: <CACsJy8BUU13H1tRfTtUme_7u0Jf0upca31U-VNhXva_0R2MLoQ@mail.gmail.com>
References: <1343475730-18743-1-git-send-email-nikolay@vladimiroff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Nikolai Vladimirov <nikolay@vladimiroff.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 15:01:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv6dc-0003jj-4x
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 15:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab2G1NAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 09:00:08 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50944 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab2G1NAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 09:00:07 -0400
Received: by pbbrp8 with SMTP id rp8so6723485pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 06:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XD2HpxZjbmwgPEbjwaMS+q1svMNAl/YT3QOfv71wRug=;
        b=ZNUdOyWMh1bixM4md6MezGSTC78NdahK81SeyG8oKGsNRYvGPYBcYKjW+9pXXT7Em/
         J4W6MU17PGXUyPTpGA6cQsQKNBChn3nLeerVWLiFgGws5a7yvb1aOaGxxSse3t0I3Epm
         qGputNquwWt8r4cGWZgEI13nLEYr0SeT81k4PEetvxM0m6THgg+bZv/8UFizRMcgJe0q
         o+HCfq+ELfnaOqSA41c8Jcg8fN/At71AbYRKgy+29oLK+kFtVKE2Z6QPiiYguhjpceEa
         eDAAbff29Dx8stI3VLiOPFrcdFmcwFhb+ieJUmuUV4yWUxk8paCtg9HYvefeAyzQWXE/
         DhKQ==
Received: by 10.66.73.132 with SMTP id l4mr12235054pav.30.1343480407065; Sat,
 28 Jul 2012 06:00:07 -0700 (PDT)
Received: by 10.68.226.225 with HTTP; Sat, 28 Jul 2012 05:59:36 -0700 (PDT)
In-Reply-To: <1343475730-18743-1-git-send-email-nikolay@vladimiroff.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202432>

On Sat, Jul 28, 2012 at 6:42 PM, Nikolai Vladimirov
<nikolay@vladimiroff.com> wrote:
> Returning -1 instead of 1 results in wrong exit status(255) since
> the output of get_value is passed to exit().
>
> 'git config missing_section' should now return proper exit status = 1,
> as specified by the git config documentation.

I'm curious. Why is -1 (or 255) wrong? It was introduced in the first
version of get_value in 4ddba79 (git-config-set: add more options -
2005-11-20). Back then it returned -1 when there's regex compile error
to distinguish with 0 and 1 (but git-config-set.txt in the same commit
did not get update about exit code). Maybe we should update document
instead of the code.
-- 
Duy
