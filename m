From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revisions --stdin: accept CRLF line terminators
Date: Tue, 11 Aug 2015 14:35:03 -0700
Message-ID: <xmqqr3n9pkzc.fsf@gitster.dls.corp.google.com>
References: <55CA594D.5020103@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBCG77UMM3EJRBCOVVGXAKGQESHRTNDQ@googlegroups.com Tue Aug 11 23:35:08 2015
Return-path: <msysgit+bncBCG77UMM3EJRBCOVVGXAKGQESHRTNDQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f188.google.com ([209.85.214.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBCOVVGXAKGQESHRTNDQ@googlegroups.com>)
	id 1ZPHCN-0002Tr-30
	for gcvm-msysgit@m.gmane.org; Tue, 11 Aug 2015 23:35:07 +0200
Received: by obbjg8 with SMTP id jg8sf49249007obb.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 11 Aug 2015 14:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=Az6UA2Cfci6nsj7e9G1axb9dyO0yi4T4FzMuM43L3qY=;
        b=jnD6VMpKKbp3YwDp8t0GLOFanTeEgGIW3aMeNyIJlMlE7k0Nz6nut5kGo06QLbdcR6
         2vLKrjWRsnjfLbp5O700ozNQ4ekmvwmZRuV3IAZ8h8vLuHCRLDscZfA25H7cnin7BI85
         lrX+N+NoS041V/Tp5GGZkcWri0cAihRIA3VDkkKCggp4PFW22XdT8r6yPnirAbbGZBC5
         uPS3GCuzSlOViV+U01ZrMFfJ/schAIiXEh7B3sP1S8g+SyuPT7eaUj5R88aJ1YdCIb4o
         XE8O9lWuCXkFO25uHMG1GRew7tpAPiH4cHdaCnmsvI34yLKnyCu7BAVCtOLKyAXs4kOv
         +NIw==
X-Received: by 10.140.20.56 with SMTP id 53mr243818qgi.9.1439328906116;
        Tue, 11 Aug 2015 14:35:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.98.208 with SMTP id o74ls1559188qge.2.gmail; Tue, 11 Aug
 2015 14:35:05 -0700 (PDT)
X-Received: by 10.129.55.211 with SMTP id e202mr20431988ywa.5.1439328905225;
        Tue, 11 Aug 2015 14:35:05 -0700 (PDT)
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com. [2607:f8b0:400e:c03::236])
        by gmr-mx.google.com with ESMTPS id c1si359685pdg.0.2015.08.11.14.35.05
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2015 14:35:05 -0700 (PDT)
Received-SPF: pass (google.com: domain of jch2355@gmail.com designates 2607:f8b0:400e:c03::236 as permitted sender) client-ip=2607:f8b0:400e:c03::236;
Received: by mail-pa0-x236.google.com with SMTP id yb7so138247475pab.0
        for <msysgit@googlegroups.com>; Tue, 11 Aug 2015 14:35:05 -0700 (PDT)
X-Received: by 10.68.250.98 with SMTP id zb2mr60614046pbc.40.1439328905072;
        Tue, 11 Aug 2015 14:35:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id sp1sm3848651pab.4.2015.08.11.14.35.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 14:35:04 -0700 (PDT)
Sender: msysgit@googlegroups.com
In-Reply-To: <55CA594D.5020103@kdbg.org> (Johannes Sixt's message of "Tue, 11
	Aug 2015 22:21:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jch2355@gmail.com designates 2607:f8b0:400e:c03::236
 as permitted sender) smtp.mailfrom=jch2355@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275731>

Johannes Sixt <j6t@kdbg.org> writes:

> On Windows, 'git rebase -i' with rebase.missingCommitsCheck set to
> warn or error reports:
>
>    Dropped commits (newer to older):
>    'atal: bad revision '410dee56...
>
> The error comes from the git rev-list --stdin invocation in
> git-rebase--interactive.sh (function check_todo_list). It is caused by
> CRs that end up in the file "$todo".miss, because many tools of the MSYS
> toolset force LF to CRLF conversion when regular files are written via
> stdout.
>
> To fix the error, permit CRLF line terminators when revisions and
> pathspec are read using the --stdin option.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  This fixes a new failure in the test suite (t3404.8[67]) on Windows, but
>  I got around to debug it only now.
>
>  revision.c                |  4 ++++
>  t/t6017-rev-list-stdin.sh | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index cf60c5d..4efedeb 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1641,6 +1641,8 @@ static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
>  		int len = sb->len;
>  		if (len && sb->buf[len - 1] == '\n')
>  			sb->buf[--len] = '\0';
> +		if (len && sb->buf[len - 1] == '\r')
> +			sb->buf[--len] = '\0';
>  		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
>  		prune->path[prune->nr++] = xstrdup(sb->buf);
>  	}
> @@ -1661,6 +1663,8 @@ static void read_revisions_from_stdin(struct rev_info *revs,
>  		int len = sb.len;
>  		if (len && sb.buf[len - 1] == '\n')
>  			sb.buf[--len] = '\0';
> +		if (len && sb.buf[len - 1] == '\r')
> +			sb.buf[--len] = '\0';

This will strip lone CR at the end of line, in addition to CRLF at
the end of line (which you want to handle) and LF at the end of line
(we always have removed), making it work even on ancient MacOS.

If we really cared, I guess we could write it like this:

	if (len && sb.buf[len - 1] == '\n') {
        	len--;
                if (len && sb.buf[len - 1] == '\r')
                	len--;
		sb.buf[len] = '\0';
	}

but your version should be fine as-is.

Thanks.

> diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
> index 667b375..34c43cf 100755
> --- a/t/t6017-rev-list-stdin.sh
> +++ b/t/t6017-rev-list-stdin.sh
> @@ -75,4 +75,20 @@ test_expect_success 'not only --stdin' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'accept CRLF line terminators' '
> +	cat >expect <<-\EOF &&
> +	7
> +
> +	file-2
> +	EOF
> +	q_to_cr >input <<-\EOF &&
> +	masterQ
> +	^master^Q
> +	--Q
> +	file-2Q
> +	EOF
> +	git log --pretty=tformat:%s --name-only --stdin <input >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> -- 
> 2.3.2.245.gb5bf9d3
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
