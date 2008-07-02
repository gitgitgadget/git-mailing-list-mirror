From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 02/12] Do not complain about "no common commits"
 in an empty repo
Date: Wed, 02 Jul 2008 01:58:00 -0700
Message-ID: <7vskusd5nr.fsf@gitster.siamese.dyndns.org>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>,  git@vger.kernel.org,  msysgit@googlegroups.com,  Johannes Schindelin <johannes.schindelin@gmx.de>
To: prohaska@zib.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 10:59:21 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.247])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDyBM-0001qw-Oc
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 10:59:21 +0200
Received: by wa-out-0708.google.com with SMTP id n36so7002983wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 01:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-pobox-relay-id:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=c/9q2eDD1WcdF6/FL/HsjH/aZHq8x9S8yL70sK5fcJI=;
        b=5p2H7Q0fZvVpcQqvur72vDOeszEwwmd04gK1qtKsn+5o2wMnM2oSOWeSMmi+Pam5IJ
         XV0FRAMBXUqofYbcCaKKHLwKEq4svXpTj4nAXsECcqin0OuE9ESPGvn5KD5n4hYB+uZx
         hn2q6MkWCyEZSJQgJWUZBnl5DsF8SGVQnpvSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:cc:subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type:x-pobox-relay-id:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=E4z+1ui8RJzAEuSNva6jqaJjUoqkmQAJYpF6VqcHoPsoQd+j/ZhA6qxLtaARWKDUL+
         t5vmXpVzoInSrim6tcLPA8T3xS+MgwNLcaIbYrzPUqN9pkqZXqAQBUWLLm6mSWJK7Dmv
         Mqw1muz6/zQAhdvfqSr7RoXxCn5dFVcFrmDho=
Received: by 10.114.199.1 with SMTP id w1mr546411waf.6.1214989100962;
        Wed, 02 Jul 2008 01:58:20 -0700 (PDT)
Received: by 10.106.193.17 with SMTP id q17gr2556prf.0;
	Wed, 02 Jul 2008 01:58:20 -0700 (PDT)
X-Sender: junio@pobox.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.83.18 with SMTP id g18mr8865207agb.17.1214989100519; Wed, 02 Jul 2008 01:58:20 -0700 (PDT)
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com [207.106.133.19]) by mx.google.com with ESMTP id 39si7879312yxd.0.2008.07.02.01.58.20; Wed, 02 Jul 2008 01:58:20 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 207.106.133.19 as permitted sender) client-ip=207.106.133.19;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of junio@pobox.com designates 207.106.133.19 as permitted sender) smtp.mail=junio@pobox.com
Received: from localhost.localdomain (localhost [127.0.0.1]) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A770F288A5; Wed,  2 Jul 2008 04:58:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9DD8E288A2; Wed,  2 Jul 2008 04:58:08 -0400 (EDT)
In-Reply-To: <1214987532-23640-2-git-send-email-prohaska@zib.de> (Steffen Prohaska's message of "Wed, 2 Jul 2008 10:32:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 04697A90-4815-11DD-AB6C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87118>


Steffen Prohaska <prohaska@zib.de> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> If the repo is empty, we know that already, thank you very much.
> So shut fetch-pack up about that case.

Two complaints.

 * What does this have to do with Windows port?  Please don't hide a
   general interface change in a larger and mostly unrelated topic.

 * Do you think people can tell without reading the code in larger context
   outside the patch and this commit log text if you are talking about the
   case you fetch _into_ an empty repository, or if you are attempting to
   fetch _from_ an empty repository, or what?  Please try to be a bit
   easier for _readers_.  Being more redundant and verbose is better than
   being too concise.

About the first point, "no common commits" is just a friendly reminder and
not even an error.  When you see it, you will learn to expect looooooooong
download session.

I personally happen to agree with the logic of this patch, though --- if
you are fetching into an empty repository, you would already expect that
the download is as big as the other end anyway, so you would not need to
be further reminded about that.

But that is just one-man's opinion.  Maybe somebody knows a reason why I
am (and the logic I am agreeing with is) wrong.  Maybe not.  So make the
"remainder of Windows port" series 11 commits, and send this as a general
interface fix via the normal channel to be discussed, please.
