From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove the line length limit for graft files
Date: Fri, 27 Dec 2013 16:50:11 -0800
Message-ID: <xmqqd2khu7cs.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1312272146590.1191@s15462909.onlinehome-server.info>
	<20131227210447.GE20443@google.com>
	<alpine.DEB.1.00.1312272208070.1191@s15462909.onlinehome-server.info>
	<20131227223240.GG20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org,  msysgit@googlegroups.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBSWA7CKQKGQENO4BF7A@googlegroups.com Sat Dec 28 01:50:22 2013
Return-path: <msysgit+bncBCG77UMM3EJRBSWA7CKQKGQENO4BF7A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f62.google.com ([209.85.216.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBSWA7CKQKGQENO4BF7A@googlegroups.com>)
	id 1Vwi6d-0004UI-Q1
	for gcvm-msysgit@m.gmane.org; Sat, 28 Dec 2013 01:50:20 +0100
Received: by mail-qa0-f62.google.com with SMTP id w5sf2367567qac.27
        for <gcvm-msysgit@m.gmane.org>; Fri, 27 Dec 2013 16:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=9saCjQZxdJzikmXjKkBcvvRLQ6UEMbjFTP02ybX5TkU=;
        b=yG6Z1NTFsqjVkebTr9sqqbnEP2/Hqhg6UBF8l1md8VV4XQHx9IImhNOn8LpuWREOEr
         /UbN77oIRMUWyxAIYcd+j+ZKOgDIrqlYVjRP2qQX0e3peMdHmVMISQeF2sogUtJa5Pm9
         pS1DhpKvpsVf0ss7dxuR5W2NiRRaeCRwgXw5RRkPDtBgdxxEp7VxyIXzH7JeDAy8gemP
         hPdNGxjMRfbyDj4ICFaHgsslCEa0WTIo45wVEd+u6232MWbMClFwePsiawyROeVHiwmg
         7HflRiEf6acHmEotXSxxc9sCXW9CxeJ0pLicKQQXuky7BYfLkNogpaVLKO9GOABOBQAY
         f6RQ==
X-Received: by 10.50.66.101 with SMTP id e5mr788647igt.12.1388191818888;
        Fri, 27 Dec 2013 16:50:18 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.30.170 with SMTP id t10ls4397539igh.9.gmail; Fri, 27 Dec
 2013 16:50:18 -0800 (PST)
X-Received: by 10.66.150.106 with SMTP id uh10mr20640751pab.13.1388191818376;
        Fri, 27 Dec 2013 16:50:18 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id ti10si1157158vdc.3.2013.12.27.16.50.18
        for <msysgit@googlegroups.com>;
        Fri, 27 Dec 2013 16:50:18 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAA1D5FCCF;
	Fri, 27 Dec 2013 19:50:17 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1F785FCCE;
	Fri, 27 Dec 2013 19:50:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05ADF5FCCC;
	Fri, 27 Dec 2013 19:50:17 -0500 (EST)
In-Reply-To: <20131227223240.GG20443@google.com> (Jonathan Nieder's message of
	"Fri, 27 Dec 2013 14:32:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 04E50F8A-6F5A-11E3-8A95-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=jch@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239759>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Johannes Schindelin wrote:
>> On Fri, 27 Dec 2013, Jonathan Nieder wrote:
>
>>> Is this easy to reproduce so some interested but lazy person could
>>> write a test?
>>
>> Yep. Make 25 orphan commits, add a graft line to make the first a merge of
>> the rest.
>
> Thanks.  Here's a pair of tests doing that.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  t/annotate-tests.sh          | 21 +++++++++++++++++++++
>  t/t6101-rev-parse-parents.sh | 16 +++++++++++++++-
>  2 files changed, 36 insertions(+), 1 deletion(-)

Makes sense.

Thanks, both.  Small lint-picking like this change to perfect the
system, as opposed to earth-shattering new shinies, tend to often
get neglected but are very much appreciated.

> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index c9d105d..304c7b7 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -116,6 +116,27 @@ test_expect_success 'blame evil merge' '
>  	check_count A 2 B 1 B1 2 B2 1 "A U Thor" 1
>  '
>  
> +test_expect_success 'blame huge graft' '
> +	test_when_finished "git checkout branch2" &&
> +	test_when_finished "rm -f .git/info/grafts" &&
> +	graft= &&
> +	for i in 0 1 2
> +	do
> +		for j in 0 1 2 3 4 5 6 7 8 9
> +		do
> +			git checkout --orphan "$i$j" &&
> +			printf "%s\n" "$i" "$j" >file &&
> +			test_tick &&
> +			GIT_AUTHOR_NAME=$i$j GIT_AUTHOR_EMAIL=$i$j@test.git \
> +			git commit -a -m "$i$j" &&
> +			commit=$(git rev-parse --verify HEAD) &&
> +			graft="$graft$commit "
> +		done
> +	done &&
> +	printf "%s " $graft >.git/info/grafts &&
> +	check_count -h 00 01 1 10 1
> +'
> +
>  test_expect_success 'setup incomplete line' '
>  	echo "incomplete" | tr -d "\\012" >>file &&
>  	GIT_AUTHOR_NAME="C" GIT_AUTHOR_EMAIL="C@test.git" \
> diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
> index 7ea14ce..10b1452 100755
> --- a/t/t6101-rev-parse-parents.sh
> +++ b/t/t6101-rev-parse-parents.sh
> @@ -20,7 +20,17 @@ test_expect_success 'setup' '
>  	test_commit start2 &&
>  	git checkout master &&
>  	git merge -m next start2 &&
> -	test_commit final
> +	test_commit final &&
> +
> +	test_seq 40 |
> +	while read i
> +	do
> +		git checkout --orphan "b$i" &&
> +		test_tick &&
> +		git commit --allow-empty -m "$i" &&
> +		commit=$(git rev-parse --verify HEAD) &&
> +		printf "$commit " >>.git/info/grafts
> +	done
>  '
>  
>  test_expect_success 'start is valid' '
> @@ -79,6 +89,10 @@ test_expect_success 'final^1^! = final^1 ^final^1^1 ^final^1^2' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'large graft octopus' '
> +	test_cmp_rev_output b31 "git rev-parse --verify b1^30"
> +'
> +
>  test_expect_success 'repack for next test' '
>  	git repack -a -d
>  '
> -- 
> 1.8.5.1
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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
