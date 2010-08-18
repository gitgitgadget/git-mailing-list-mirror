From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] Add test case for dealing with a tracked file in an
 ignored directory
Date: Wed, 18 Aug 2010 13:43:00 +0000
Message-ID: <AANLkTi=UJmXx0-fV6OqDTOzuTdQQWioUb=3vrVx01qi6@mail.gmail.com>
References: <AANLkTiky+azVAnXEBFWR1q9_8NH8TX2TfuonXCpA_-ms@mail.gmail.com>
	<1282123788-24055-1-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu.Moy@grenoble-inp.fr, git@vger.kernel.org,
	gitster@pobox.com, Jens.Lehmann@web.de, jrnieder@gmail.com
To: Greg Brockman <gdb@mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 18 15:43:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlivH-0001pF-0y
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab0HRNnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 09:43:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40083 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab0HRNnC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 09:43:02 -0400
Received: by fxm13 with SMTP id 13so257043fxm.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=uXvHB+R2rvWsvHSJHjPW2eKaQrSepp9VQpe7T5QsyWk=;
        b=m5MrmRm32cn+5Dlv4HX9USZkWzqh5ziHXNvG+wHDuDlBngAhWa5tzZP9fyf+qikHyj
         Sh2ddqcSotxEDQEvij+Ue2SbcbjE+6tuIM9YtVr3E1bbnqlpd0i8EWK/qQskyB+lOKZa
         AAOKq4VwUXzp53Pxd2xdp9cJdmBsiIObcD+A8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hH73TPcC8k89dalHV0jNJxdSoZ5g5JxjfD4XFbtD4UfdFM/6BSwDPjCgFkCgEat0r2
         IiSsWnk8CzuEYa1EKc9oN95zPYiYtS4ZIzT8+Y4+ZKNnrkgKbbCzlVYGvUB4ZJXFmnzP
         idtQCEareiE5doXokOa+UO4Ui33MoTrQXMLSM=
Received: by 10.223.108.137 with SMTP id f9mr7957950fap.3.1282138980859; Wed,
 18 Aug 2010 06:43:00 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 18 Aug 2010 06:43:00 -0700 (PDT)
In-Reply-To: <1282123788-24055-1-git-send-email-gdb@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153848>

On Wed, Aug 18, 2010 at 09:29, Greg Brockman <gdb@mit.edu> wrote:

> +cat >expect <<EOF
> +The following paths are ignored by one of your .gitignore files:
> +ignored-dir
> +Use -f if you really want to add them.
> +fatal: no files added
> +EOF

Please make this a test, per this bit in t/README:

 - Put all code inside test_expect_success and other assertions.

   Even code that isn't a test per se, but merely some setup code
   should be inside a test assertion.
