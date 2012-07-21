From: Ramana Kumar <ramana@member.fsf.org>
Subject: Re: empty ident name trashes commit message
Date: Sat, 21 Jul 2012 15:26:26 +0100
Message-ID: <CAMej=270FDFxyVtKTC9v4KUSkSw+TBNOg+LbGfWOgmTe_xKiRQ@mail.gmail.com>
References: <CAMej=25=xj61pc+k42dv3byuBqUJzW21Sz+BXwoufqnKwV5Bbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 21 16:27:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssaec-0002A7-FU
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 16:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318Ab2GUO0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 10:26:48 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:63057 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab2GUO0r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 10:26:47 -0400
Received: by qadb17 with SMTP id b17so563097qad.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 07:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=TvnpnDb6tX1u2uuYdLkKVv5H93d41wrJNSjuEqNgswM=;
        b=qNIslQQItDdLqKrHmNjLSlGMwOuHbh+ykUMUccOd8WQ8Kwtkf0yoX2R/cbE7qGmzc7
         rpxZuZ20XLJLexMe6GHP//bkWK95pcnWwEGKM/H/JR1HGjU1TMzMh/pHaFyjebWsjfO5
         7jFN0KvcURrdq1qB3Jhl0zrsZMY9C49DcPikZsNLvBmL4r1WXhLzCIji1CUeC+obQ1dy
         lLkFEQV4/N5LI9sljZCSiTgqylMoeZwVs8zCzU8vqG9OaQfSVlhd1VAvXI+sFRrGcHU7
         hYf2zmJ5YtN8WT2znG/c1/KSeTVxTgF6eBvbNRQKNFpd6pvRVyOLqU7vYC6/DTWKonQL
         3GYA==
Received: by 10.224.35.130 with SMTP id p2mr3989565qad.21.1342880806923; Sat,
 21 Jul 2012 07:26:46 -0700 (PDT)
Received: by 10.229.132.17 with HTTP; Sat, 21 Jul 2012 07:26:26 -0700 (PDT)
In-Reply-To: <CAMej=25=xj61pc+k42dv3byuBqUJzW21Sz+BXwoufqnKwV5Bbg@mail.gmail.com>
X-Google-Sender-Auth: PBnpvjEVPwFsJq5aCUWmTlEEViQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201807>

If I forget to set user.email and user.name config options and do a commit
(possibly the --amend option also required to make this show up), then git
1.7.11.2 will drops me into an editor for a commit message, then after that
complain with the fatal message:

   *** Please tell me who you are.

   Run

     git config --global user.email "you@example.com"
     git config --global user.name "Your Name"

   to set your account's default identity.
   Omit --global to set the identity only in this repository.

   fatal: empty ident name (for <ramana.kumar@gmail.com>) not allowed

The commit message I wrote is now lost. This is bad behaviour - the error
should happen before one writes the commit message, or the message should be
saved somewhere.
