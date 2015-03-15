From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] git.c: two memory leak fixes
Date: Sun, 15 Mar 2015 17:53:14 +0600
Message-ID: <CANCZXo4rJWJohDpeb+nt3t=WBjmq14473+ynuPhvOuPd9+Vs_w@mail.gmail.com>
References: <1426358613-30180-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq3857vw9b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 12:53:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX76e-0006A1-DU
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 12:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbbCOLxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 07:53:16 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33519 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbbCOLxP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 07:53:15 -0400
Received: by obcxo2 with SMTP id xo2so17842813obc.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 04:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Tdr39IM7ictVmGwaexcKZT8n4rTKvRdIeSPu9XYqLuk=;
        b=MbFNo8Mo7ZG1IsJgu5p9pqdfMAq35TavcO5ejHYtg9l22ko33dAKZNNh7y4/nIUitY
         75/czfeNj+Kc79a4iw7VpqCWfnlfL9I4ZRramRShIHU6FkF7Tdpri7V+9RZmZKy2pgEg
         IOnJDkpyt3vOKPVBP1O/7FO9M4hrOReUK5OoTZtn1VQkdCeTmwIZidprqKvzxLsURzLX
         2xqWsjA1UKkdGSRg885Gi8a8oT4wKwx5z3iGFmTBeFQnHujYaWZ4hsM+RAHGqXjh18c/
         CeHWqm1x4SRTATWVB+fPyyznh5/6JANdOeffBd119UliZYxVtStpBXGI+IWePr9Z1Dkm
         nAeQ==
X-Received: by 10.202.176.4 with SMTP id z4mr41273063oie.43.1426420394994;
 Sun, 15 Mar 2015 04:53:14 -0700 (PDT)
Received: by 10.182.197.10 with HTTP; Sun, 15 Mar 2015 04:53:14 -0700 (PDT)
In-Reply-To: <xmqq3857vw9b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265491>

Hello Junio,

>>This is technically correct, but do we really care about it?

Yes, as i saw handle_alias called once, and we no need to care about it.

>>I think it is wrong to free alias_string after passing it to
>>split_cmdline() and while you still need to use the new_argv.

Yes, right. sorry for the noise.
