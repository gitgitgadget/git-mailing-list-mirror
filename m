From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Documentation: change -L:<regex> to -L:<funcname>
Date: Mon, 20 Apr 2015 12:31:42 +0100
Message-ID: <5534E39E.30305@ramsay1.demon.co.uk>
References: <xmqqh9sepk20.fsf@gitster.dls.corp.google.com> <1429464595-11563-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 20 13:31:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk9vc-0006Qz-Qj
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 13:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbbDTLbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 07:31:48 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:48644 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754680AbbDTLbq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 07:31:46 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id F2D80128116;
	Mon, 20 Apr 2015 12:31:43 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 9FD9B1280E9;
	Mon, 20 Apr 2015 12:31:43 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Mon, 20 Apr 2015 12:31:43 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <1429464595-11563-1-git-send-email-Matthieu.Moy@imag.fr>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267464>

On 19/04/15 18:29, Matthieu Moy wrote:
> The old wording was somehow implying that <start> and <end> were not
> regular expressions. Also, the common case is to use a plain function
> name here so <funcname> makes sense (the fact that it is a regular
> expression is documented in line-range-format.txt).
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> By adding :regex:file as a possibility, you are hinting that 'start'
>> and 'end' are *not* regular expressions but numbers, but
>>
>>     $ git log -L'/^int main/,/^}/:git.c'
>>
>> is a perfectly fine way to specify start (i.e. the first line that
>> matches '^int main') and end (i.e. the first line that matches '^}'
>> after that).
> 
> OK, but the same argument applies to the documentation (where I
> cut-and-pasted from actually). So I suggest this patch in addition
> (I'd apply it right before the patch on the code).
> 
>> false impression to the other one, and use Eric's suggestion on top?
>>
>>     die("-L argument not 'start,end:file' or ':funcname:file': %s",
>> 	item->string);
>>
>> With the matching update to tests, here is what I'll queue on top of
>> this patch for now, but please send in objections and improvements.
> 
> Very good.
> 
> Let me know if you want me to resend the 2-patch series.
> 
>  Documentation/blame-options.txt     |  2 +-
>  Documentation/git-log.txt           |  2 +-
>  Documentation/gitk.txt              |  4 ++--
>  Documentation/line-range-format.txt | 11 ++++++-----
>  4 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> index b299b59..a09969b 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -10,7 +10,7 @@
>  	Include additional statistics at the end of blame output.
>  
>  -L <start>,<end>::
> --L :<regex>::
> +-L :<funcname>::
>  	Annotate only the given line range. May be specified multiple times.
>  	Overlapping ranges are allowed.
>  +
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 18bc716..f0ec283 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -62,7 +62,7 @@ produced by `--stat`, etc.
>  	output by allowing them to allocate space in advance.
>  
>  -L <start>,<end>:<file>::
> --L :<regex>:<file>::
> +-L :<funcname>:<file>::
>  	Trace the evolution of the line range given by "<start>,<end>"
>  	(or the funcname regex <regex>) within the <file>.  You may

perhaps this should read the same as the hunk below, namely:
        (or the funcname regex <funcname>) ...

[I haven't actually given it any thought, I just noticed the difference ...]

Thanks!

ATB,
Ramsay Jones

>  	not give any pathspec limiters.  This is currently limited to
> diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
> index 7ae50aa..d3b91ca 100644
> --- a/Documentation/gitk.txt
> +++ b/Documentation/gitk.txt
> @@ -99,10 +99,10 @@ linkgit:git-rev-list[1] for a complete list.
>  	detailed explanation.)
>  
>  -L<start>,<end>:<file>::
> --L:<regex>:<file>::
> +-L:<funcname>:<file>::
>  
>  	Trace the evolution of the line range given by "<start>,<end>"
> -	(or the funcname regex <regex>) within the <file>.  You may
> +	(or the funcname regex <funcname>) within the <file>.  You may
>  	not give any pathspec limiters.  This is currently limited to
>  	a walk starting from a single revision, i.e., you may only
>  	give zero or one positive revision arguments.
> diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
> index d7f2603..829676f 100644
> --- a/Documentation/line-range-format.txt
> +++ b/Documentation/line-range-format.txt
> @@ -22,8 +22,9 @@ This is only valid for <end> and will specify a number
>  of lines before or after the line given by <start>.
>  
>  +
> -If ``:<regex>'' is given in place of <start> and <end>, it denotes the range
> -from the first funcname line that matches <regex>, up to the next
> -funcname line. ``:<regex>'' searches from the end of the previous `-L` range,
> -if any, otherwise from the start of file.
> -``^:<regex>'' searches from the start of file.
> +If ``:<funcname>'' is given in place of <start> and <end>, it is a
> +regular expression that denotes the range from the first funcname line
> +that matches <funcname>, up to the next funcname line. ``:<funcname>''
> +searches from the end of the previous `-L` range, if any, otherwise
> +from the start of file. ``^:<funcname>'' searches from the start of
> +file.
> 
