From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/17] Makefile: a dry-run can error out if no
 perl. Document the issue
Date: Thu, 25 Jun 2015 08:24:31 -0700
Message-ID: <xmqq8ub724ls.fsf@gitster.dls.corp.google.com>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
	<1435190633-2208-5-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GitList <git@vger.kernel.org>,  MsysGitList <msysgit@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: msysgit+bncBCG77UMM3EJRBMV2WCWAKGQEEPRYYXY@googlegroups.com Thu Jun 25 17:24:37 2015
Return-path: <msysgit+bncBCG77UMM3EJRBMV2WCWAKGQEEPRYYXY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f57.google.com ([209.85.220.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBMV2WCWAKGQEEPRYYXY@googlegroups.com>)
	id 1Z8911-000156-P4
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 17:24:35 +0200
Received: by pabli10 with SMTP id li10sf18118979pab.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 25 Jun 2015 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=MyxXujggVzVE4kC42f/fFpN4NXnD8lDpD8SH3b4Tic4=;
        b=upt4KyMDUy/Hm5JsZIo8g+p66HkC8egVgSPkSR4hY4fM/UmZA7RehAM+KKLxiENnsi
         Irj3HTv/adCO5NyGq6ZVqSlg/xJ64ob7k1IeJX3CzZ2qVc6hh4W2U+C4aw3gqMyGkNxs
         p8/pZFpr3AQPyL7Mz4zFxBAsgYyjOglyTVo1pySKzKGpfEyFXGGxTO19V8yJpnMsOhh9
         +ZUNZpT9y1oaOydYSorw0IwkkmLKS/qFsNuW+EyeXrRX7XkU0yuU+d6oKUn7N5STSn/K
         dmvhoIUZMKSZQ/86Z2rCa9QebsFvP31l2dM43pnDi5VZrB6k1PucDx0wu5U1Xz0X4oBH
         ZYCA==
X-Received: by 10.50.64.179 with SMTP id p19mr76034igs.6.1435245874404;
        Thu, 25 Jun 2015 08:24:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.132.18 with SMTP id g18ls710672iod.67.gmail; Thu, 25 Jun
 2015 08:24:33 -0700 (PDT)
X-Received: by 10.66.191.195 with SMTP id ha3mr60607717pac.42.1435245873958;
        Thu, 25 Jun 2015 08:24:33 -0700 (PDT)
Received: from mail-ig0-x22c.google.com (mail-ig0-x22c.google.com. [2607:f8b0:4001:c05::22c])
        by gmr-mx.google.com with ESMTPS id fk9si549779igb.0.2015.06.25.08.24.33
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 08:24:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of jch2355@gmail.com designates 2607:f8b0:4001:c05::22c as permitted sender) client-ip=2607:f8b0:4001:c05::22c;
Received: by mail-ig0-x22c.google.com with SMTP id qq3so17209192igb.0
        for <msysgit@googlegroups.com>; Thu, 25 Jun 2015 08:24:33 -0700 (PDT)
X-Received: by 10.50.61.241 with SMTP id t17mr4871590igr.34.1435245873787;
        Thu, 25 Jun 2015 08:24:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id o9sm19779225ioe.35.2015.06.25.08.24.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 08:24:33 -0700 (PDT)
Sender: msysgit@googlegroups.com
In-Reply-To: <1435190633-2208-5-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Thu, 25 Jun 2015 01:03:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jch2355@gmail.com designates 2607:f8b0:4001:c05::22c
 as permitted sender) smtp.mail=jch2355@gmail.com;       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272687>

Philip Oakley <philipoakley@iee.org> writes:

> A 'make -n' dry-run is used as part of the /compat/vcbuild and
> /contrib/buildsystems code. The commit ee9be06 (perl: detect new files
> in MakeMaker builds, 2012-07-27) was not aware of that dry-run usage
> and thus would not execute the target.
>
> Add a comment to the make file stating the issue and the available
> solutions of either NO_PERL or a '+recipe'.

I am not sure what this patch is trying to achieve.

If you are not touching what this Makefile actually does, then I
would imagine that you are running the "buildsystems code" that
actually drives 'make -n' with some "available solution" (perhaps
you are running 'make -n NO_PERL=NoThanks' or something like that)?
Then instead of a command like this that nobody would read in this
file, the same command can instead go there to explain what the
"workaround" (e.g. unusual-looking 'make -n NO_PERL=NoThanks') is
doing?

I suspect you mean by +recipe that you modify this makefile to make
such a workaround unnecessary?  If that is the case, why isn't such
a change actually be done with this commit, instead of a comment?

I am not sure what this patch is trying to achieve.

Puzzled...

>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 149f1c7..22108bb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1746,6 +1746,9 @@ $(SCRIPT_PERL_GEN): perl/perl.mak
>  
>  perl/perl.mak: perl/PM.stamp
>  
> +# 'make -n' (dry-run) will not execute this target which creates/updates the PM.stamp file.
> +# To avoid the error of failing to find the target PM.stamp, either use NO_PERL=1 (YesPlease),
> +# or add a leading '+' to the recipe '+$(QUIET_GEN)$(FIND) perl ...' so that it is executed.
>  perl/PM.stamp: FORCE
>  	@$(FIND) perl -type f -name '*.pm' | sort >$@+ && \
>  	{ cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; } && \
> -- 
> 2.3.1
>
> -- 

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
