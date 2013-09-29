From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 03/44] request-pull: fix annotated tag check
Date: Sun, 29 Sep 2013 10:11:55 +0530
Message-ID: <CALkWK0kDbx_9Sa8r8=55aYwfOtP15rkUik8gwEiHqR8ZgU8DYg@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com> <1380405849-13000-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 06:42:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ8q7-0005EF-TG
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 06:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232Ab3I2Emh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 00:42:37 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:49121 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab3I2Emf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 00:42:35 -0400
Received: by mail-ie0-f175.google.com with SMTP id e14so7202940iej.6
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 21:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DLxe2KuCzDT1Kppq7jg1eI06v5bIX/m71HCaPcWFUnQ=;
        b=aEY+uiVX++W0dCnY/Epvhm3JEIhsFS13RLvG9O5h6m80h3qp8eG1y99242e9L63pio
         w1xANC6sZwmiD7enxzEHXO+oloDImDDzrHyaQegBA5I9/ebCFsFVsFzC/ukDDqXxFdZL
         thoiBCg3RQJl9t8sNGokjHNpu2V1NYohU6+uimDv/akQsWU88VMs6lKa7bEN75f4h+6s
         SQk4dQ7FQFKSM8HqUdH0A6lOsUrUs3uxMRYiRK1NRcztQYeCEbQnai7jTCpNWrEdiJ9w
         +bqF2WajFRTrJJb4U9EbfF6azvR4Z7U+B6qPzLPwAQ66Fn8EHJIeoNDfmVWywaXyrmiD
         Jx+g==
X-Received: by 10.42.51.144 with SMTP id e16mr12156494icg.2.1380429755206;
 Sat, 28 Sep 2013 21:42:35 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Sat, 28 Sep 2013 21:41:55 -0700 (PDT)
In-Reply-To: <1380405849-13000-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235582>

Felipe Contreras wrote:
> diff --git a/git-request-pull.sh b/git-request-pull.sh
> index ebf1269..6348dac 100755
> --- a/git-request-pull.sh
> +++ b/git-request-pull.sh
> @@ -89,7 +89,7 @@ find_matching_ref='
>                 my ($sha1, $ref, $deref) = /^(\S+)\s+(\S+?)(\^\{\})?$/;
>                 next unless ($sha1 eq $ARGV[1]);
>                 $found = abbr($ref);
> -               if ($deref && $ref eq "tags/$ARGV[2]") {
> +               if ($deref && $ref eq "refs/tags/$ARGV[2]") {

I've never used request-pull, but this seems correct.
