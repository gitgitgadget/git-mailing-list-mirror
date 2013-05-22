From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] prompt: fix show upstream with svn and zsh
Date: Wed, 22 May 2013 09:36:18 +0200
Message-ID: <877gir31ql.fsf@gmail.com>
References: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com> <CAMP44s3uEaG3Y+cVoKhCA-f+hi1VZcCpXO5bYCQLvANDdvYwRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, szeder@ira.uka.de
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 09:36:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf3b2-00026a-Ey
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 09:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375Ab3EVHgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 03:36:23 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60939 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab3EVHgW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 03:36:22 -0400
Received: by mail-ee0-f46.google.com with SMTP id e49so947444eek.33
        for <git@vger.kernel.org>; Wed, 22 May 2013 00:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=BkhRh3ddu2DnRNkIgkoPVh6wjUxqgoWW3Vwt0fm5rJo=;
        b=Q4o3zvCHEIZPPhtCRB/LH4UdWLun2K59txiLIJkkvCmaeTHK81GKCalRkS+TeF17W7
         oJClGsbgVIoxAZ4OILh4XtJFNiJvOxuhl4pVlYdnngKuOkYAqtpGf9JkHz7sSiJyLxxZ
         DrWc63BjzZvdVcfK4/PI8BR4rNvwTlfe21Z9cckDuXK7Rv9P3Nvrp0O3FXloZ0kEDlG4
         Cm37YSpxOxDcNwunZ6SoYnf2jr+qOhxQIMDt4jpxKLZ2Nn3+upzQJXfM60V/TQ6rrTMq
         wOCaHveUmUSrAdy5iIDQOM2i3lqaBrm86djolxFHWnS1h5Oo2QHTtdImSuzSoTefVOZI
         jZJA==
X-Received: by 10.14.98.71 with SMTP id u47mr16342769eef.12.1369208180869;
        Wed, 22 May 2013 00:36:20 -0700 (PDT)
Received: from localhost (nat5.unibz.it. [46.18.27.5])
        by mx.google.com with ESMTPSA id c42sm8242356eeb.10.2013.05.22.00.36.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 May 2013 00:36:19 -0700 (PDT)
In-Reply-To: <CAMP44s3uEaG3Y+cVoKhCA-f+hi1VZcCpXO5bYCQLvANDdvYwRA@mail.gmail.com>
User-Agent: Notmuch/0.15.2+87~gc75dff3 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225135>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, May 21, 2013 at 3:54 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> Currently the __git_ps1 git prompt gives the following error with a
>> repository converted by git-svn, when used with zsh:
>>
>>            __git_ps1_show_upstream:19: bad pattern: svn_remote[
>>
>> This was introduced by 6d158cba (bash completion: Support "divergence
>> from upstream" messages in __git_ps1), when the script was for bash
>> only.  Make it compatible with zsh.
>>
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>
> This patch is fine by me. I would like to see an example of how to
> trigger the issue with a standalone command in the commit message, but
> it's not necessary. It would also make sense to address the comment
> from Szeder that does raise questions about other places in the code
> where 'array[ $foo ]' is used, maybe there's a caveat we are not
> considering, or maybe your use-case did not execute that code.

Yes, the code was not executed, it will be fixed in the re-roll.

> And finally, I don't recall seen 'set -a' used elsewhere in the code.
> If memory serves well, we have replaced 'local -a foo=value' with
> 'local -a foo\nfoo=value' before to fix zsh issues, I think that would
> be safer.

Yes, thanks for the suggestion, that works.

> But this patch is needed regardless, that, or the patch that broke
> things should be reverted for v1.8.3.

I don't think anything should or can be reverted, as this code was
introduced in 2010, but nobody triggered it until now.

> Thomas, if you don't have time, let me know and I can take a look.
>
> Cheers.
>
> --
> Felipe Contreras

Thanks,
Thomas
