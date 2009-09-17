From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/15] Set _O_BINARY as default fmode for both
 MinGW and MSVC
Date: Thu, 17 Sep 2009 00:25:33 -0700
Message-ID: <7vfxamjamq.fsf@alter.siamese.dyndns.org>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com> <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com> <4AB10F01.9010703@viscovery.net> <e2480c70909161300o3db4b416k8f33ccce2f987c55@mail.gmail.com> <4AB1E118.70504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexey Borzenkov <snaury@gmail.com>, Marius Storm-Olsen <mstormo@gmail.com>,  git@vger.kernel.org, Johannes.Schindelin@gmx.de,  msysgit@googlegroups.com, gitster@pobox.com,  j6t@kdbg.org,  lznuaa@gmail.com, raa.lkml@gmail.com, Marius Storm-Olsen <marius.storm-olsen@nokia.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Sep 17 09:26:15 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f137.google.com ([209.85.211.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoBNd-0002ls-OG
	for gcvm-msysgit@m.gmane.org; Thu, 17 Sep 2009 09:26:13 +0200
Received: by ywh1 with SMTP id 1so446218ywh.24
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Sep 2009 00:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :x-pobox-relay-id:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=3fCBipliXJcHIVyOQpKJCqmAnXhMa4PP2z5u8RKBQqA=;
        b=vdjZgqjtuJeytJ7CEy9bx1/e4ukGzDP55hrcNoC2K8PS68VMGK1rftvcIVPneC5p6r
         p//0OAPuM/+ggZkQzT3GViIkvcweT3bjTLXeNLExG8i1p1gTPKrQlrSBU8H5o68Ez8jV
         ynPb2cZJTleOdnjUEPI6E69FkE2sx1EydL+Sk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :x-pobox-relay-id:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=ZzdnJvRfstxCY2kFUpEvmx6jicAw4I4XklA2P7Q5KYc2tTlGGe2e4ntJvjyBh2iXy9
         k3nGLqyjGQmJUMEX0zmdNelhkfqUxJVFFx1eH4UYDljcwjOjJ8Hq657a5glXT/jJPzIe
         N+wHg2QIsak/D/jijTGVczoJWaAOcEoJHKbz0=
Received: by 10.90.37.21 with SMTP id k21mr45184agk.11.1253172362644;
        Thu, 17 Sep 2009 00:26:02 -0700 (PDT)
Received: by 10.176.233.14 with SMTP id f14gr7059yqh.0;
	Thu, 17 Sep 2009 00:26:00 -0700 (PDT)
X-Sender: gitster@pobox.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.229.32.143 with SMTP id c15mr1181401qcd.20.1253172359932; Thu, 17 Sep 2009 00:25:59 -0700 (PDT)
Received: by 10.229.32.143 with SMTP id c15mr1181400qcd.20.1253172359876; Thu, 17 Sep 2009 00:25:59 -0700 (PDT)
Received: from sasl.smtp.pobox.com (a-pb-sasl-quonix.pobox.com [208.72.237.25]) by gmr-mx.google.com with ESMTP id 24si1239333qyk.14.2009.09.17.00.25.58; Thu, 17 Sep 2009 00:25:58 -0700 (PDT)
Received-SPF: pass (google.com: domain of gitster@pobox.com designates 208.72.237.25 as permitted sender) client-ip=208.72.237.25;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of gitster@pobox.com designates 208.72.237.25 as permitted sender) smtp.mail=gitster@pobox.com; dkim=pass header.i=@pobox.com
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1]) by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3904535137; Thu, 17 Sep 2009 03:25:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject :references:from:date:in-reply-to:message-id:mime-version :content-type; s=sasl; bh=jtlJNOckjW00pbrq537NpuI3/Fo=; b=uXBnHG 6KDym4coWPg5K9tCJiK06e4gjgfXx9mHoYjyv1gr7ULMxkpI6ZJCwJTxf6ifhFUs ygNGJAADq/dPd77+ZqI/L5n6fGAVlHW6PU/aHKR9/r4jYF9aDZup7XPrPJ8kOJtI B0yDQZO7080DlVJFo39YIBJ9JBDxaWXfD5xEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject :references:from:date:in-reply-to:message-id:mime-version :content-type; q=dns; s=sasl; b=NbrcyAe2QfXwYLOidNmFueJYqarKJCxM L2dR3On0Dkwx+Ac8J0d2vS1SN6XogKaTnXyfd5vzt8PA8ytF9tQdu0wDymfk+thD OBl4Ht/QYZXULWHIjHl8p65pAPj/xXJFZ7yGgdrSWmD5eWOydGIM9GSCmjLcVxaP xbUSEaZ8+3M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1]) by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 95BD135136; Thu, 17 Sep 2009 03:25:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16E9B35130; Thu, 17 Sep 2009 03:25:34 -0400 (EDT)
In-Reply-To: <4AB1E118.70504@viscovery.net> (Johannes Sixt's message of "Thu\, 17 Sep 2009 09\:11\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 51B063CA-A35B-11DE-ABE7-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128723>


Johannes Sixt <j.sixt@viscovery.net> writes:

> Just for the records: The reason why including git-compat-util.h was not
> necessary before 04/15 is that test-genrandom is linked against libgit.a.
> This way the startup code had picked up the definition of _CRT_fmode from
> mingw.c that is initialized to _O_BINARY. After the original 04/15 this
> symbol was not present anymore in libgit.a, and the default (text mode)
> was used. And with this fix, main() is overridden to explicitly set the
> mode of stdout to _O_BINARY.

Beautiful.  I think it is worth mentioning some of the above in the commit
log message.

Thanks.
