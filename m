From: Junio C Hamano <gitster@pobox.com>
Subject: =?UTF-8?Q?Re=3A_Identifying_user_who_ran_=E2=80=9Cgit_reset=E2=80=9D_command?=
Date: Fri, 20 Feb 2015 20:58:18 -0800
Message-ID: <CAPc5daULfa8oASxvWQ7RuV9T4SXoCw_Pi0EfGkk1GGafa1r9Xg@mail.gmail.com>
References: <1424493989740-7625788.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Technext <varuag.chhabra@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 06:08:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YP2It-0006aY-Ti
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 06:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392AbbBUE6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 23:58:40 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:49709 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143AbbBUE6j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 23:58:39 -0500
Received: by mail-ob0-f181.google.com with SMTP id vb8so28042663obc.12
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 20:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=uj6SHXZ+CVldxihnZRQfrSiCN1pyR4TptkASz2X85no=;
        b=va+9kizJ4evh8zfs5jRmhR/Iw5M8eXH/cBcR6QxSa9EGsB74Q6XZmUx9e9KhFezPCC
         TGmj7nCD9ESI/e6nV/3kS+RFfyzfkcoWhqg7VbbpOu0zlIMaOe9bHuOHuHY4WIt8Rx0c
         R1FeEggxswghxVOAUJ/P2t9NvQbV5pjDs3fgIgrBfqzEP7Yhjtqqz75TnFqA86RL+duY
         7J6fg6e8g6ROW68LcjUlyBoRs5hrpMQCaGMg5Q9PAMSmwMV6JvNkHCjXNynDdjeQGIE1
         YXYap9GKxX/HvrB4Ov+6S8dapeHVcphyS8AWnruVv6VCpR/1KIH63VODXkKlitUBcmkp
         GU6A==
X-Received: by 10.202.217.9 with SMTP id q9mr625955oig.35.1424494718690; Fri,
 20 Feb 2015 20:58:38 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Fri, 20 Feb 2015 20:58:18 -0800 (PST)
In-Reply-To: <1424493989740-7625788.post@n2.nabble.com>
X-Google-Sender-Auth: ROEI_r2XamN01Dou0rrcpEF3TKQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264205>

On Fri, Feb 20, 2015 at 8:46 PM, Technext <varuag.chhabra@gmail.com> wrote:
> The biggest problem that I see here is that
> every developer has the rights to commit, which I feel is not right.

Hmm, if you have some way to classify developers into two (or more?)
categories, what would you do instead? Allow some to commit, and
what can others do? Show their change to more senior people and
ask them to commit?

That is more or less in a traditional centralized SCM set-up, I think.

With Git, you can do something similar with "rights to push", if you
prefer such a workflow. It would go like this:

 (1) Everybody can commit to their own repository and grow their own
      history. What you want to protect is the shared view of the project
      history, and restricting what people can do in their own playpen is
      unnecessary.

 (2) Senior people can push into the project's central repository, just
      like in the set-up you currently have.

 (3) Junior people can ask senior people to pull from them. Senior
      people will pull their changes, review, and if the changes are
      good, merge them and push the result to the project's central
      repository. Alternatively, junior people can do this asking by
      sending patches to senior people, who will review and then
      apply to their tree and push the result out to the common history.
