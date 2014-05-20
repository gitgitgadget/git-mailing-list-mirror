From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH] t6006-*.sh: Fix truncation tests
Date: Tue, 20 May 2014 18:19:36 +0400
Message-ID: <20140520141936.GA30187@ashu.dyn1.rarus.ru>
References: <537B5E8C.3070803@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue May 20 16:19:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmktS-0003CC-0t
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 16:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbaETOTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 10:19:46 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:57772 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbaETOTp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 10:19:45 -0400
Received: by mail-la0-f43.google.com with SMTP id mc6so462465lab.16
        for <git@vger.kernel.org>; Tue, 20 May 2014 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kmMy1etQlQLZpTkX+AJzRy3oq5WmKsIit/+r4xCHoSQ=;
        b=RvpuSlL3boD2pDAWrbk2RubruAzBldsLXniRybMhBq1keqMRhlJeGiDiHFdoE5EMw5
         XE0PpxxDsrqqmhSA6CjQYrX+yOYHmpAwZ/EMVeAVItOvv/OfKA8TR6JY03aG6qYIUkAW
         xqDiNaX4Go3i5AeDxEM80bm3NXvolj00lonfbChNNfGzcwLi513aRTPmCn0rXk8+4nMn
         SkLaslzSS97SGwXfVhSC9yQRCYIlUdGqAGL/PUIVTR+gy7kMXld8WVL3plSiYsTuqgss
         XfriJWDpDr3eeK95mDdb+IroO46Dkt1xVAiNTRwrZ4NEqtSQ0Vp3D/EP8AphyHUIR7TT
         BT2g==
X-Received: by 10.112.143.99 with SMTP id sd3mr30714653lbb.11.1400595583626;
        Tue, 20 May 2014 07:19:43 -0700 (PDT)
Received: from localhost ([193.9.244.4])
        by mx.google.com with ESMTPSA id vr5sm20962248lbb.21.2014.05.20.07.19.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 May 2014 07:19:42 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <537B5E8C.3070803@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249684>

On Tue, May 20, 2014 at 02:54:20PM +0100, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
> 
> Hi Alexey,
> 
> If you need to re-roll your 'as/pretty-truncate' branch, could
> you please squash the relevant parts of this patch into the
> corresponding patches of your patch series. (ie this is a patch
> against the head of the current pu branch ...).
> 
> Without this patch I get:
> 
>   $ ./t6006-rev-list-format.sh
>   ok 1 - setup
>   ok 2 - format percent
>   ok 3 - format hash
>   ok 4 - format tree
>   ok 5 - format parents
>   ok 6 - format author
>   ok 7 - format committer
>   ok 8 - format encoding
>   ok 9 - format subject
>   ./t6006-rev-list-format.sh: 152: ./t6006-rev-list-format.sh: Syntax error: "(" unexpected
>   FATAL: Unexpected exit with code 2
>   $ 
Ooops, my fault.
> 
> (if you have bash as /bin/sh you get different but related errors).
> The additional quoting suppresses the 'command redirection' errors, etc...
It's strange but I do have Bash as /bin/sh and unfortunately I have no
this error

AFAIU, Junio already applied my patches (existance of a branch
as/pretty-truncate tells us that). So, we can only send other patches that
fix errors brought with former patches.
You can send, too.
> 
> Thanks.
> 
> ATB
> Ramsay Jones
> 
>  t/t6006-rev-list-format.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index 9bc089b..e1dec3e 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> @@ -149,7 +149,7 @@ commit $head1
>  $added
>  EOF
>  
> -test_format subject-truncated %<($truncate_count,trunc)%s <<EOF
> +test_format subject-truncated %\<\($truncate_count,trunc\)%s <<EOF
>  commit $head2
>  changed (ge${changed_utf8_part}ndert)..
>  commit $head1
> @@ -256,7 +256,7 @@ commit $head1
>  $added_iso88591
>  EOF
>  
> -test_format complex-subject-trunc %<($truncate_count,trunc)%s <<EOF
> +test_format complex-subject-trunc %\<\($truncate_count,trunc\)%s <<EOF
>  commit $head3
>  Test printing of c..
>  commit $head2
> @@ -265,7 +265,7 @@ commit $head1
>  added (hinzugef${added_utf8_part_iso88591}gt..
>  EOF
>  
> -test_format complex-subject-mtrunc %<($truncate_count,mtrunc)%s <<EOF
> +test_format complex-subject-mtrunc %\<\($truncate_count,mtrunc\)%s <<EOF
>  commit $head3
>  Test prin..ex bodies
>  commit $head2
> @@ -274,7 +274,7 @@ commit $head1
>  added (hi..f${added_utf8_part_iso88591}gt) foo
>  EOF
>  
> -test_format complex-subject-ltrunc %<($truncate_count,ltrunc)%s <<EOF
> +test_format complex-subject-ltrunc %\<\($truncate_count,ltrunc\)%s <<EOF
>  commit $head3
>  .. of complex bodies
>  commit $head2
> @@ -311,7 +311,7 @@ commit $head1
>  $added
>  EOF
>  
> -test_format complex-subject-commitencoding-unset-trunc %<($truncate_count,trunc)%s <<EOF
> +test_format complex-subject-commitencoding-unset-trunc %\<\($truncate_count,trunc\)%s <<EOF
>  commit $head3
>  Test printing of c..
>  commit $head2
> @@ -320,7 +320,7 @@ commit $head1
>  added (hinzugef${added_utf8_part}gt..
>  EOF
>  
> -test_format complex-subject-commitencoding-unset-mtrunc %<($truncate_count,mtrunc)%s <<EOF
> +test_format complex-subject-commitencoding-unset-mtrunc %\<\($truncate_count,mtrunc\)%s <<EOF
>  commit $head3
>  Test prin..ex bodies
>  commit $head2
> @@ -329,7 +329,7 @@ commit $head1
>  added (hi..f${added_utf8_part}gt) foo
>  EOF
>  
> -test_format complex-subject-commitencoding-unset-ltrunc %<($truncate_count,ltrunc)%s <<EOF
> +test_format complex-subject-commitencoding-unset-ltrunc %\<\($truncate_count,ltrunc\)%s <<EOF
>  commit $head3
>  .. of complex bodies
>  commit $head2
> -- 
> 1.9.0

-- 
Alexey Shumkin
E-mail: Alex.Crezoff@gmail.com
ICQ: 118001447
Jabber (GoogleTalk): Alex.Crezoff@gmail.com
Skype: crezoff
