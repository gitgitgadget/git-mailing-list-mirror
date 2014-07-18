From: Andrej Manduch <amanduch@gmail.com>
Subject: Re: [PATCH] git-svn: doublecheck if really file or dir
Date: Fri, 18 Jul 2014 06:22:04 +0200
Message-ID: <CAMTKm-7pc5bQB1L3DCJcPRr-3_baWmkRrDopiz_dGXYwyQurXQ@mail.gmail.com>
References: <1405656304-30926-1-git-send-email-amanduch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 06:22:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7zgu-00005s-DV
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 06:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932982AbaGREW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 00:22:29 -0400
Received: from mail-la0-f66.google.com ([209.85.215.66]:48948 "EHLO
	mail-la0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbaGREW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 00:22:26 -0400
Received: by mail-la0-f66.google.com with SMTP id mc6so673559lab.9
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 21:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=bkHGxgInwoEk34rA9N/sj7GiWR9DXWXBSkfe9OUZapk=;
        b=Wd1yIqEXCNssJ6/pI640w+qIW+7vpZbh5S3E1oGpT0D5GJzbzhaDUG0kkJ+7dmkU8W
         x0+iLFAWWvdSfUM57WflLcrkIC+G66hnWBhH6hBalC+uB2sER4ebK8tUqsn6tnxosykA
         a7UGFiL1ZcaGWQ9dk1EghXomVl+kCr+2Tv3WGMGnODgjEv0prTNxhy+4ckaxTrn86j2A
         FM+dRP53WvJ4UQc0geiNBvBoDo8r4wWeEZwLwQNjHR4VgBRHBn92UJlHxbSziFucboV+
         MzbOAvWwfe0SYYAIkG4LczKrTJDxDfoRtk/x/MxTQmh3vJ6HWjQFd1x8gmRTVFgDCRxa
         Yi7g==
X-Received: by 10.152.27.194 with SMTP id v2mr1440838lag.57.1405657344939;
 Thu, 17 Jul 2014 21:22:24 -0700 (PDT)
Received: by 10.112.156.40 with HTTP; Thu, 17 Jul 2014 21:22:04 -0700 (PDT)
In-Reply-To: <1405656304-30926-1-git-send-email-amanduch@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253795>

I'm sorry, i've made mistake in this one.  Please ingnore it. Correct
patch is on the way.

kind regards,
b.

On Fri, Jul 18, 2014 at 6:05 AM, Andrej Manduch <amanduch@gmail.com> wrote:
> * this fixes 'git svn info `pwd`' buggy behaviour
>
> Signed-off-by: Andrej Manduch <amanduch@gmail.com>
> ---
>  git-svn.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 0a32372..c3d893e 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2029,7 +2029,7 @@ sub find_file_type_and_diff_status {
>         my $mode = (split(' ', $ls_tree))[0] || "";
>
>         return ("link", $diff_status) if $mode eq "120000";
> -       return ("dir", $diff_status) if $mode eq "040000";
> +       return ("dir", $diff_status) if $mode eq "040000" od -d $path;
>         return ("file", $diff_status);
>  }
>
> --
> 2.0.0.GIT
>
