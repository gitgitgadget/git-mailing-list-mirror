From: Alexander Kostikov <alex.kostikov@gmail.com>
Subject: Re: Rebase doesn't restore branch pointer back on out of memory
Date: Fri, 19 Oct 2012 14:49:11 -0700
Message-ID: <CAGAhT3nNdPxtDKtVCnPAa4OWOhGygzoq6DqHVEckQ60XWAAKZA@mail.gmail.com>
References: <7vtxu4io7o.fsf@alter.siamese.dyndns.org>
	<1349927643-7195-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitster@pobox.com, git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 23:49:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPKRd-00009q-Os
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 23:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933040Ab2JSVtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 17:49:14 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56557 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932148Ab2JSVtM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 17:49:12 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so542221qcr.19
        for <git@vger.kernel.org>; Fri, 19 Oct 2012 14:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dFW4+MuMsX5+cGKEBEDudtM2Mf3Ow+vkIgblC2q7kvs=;
        b=UWttP/00mQITAEO10Z9oGoGV4iXIuHioTAUpWYkEKCnLrKXdz16HyOEzI4ZJ52zyUD
         DD/hiH4fjrjyx9frRB5nXCh03f8kV8711nzxnk9OvVt6B3rAcdE6egHYgFq0+R6ObvCb
         k7WfydcKkQHLExjACSmi8NuKnwXj4U6PG4rlXcPnpn8WJ0sSDBbyoJ8thMGvtko+XcIo
         ygL4SCeW/2uvnWcIuIA8jcyHfHeMMPOtayv3LBKl8VT0kLXzZ7vLdhAcZ5D5DbczBxhZ
         ii7YxqsX/4HiuQCIM4jca/tm5XjRg3toZAYCrzOgnts/yuQL7V1O3Qt36Xzu6Q6BrtOf
         YJZA==
Received: by 10.224.42.139 with SMTP id s11mr1219929qae.52.1350683351965; Fri,
 19 Oct 2012 14:49:11 -0700 (PDT)
Received: by 10.49.98.166 with HTTP; Fri, 19 Oct 2012 14:49:11 -0700 (PDT)
In-Reply-To: <1349927643-7195-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208071>

Sorry to bother but I was wondering what would be the release version
that would have this patch.

-- Alexander


On Wed, Oct 10, 2012 at 8:54 PM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
>
> For the 'format-patch' part, originally I was going to do something like:
>
>         git format-patch ... || {
>                 ...
>         }
>
> But later I thought it's better to use a consistent style as the following
> 'am' part.
>
> For the 'am' part, if we kept the following line at the end of the if-block:
>
>         fi && move_to_original_branch
>
> then, before exiting the if-block, we would have to do something like:
>
>         test 0 != $ret && false
>
> which seems a bit ugly to me. So I removed the use of '&&', and rearrange the
> 'write_basic_state' and 'move_to_original_branch' to make the logic flow a bit
> better and easier to read.
>
> Andrew Wong (1):
>   rebase: Handle cases where format-patch fails
>
>  git-rebase--am.sh | 51 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 45 insertions(+), 6 deletions(-)
>
> --
> 1.8.0.rc0.19.gc58a63a.dirty
>



--
Alexander Kostikov
