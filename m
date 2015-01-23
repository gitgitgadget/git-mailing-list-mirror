From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Fri, 23 Jan 2015 15:02:13 -0800
Message-ID: <xmqqh9vhp0cq.fsf@gitster.dls.corp.google.com>
References: <20150114211712.GE1155@peff.net>
	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
	<xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
	<20150115222719.GA19021@peff.net>
	<xmqqa91j6537.fsf@gitster.dls.corp.google.com>
	<20150115235752.GB25120@peff.net>
	<xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
	<20150116013256.GA25894@peff.net>
	<BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>
	<20150116033445.GA29572@peff.net> <20150116091648.GA2450@peff.net>
	<xmqqfvba37bq.fsf@gitster.dls.corp.google.com>
	<xmqqzj9i1rci.fsf@gitster.dls.corp.google.com> <54BAF1C2.60103@web.de>
	<xmqq61bzwyqp.fsf@gitster.dls.corp.google.com>
	<54C170E9.4010401@web.de>
	<xmqqlhkusc4h.fsf@gitster.dls.corp.google.com>
	<54C2BC01.2030307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jeff King <peff@peff.net>,  "Kyle J. McKay" <mackyle@gmail.com>,  msysgit@googlegroups.com,  Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: msysgit+bncBCG77UMM3EJRB6FFROTAKGQEL4ZJ7KQ@googlegroups.com Sat Jan 24 00:02:22 2015
Return-path: <msysgit+bncBCG77UMM3EJRB6FFROTAKGQEL4ZJ7KQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f192.google.com ([209.85.223.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB6FFROTAKGQEL4ZJ7KQ@googlegroups.com>)
	id 1YEnF3-0001cE-VD
	for gcvm-msysgit@m.gmane.org; Sat, 24 Jan 2015 00:02:18 +0100
Received: by mail-ie0-f192.google.com with SMTP id rd18sf13237iec.9
        for <gcvm-msysgit@m.gmane.org>; Fri, 23 Jan 2015 15:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=Z6gzD5kKPZwcrV3zc7ZpuGz2y2SHmzSnjhf5bIP3tTU=;
        b=vtGWt75gynbWmg2WmhfD4w3qE3yLrg/AoASA+IXrvKjWD3hUk1Lxw1uxPeQDnFtDbv
         /sJbTCm1LOsdGIZIBtVo1p0C6/zfYgCZIX+6uDfI70O7aCZ+hpMsDGcq6JMR3BddEwLK
         6+ZTjhgAHv31oDkoN47lV/uqx6HQfgHCSJPpdiRMmcqOlcvjuvixfyA7GJErKavhPaen
         fNCM6uaYrYcS2FMxL8b/UQFa7fkJNSffSoT/Zp1x7stgAyLGDd3vLzNdOOtO8gi7fOFv
         tU5cAyE5tyNixZkHUd55uV4RO0Jhpcpz4IvBvEQqT2qs/JO02EOaCgO9YyJvqqEwZn2w
         XDWA==
X-Received: by 10.50.129.98 with SMTP id nv2mr75985igb.1.1422054137228;
        Fri, 23 Jan 2015 15:02:17 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.40.71 with SMTP id o68ls120040ioo.61.gmail; Fri, 23 Jan
 2015 15:02:16 -0800 (PST)
X-Received: by 10.42.107.197 with SMTP id e5mr8451874icp.5.1422054136765;
        Fri, 23 Jan 2015 15:02:16 -0800 (PST)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id ux1si211523igb.1.2015.01.23.15.02.16
        for <msysgit@googlegroups.com>;
        Fri, 23 Jan 2015 15:02:16 -0800 (PST)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A6B4E32125;
	Fri, 23 Jan 2015 18:02:15 -0500 (EST)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DAA232124;
	Fri, 23 Jan 2015 18:02:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B15C32123;
	Fri, 23 Jan 2015 18:02:14 -0500 (EST)
In-Reply-To: <54C2BC01.2030307@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 23 Jan 2015 22:24:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DF3859B6-A353-11E4-9F42-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262974>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> It has been tested under Mac OS, root@Mac OS, Cygwin / Msysgit
> What do you think ?

Except that we may want to be more careful to detect errors from the
initial mkdir and clean-up part (which should abort the test, not
just declare !SANITY), I think the basic idea is sound.

	test_dir=3D$TRASH_DIRECTORY/.sanity-test-dir
        ! mkdir "$test_dir" &&
        >"$test_dir/x" &&
        chmod -w "$test_dir" ||
	error "bug in test sript: cannot prepare .sanity-test-dir"

        rm "$test_dir/x"
        status=3D$?

        chmod +w "$test_dir" &&
        rm -r "$test_dir" ||
	error "bug in test sript: cannot clean .sanity-test-dir"

	return $status

or something along that line?

>
> -- >8 --
> Subject: [PATCH 1/2] test-lib.sh: Improve SANITY
>
> SANITY was not set when running as root,
> but this is not 100% reliable for CYGWIN:
>
> A file is allowed to be deleted when the containing
> directory does not have write permissions.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  t/test-lib.sh | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 93f7cad..b8f736f 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1038,8 +1038,26 @@ test_lazy_prereq NOT_ROOT '
> =20
>  # When the tests are run as root, permission tests will report that
>  # things are writable when they shouldn't be.
> +# Special check for CYGWIN (or Windows in general):
> +# A file can be deleted, even if the containing directory does'nt
> +# have write permissions
>  test_lazy_prereq SANITY '
> -	test_have_prereq POSIXPERM,NOT_ROOT
> +	dsdir=3D$$ds
> +	mkdir $dsdir &&
> +	touch $dsdir/x &&
> +	chmod -w $dsdir &&
> +	if rm $dsdir/x
> +	then
> +		chmod +w $dsdir
> +		rm -rf $dsdir
> +		echo >&2 SANITY=3Dfalse
> +		false
> +	else
> +		chmod +w $dsdir
> +		rm -rf $dsdir
> +		echo >&2 SANITY=3Dtrue
> +		true
> +	fi
>  '
> =20
>  GIT_UNZIP=3D${GIT_UNZIP:-unzip}

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
