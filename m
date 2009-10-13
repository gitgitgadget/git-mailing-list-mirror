From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git 1.6.5-rc git clone unhandled exception using http
 protocol
Date: Tue, 13 Oct 2009 14:06:49 -0700
Message-ID: <7v4oq3uhp2.fsf@alter.siamese.dyndns.org>
References: <4ACF7296.3010809@gmail.com> <be6fef0d0910100355v41de0771m30c153f413a46d2e@mail.gmail.com> <4AD09F5E.9090304@gmail.com> <be6fef0d0910100811l325d3df1jdf8d3d9dd51e3385@mail.gmail.com> <4AD0AE84.1070500@gmail.com> <be6fef0d0910100907t61ea922bqf117e6c025e94ce7@mail.gmail.com> <4AD0BBCB.8000306@gmail.com> <d2e97e800910130310wa9731a6j9b9bdd25047ade85@mail.gmail.com> <4AD45C28.4080501@viscovery.net> <d2e97e800910130443m56ea2850nf72274fc55a4be68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: Johannes Sixt <j.sixt@viscovery.net>, eduard stefan <eduard.stefan@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>, Git Mailing List <git@vger.kernel.org>,  msysgit@googlegroups.com
To: Michael Wookey <michaelwookey@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 23:07:24 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f204.google.com ([209.85.217.204])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxoaX-000320-15
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 23:07:21 +0200
Received: by gxk28 with SMTP id 28so6110785gxk.6
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 14:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :x-pobox-relay-id:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=V6aNedBWlxAAfm2B4VOfd0F5yukUPkX4Q97abOd15iQ=;
        b=o23lmzk6hALsNdlbICk0/9NoZoRKMKbMIddk2fj9Eg/BTGMXl+feIoYmeB+AbbmGmJ
         RIQa0vPEz2GCGLalS9fWl7qev7TD1alCJmAn679fu8ey502UOOt9ao+P8XejPqHPNy0f
         16u14R0qBX+hPAX2z83VPEFz9G7KamH2qCy8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :x-pobox-relay-id:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=kMLuoiob0ekuzl/cr4k76mzhwydS6HhzhyYpdZEmmtqJfm+iyoLh8P4Jcgq+l08wHl
         PX073wWpfIXTE4ttajTEI8TfPnoqkaYOkD66Z06q8psieP3ZwHoEO2dct4iMgB07pgee
         pUhm4kh6KXv3FrQsS4MaLr5NFG4Al/nvBGRLg=
Received: by 10.150.34.37 with SMTP id h37mr919140ybh.29.1255468033710;
        Tue, 13 Oct 2009 14:07:13 -0700 (PDT)
Received: by 10.177.5.4 with SMTP id h4gr7408yqi.0;
	Tue, 13 Oct 2009 14:07:08 -0700 (PDT)
X-Sender: gitster@pobox.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.229.29.146 with SMTP id q18mr1722719qcc.23.1255468026460; Tue, 13 Oct 2009 14:07:06 -0700 (PDT)
Received: by 10.229.29.146 with SMTP id q18mr1722718qcc.23.1255468026434; Tue, 13 Oct 2009 14:07:06 -0700 (PDT)
Received: from sasl.smtp.pobox.com (a-pb-sasl-quonix.pobox.com [208.72.237.25]) by gmr-mx.google.com with ESMTP id 19si338924qyk.8.2009.10.13.14.07.05; Tue, 13 Oct 2009 14:07:05 -0700 (PDT)
Received-SPF: pass (google.com: domain of gitster@pobox.com designates 208.72.237.25 as permitted sender) client-ip=208.72.237.25;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of gitster@pobox.com designates 208.72.237.25 as permitted sender) smtp.mail=gitster@pobox.com; dkim=pass header.i=@pobox.com
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1]) by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6FBA576BB; Tue, 13 Oct 2009 17:07:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject :references:from:date:in-reply-to:message-id:mime-version :content-type:content-transfer-encoding; s=sasl; bh=2hgkrwbkSihe 5/9BdWPRtrTCVkQ=; b=ZBIYlLWO9d6dOEmMnLX48HNjToXj7xB8bSrKsC/M03PT 0fPlPA6ZcjwgZgxEbOLudku9xNyQCo3XX8WYANJJxd+W39nkT5nLZKPSdkv7eiuz fqYsy/KK9XhTA5msBQciTS+iJha3poES2mIlvEObzJiQFx5gAEgApF/8VMQdqyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject :references:from:date:in-reply-to:message-id:mime-version :content-type:content-transfer-encoding; q=dns; s=sasl; b=VB2XKk korY/ZaJOhrzxwk4Fyeu3i6LQCHXBFeUrVNDsIa2YmfRfufILRo+sjNaf2hnjfc5 MhlS8nosUW74SLl9Nvt/Cbih3d95i0GvPon3FbrArMH6PSq7fWKxr+9TlUhN2IYL QypPJeUu+pxqU40kAc5ssuwsYOCagdqGmJKuI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1]) by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 99D86576B9; Tue, 13 Oct 2009 17:06:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FFE4576B1; Tue, 13 Oct 2009 17:06:51 -0400 (EDT)
In-Reply-To: <d2e97e800910130443m56ea2850nf72274fc55a4be68@mail.gmail.com> (Michael Wookey's message of "Tue\, 13 Oct 2009 22\:43\:01 +1100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 58427FA2-B83C-11DE-A039-B3E4ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130212>


Michael Wookey <michaelwookey@gmail.com> writes:

> 2009/10/13 Johannes Sixt <j.sixt@viscovery.net>:
>> Michael Wookey schrieb:
>>> Using the above repository, I see the same crash with msysGit at git
>>> revision 1.6.5. Using windbg as the post-mortem debugger, the
>>> following information is captured:
>>> [ ... snip ... ]
>> Wow, this is great work, thank you very much! The function is
>> strip_path_suffix(). And here is a patch that fixes the crash.
>>
>> --- >8 ---
>> From: Johannes Sixt <j6t@kdbg.org>
>> Subject: [PATCH] remote-curl: add missing initialization of argv0_path
>>
>> All programs, in particular also the stand-alone programs (non-builtin=
s)
>> must call git_extract_argv0_path(argv[0]) in order to help builds that
>> derive the installation prefix at runtime, such as the MinGW build.
>> Without this call, the program segfaults (or raises an assertion
>> failure).
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>> =C2=A0remote-curl.c | =C2=A0 =C2=A01 +
>> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/remote-curl.c b/remote-curl.c
>> index ad6a163..d8d276a 100644
>> --- a/remote-curl.c
>> +++ b/remote-curl.c
>> @@ -82,6 +82,7 @@ int main(int argc, const char **argv)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *url;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct walker *walker =3D NULL;
>>
>> + =C2=A0 =C2=A0 =C2=A0 git_extract_argv0_path(argv[0]);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0setup_git_directory();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (argc < 2) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr,=
 "Remote needed\n");
>> --
>> 1.6.5.1024.g31034.dirty
>
> No more crashes for me :)

Beautiful.  Thanks, both of you!
