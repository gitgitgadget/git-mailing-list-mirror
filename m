From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 6/7] rebase: write better reflog messages
Date: Wed, 19 Jun 2013 11:39:00 +0530
Message-ID: <CALkWK0mMLPHp=OcWAPW5g3Eb7CBt42dtqkDwpQp69tKwLNYe0Q@mail.gmail.com>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
 <1371581737-10013-7-git-send-email-artagnon@gmail.com> <51C1442A.2010904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 19 08:10:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpBah-0007P4-Bo
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 08:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557Ab3FSGJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 02:09:42 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:54911 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab3FSGJl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 02:09:41 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so12491906iec.36
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 23:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QZC76vJf8/Iz0zJOFfyanvHr/ljhACQbnXj2GhNvb5E=;
        b=hIaWw/ks7/rN0uzGA1MEbu3JLNtW6ywXCV7dNFEPpqugJqFfsPEzGGM+8dIzVrDA9t
         Q24vSwjlwjwHlrR+jn0UnFqmSvUaZU2HMmlRiCde50gXvAuSXosIahPMK+WyPmVGx/2F
         mQK1xqRKYgizBxgDtVPEvfoh4B8OLJ7GX/g3lw2T57vPBxL3Pt7rVKSXG2fQ4obR56Zu
         rd33TWj+4v0J2w/fOuXefQ4N5qMovCn6mXtGbXqcrCAFb6QtLLSNwxlWtj43K5qGj9Vl
         ZBq3oudy2cW86DomrRHguk3DFtstrSiq4idG9XTGbBjPT1RaYXTK26hBHKTwe5lCxYPj
         F9+A==
X-Received: by 10.43.53.211 with SMTP id vr19mr514875icb.33.1371622180976;
 Tue, 18 Jun 2013 23:09:40 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 23:09:00 -0700 (PDT)
In-Reply-To: <51C1442A.2010904@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228348>

Johannes Sixt wrote:
> I haven't followed the topic closely, but I wonder why there are so many
> explicit assignments to GIT_REFLOG_ACTION. Is calling set_reflog_action
> (defined in git-sh-setup) the wrong thing to do?

Does this answer your question?

set_reflog_action() {
	if [ -z "${GIT_REFLOG_ACTION:+set}" ]
	then
		GIT_REFLOG_ACTION="$*"
		export GIT_REFLOG_ACTION
	fi
}
