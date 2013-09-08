From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] Teach git to change to a given directory using -C option
Date: Sun, 8 Sep 2013 06:32:07 -0400
Message-ID: <CAPig+cRt9o=6Amhx6qTkzfk5R9aQfRZ=357BOVELm_hPsWE3WQ@mail.gmail.com>
References: <20130903115944.GA29542@gmail.com>
	<xmqq8uzdplqv.fsf@gitster.dls.corp.google.com>
	<CAEY4ZpN4xgt+gJSVeTfDNC--xt3N+M7vVLFBC7FTWBQtjvN8tw@mail.gmail.com>
	<20130904122020.GA25538@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 12:32:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIcHu-0005us-Ho
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 12:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab3IHKcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 06:32:10 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:33469 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab3IHKcI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 06:32:08 -0400
Received: by mail-la0-f50.google.com with SMTP id es20so4073225lab.37
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 03:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=grIFqpmDNk0f+BY7Pr+h8yZR/j91q47YNtI5Z6TBT20=;
        b=W+Fu0lNBpG3MZ9UvP6+F7Bygw/egSSpt728m2Cq6Sve0cf3SeNEk/FaSqz6RRuGkih
         p2W5NT8XEmR+SPb2S1kaX/yUdmSnoUyoTdScYrls7t+aTQTpFTOaZBoMT6VODM2+02LR
         QVMvyPj3jVjEXe1QreUA4MsbKm5qEQ6LVN+lcZgSmPh9QO2TJZMk4oAKLSzXv24g5GxK
         N4YokcZnw6dJOQQGtJmLJ99IXDXMcc0AdBOR85GMdAnQzsRSSUVfKNcM32GuSOlP2ByO
         6TYSz7iVvEIFBn2aJMXklmGxpV5sSberonoveDG2qnBSdfkhnLe99jNECSWDQDd0jZrt
         ywGw==
X-Received: by 10.152.120.37 with SMTP id kz5mr11097454lab.21.1378636327191;
 Sun, 08 Sep 2013 03:32:07 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 8 Sep 2013 03:32:07 -0700 (PDT)
In-Reply-To: <20130904122020.GA25538@gmail.com>
X-Google-Sender-Auth: ZB9iVFUmicNB-fzBftEejmWLWAc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234234>

On Wed, Sep 4, 2013 at 8:20 AM, Nazri Ramliy <ayiehere@gmail.com> wrote:
> Subject: git: run in a directory given with -C option
>
> This is similar in spirit to to "make -C dir ..." and "tar -C dir ...".
> ---
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 83edf30..ae049da 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -395,6 +395,20 @@ displayed. See linkgit:git-help[1] for more information,
>  because `git --help ...` is converted internally into `git
>  help ...`.
>
> +-C <path>::
> +       Run as if git was started in <path> instead of the current working
> +       directory.  When multiple -C options are given, each subsequent
> +       non-absolute "-C <path>" is interpreted relative to the preceding "-C
> +       <path>".

For consistency with existing formatting in git.txt, you may want to
squash in the following fixes (sans gmail whitespace damage):

--- >8 ---
diff --git a/Documentation/git.txt b/Documentation/git.txt
index ae049da..6622037 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -396,14 +396,14 @@ because `git --help ...` is converted internally into `git
 help ...`.

 -C <path>::
- Run as if git was started in <path> instead of the current working
- directory.  When multiple -C options are given, each subsequent
- non-absolute "-C <path>" is interpreted relative to the preceding "-C
- <path>".
+ Run as if git was started in '<path>' instead of the current working
+ directory.  When multiple '-C' options are given, each subsequent
+ non-absolute `-C <path>` is interpreted relative to the preceding `-C
+ <path>`.
 +
-This option affects options that expect path name like --git-dir and
---work-tree in that their interpretations of the path names would be
-made relative to the working directory caused by the -C option. For
+This option affects options that expect path name like '--git-dir' and
+'--work-tree' in that their interpretations of the path names would be
+made relative to the working directory caused by the '-C' option. For
 example the following invocations are equivalent:

     git --git-dir=a.git --work-tree=b -C c status
--- >8 ---

> +This option affects options that expect path name like --git-dir and
> +--work-tree in that their interpretations of the path names would be
> +made relative to the working directory caused by the -C option. For
> +example the following invocations are equivalent:
> +
> +    git --git-dir=a.git --work-tree=b -C c status
> +    git --git-dir=c/a.git --work-tree=c/b status

Is the interaction of -C with --work-tree and --git-dir desirable or
useful? (I'm genuinely curious.) Do you have use-cases in mind? Would
mentioning them in the commit message help to justify the interaction?
