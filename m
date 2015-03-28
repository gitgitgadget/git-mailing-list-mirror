From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 2/2] git-p4: Fix copy detection test
Date: Sat, 28 Mar 2015 00:36:36 +0000
Message-ID: <20150328003636.07930f83@pt-vhugo>
References: <1427418269-3263-1-git-send-email-vitor.hda@gmail.com>
	<1427418269-3263-3-git-send-email-vitor.hda@gmail.com>
	<xmqq619mw04r.fsf@gitster.dls.corp.google.com>
	<20150327235902.25ebf380@pt-vhugo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Vitor Antunes <vitor.hda@gmail.com>, Pete Wyckoff <pw@padd.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 01:36:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybek7-0004Mt-4w
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 01:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbbC1Agq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 20:36:46 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33709 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbbC1Agp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 20:36:45 -0400
Received: by wgbgs4 with SMTP id gs4so24525158wgb.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 17:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ehelVAqpqYJJcVpJ7itu9eeNpBzPYAIGZVOYpar7VUg=;
        b=ISW2eINcrOoTAKeR8YES8tVoOO/67ANkojPeuuXCqI3jfmdZAwNO1fUeEmTCK9GSLs
         vIycx0HRZpUA49m7mwbqZJMh4bcO6XJ3xSfQRPvmK9n8jHY5+uDfD2C/TsiH+WJf5wCp
         koASOBmYlpoPwOEiZwsTD6F0UMsrUvqjOZ9BrMqPtMGXSWlzgPJTiMCoQ9LP41xly/Kl
         /K1c+D8VjkWTpIrJ4U00ZO0nqGJfFWQLq3kAqn7hi6BOZU4V4b4XRBwd3i9rgpM9JIm1
         lHj5VzIR13Wt5GW48UNNQr+XQVV/LWLDxcOI3J5fP9BuhL4Nqk0yIJm/4hucDlZAqVQz
         xD1Q==
X-Received: by 10.194.187.46 with SMTP id fp14mr11315485wjc.86.1427503004388;
        Fri, 27 Mar 2015 17:36:44 -0700 (PDT)
Received: from pt-vhugo (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id ka1sm5014252wjc.2.2015.03.27.17.36.43
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 17:36:44 -0700 (PDT)
In-Reply-To: <20150327235902.25ebf380@pt-vhugo>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266410>

Vitor Antunes <vitor.hda@gmail.com> wrote:

>Junio C Hamano <gitster@pobox.com> wrote:
>>Pete, these tests blame to your 9b6513ac (git p4 test: split up big
>>t9800 test, 2012-06-27).  I presume that you tested the result of
>>this splitting, but do you happen to know if we did something to
>>cause the test to break recently?
>
>I also worked on these tests at that time and they were passing before and
>after the reorganization. I'll prepare a bisect script and will try to find the
>commit that started making this test fail.

According to bisect, this is the first commit that makes the test fail:

7c85f8acb2282e3ed108c46b59fd5daa78bf17db

Does this make sense to you?
