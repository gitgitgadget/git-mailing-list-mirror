From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [Patch] Nice help Output - SmallProjectIdea[1]
Date: Fri, 01 May 2015 21:11:12 +0200
Message-ID: <87wq0sw1tb.fsf@hank.tgummerer.com>
References: <CAKB+oNvZxueR9PqysPn3khQZL+8tt3NNrgFzNjHnVuBVtyeZ4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Alangi Derick <alangiderick@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 21:12:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoGMN-00053T-HZ
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 21:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbbEATLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 15:11:15 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:32883 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbbEATLP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 15:11:15 -0400
Received: by wief7 with SMTP id f7so37145214wie.0
        for <git@vger.kernel.org>; Fri, 01 May 2015 12:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:in-reply-to:references:user-agent:date:message-id
         :mime-version:content-type;
        bh=WHC+EvuKacoD4S/p0McU5ox1ZmV4Flqmh4Y95hqTMr4=;
        b=Iriy7wg0ybjkdpN81SKCbpTTnhdspbFDR13kfiLapfDu4UuZWZaqKT9MU9jvA7XXr7
         n7q6gywoPE8FPMJ+8Ry80wjbcDzwL8c+99PVSzgB70v5H0pTmiCiheDCCn1XotFyKZSD
         lbxTDo3K1zTZvo/v/kiuviuIWwGtXAhgqZn0VeD0TXyeNNFNxcfl1hXgdQwXd1gQNJ51
         zB32l+KqOu3gqP8ADDPeYM2iAAv1lAw1ek5ljgwcJxCIpD9N92tVJqLKGBiim07wUMsJ
         QtVAktXhV6yogFsj/5Y4xZAECXu61X6nvejNYOezo7Schu+NCk+DoW4yfL3b9zzkI8yD
         jIFA==
X-Received: by 10.194.242.101 with SMTP id wp5mr20180598wjc.4.1430507473604;
        Fri, 01 May 2015 12:11:13 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id o5sm8121790wia.0.2015.05.01.12.11.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2015 12:11:12 -0700 (PDT)
In-Reply-To: <CAKB+oNvZxueR9PqysPn3khQZL+8tt3NNrgFzNjHnVuBVtyeZ4w@mail.gmail.com>
User-Agent: Notmuch/0.19~rc1+3~g0d8251d (http://notmuchmail.org) Emacs/24.5.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268174>

Hi,

Alangi Derick <alangiderick@gmail.com> writes:

> This is a patch to fix the problem as given in the site:
> https://git.wiki.kernel.org/index.php/SmallProjectsIdeas

Please have a look at Documentation/SubmittingPatches, on how to submit
well formed patches.  In particular, the following things should be
improved:

- The commit should have a meaningful commit message (See section 2 in
  SubmittingPatches)
- The patch should be created with git format-patch, so it can be
  applied using git am. (See section 3 and 4)
- Your work should be signed off, otherwise it can not be applied to the
  project. (See section 5)

> diff --git a/help.c b/help.c
> index 2072a87..e347bbc 100644
> --- a/help.c
> +++ b/help.c
> @@ -229,9 +229,18 @@ void list_common_cmds_help(void)
>
>   puts(_("The most commonly used git commands are:"));
>   for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
> - printf("   %s   ", common_cmds[i].name);
> - mput_char(' ', longest - strlen(common_cmds[i].name));
> - puts(_(common_cmds[i].help));
> + if(i%3 == 1){
> + printf("   %s   ", common_cmds[i].name);
> + mput_char(' ', longest - strlen(common_cmds[i].name));
> + puts(_(common_cmds[i].help));
> + printf("\n");
> + }
> + else {
> + printf("   %s   ", common_cmds[i].name);
> + mput_char(' ', longest - strlen(common_cmds[i].name));
> + puts(_(common_cmds[i].help));
> + }
> +

Patch formatting issues aside, I don't think this does what is suggested
in the project.  You are just adding a blank line after three lines in
the help output, which I don't think improves the current state by much.

The bzr help output on the other hand groups similar commands together,
and shows them to the user in groups.  So the first step would be to
find out which commands should be grouped together and then to output
the groups here.

>   }
>  }
>
>
> Regards
> Alangi Derick Ndimnain
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
