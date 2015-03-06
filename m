From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] for the SoC15 micro project, Make "git -C '' cmd" not to barf.
Date: Thu, 5 Mar 2015 17:58:50 -0800
Message-ID: <CAGZ79kYh=_U=YPrPU3k22ohtU5vgv_bQaETv+q3Dq+ssd3+A-A@mail.gmail.com>
References: <CAMS+ib3dDP6PmHvLJsSs-6XCy233gxjU6=+_7id8yuk9xTnCJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Prudhvee Narasimha Sadha <prudhvi.sada@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 02:58:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YThXU-0003Gp-7U
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 02:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbbCFB6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 20:58:52 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:42944 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314AbbCFB6v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 20:58:51 -0500
Received: by igkb16 with SMTP id b16so418204igk.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 17:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5duQNQNcZ3X03TXwyXJYpKdO5kHxCIkd3DXhDLrRuPw=;
        b=kNn7UstgHrBqZDYtS1EhsECwWNitJ5eOX+DFVdJK/G1+Nz4eSxjqKVjQhaXFl2uwyZ
         nPi//codiwywQfch3z2LRmTnI83V0YXhuJ91Plih55jwvFAT34RwOuxl7SF6w0LkfcbD
         DVpinJxYYtXnOVCWdS35uZo5MvqyVJoWcz3r4AsxlianE9tyLX5FogBivGdegXa45VXP
         di6NBH1dd4hO7SHJSQ/pe2ne+tctra1rCuu5h8Zieosavhe07JepS9+G02gS7k6Dmkkw
         fCFC0/ROZ11zc8eWLhYipDBC6LDwb1dkWSpTZm5IlgYgSWc975MOJhG0CKjDeSFSDFHo
         4iwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5duQNQNcZ3X03TXwyXJYpKdO5kHxCIkd3DXhDLrRuPw=;
        b=e8PUtOdZ7CZe7Uk5w4GuFFmlftZa3KHN7TZtNclXNrw4MDMXq815H6hbCgbeXOUwY3
         x+uxuLqJBEpmirO4/WmoXLEqLm5pLSLRmGO8xSlv2R+GDilNikzXinj01NXa26IhnCza
         LMTUSWpMnSg5GrOMLxXArYufJM47nCHyPaLnyeiqvJeCN4lLFHUi5x7tbnphckTg+gSL
         bzcYywry94op2icLs/YEtNjhCtrQQvzycnflHH8GehONhL1lW4dKnT6ESI8hI7l65GEv
         oIB2BP8jZ/SGoMBPufoxYMXxay03tOZAJ7jjTJVd//6dPGFBcCbuHOWqu/HD4zxJ8M+e
         n90w==
X-Gm-Message-State: ALoCoQl1u6qL2Cv1hs6tXnOHg3f57i+o4CsZdRGE4wHupC9tRXfVnNZ0VvRAPOh0Q8D39ciRXttj
X-Received: by 10.107.36.9 with SMTP id k9mr25082797iok.2.1425607130704; Thu,
 05 Mar 2015 17:58:50 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Thu, 5 Mar 2015 17:58:50 -0800 (PST)
In-Reply-To: <CAMS+ib3dDP6PmHvLJsSs-6XCy233gxjU6=+_7id8yuk9xTnCJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264885>

On Thu, Mar 5, 2015 at 5:46 PM, Prudhvee Narasimha Sadha
<prudhvi.sada@gmail.com> wrote:
> Hi,
>     here is my patch for the micro project, Please review the code.
>
>
> prudh@prudh-Studio-1569:~/git$ git diff

Please see Documentation/SubmittingPatches and maybe have a look
at the format-patch manpage.

Thanks,
Stefan


> diff --git a/git.c b/git.c
> index 8c7ee9c..364788b 100644
> --- a/git.c
> +++ b/git.c
> @@ -205,6 +205,8 @@ static int handle_options(const char ***argv, int *argc, int
>                                 usage(git_usage_string);
>                         }
>                         if (chdir((*argv)[1]))
> +                               if(*(*argv)[1]==0);
> +                       else if(chdir((*argv)[1]))
>                                 die_errno("Cannot change to '%s'", (*argv)[1]);
>                         if (envchanged)
>                                 *envchanged = 1;
>
>
>
>
> Thank you,
> Prudhvee
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
