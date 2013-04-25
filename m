From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/9] remote-hg: use hashlib instead of hg sha1 util
Date: Thu, 25 Apr 2013 23:55:50 +0530
Message-ID: <CALkWK0=Q2KZPioYD21pYLzruBnFh_cpFLh_rDj7QDa3bOaCO6g@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com> <1366888849-19607-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 20:26:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVQsN-0000tQ-86
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 20:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759282Ab3DYS0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 14:26:31 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:63111 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758738Ab3DYS0a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 14:26:30 -0400
Received: by mail-ie0-f178.google.com with SMTP id aq17so3945799iec.37
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=7d8CD6TyxlproOpI9vB2XL1Ku/EHuhgW85RmPZL0cpA=;
        b=xCF9/J4GKl+QW/cUDIwqOTL8LnWxAeVr/XClTKN/RqtG5BELFB1LYeZwEq4IVsFBo/
         EW3kyUGS5oVHZYM/1f3BUmLmwxwIavpoLdAq/SIjskSojD990XqgWd260PEUmKaXazWP
         XYInJ1dI5XRYhUF2s2W7hDXmtOkKwwE0QBYqxKn6MxHddjFmw30Hh9Mx1Q1iw2S35mbD
         /EendTDWplevbUJNEVfUcR2axD1T+G6NxUaQyYMukX/yzrblUlol+pUsEVxAVYktwxeh
         FoMRdjyHOONL61RfAs0eNkbPsAA67L3qAdf5rnJr56D09/QCM/KTquOCfPYBLmWTP6aY
         CWEw==
X-Received: by 10.50.55.73 with SMTP id q9mr26648492igp.44.1366914390226; Thu,
 25 Apr 2013 11:26:30 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 25 Apr 2013 11:25:50 -0700 (PDT)
In-Reply-To: <1366888849-19607-6-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222408>

Felipe Contreras wrote:
> To be in sync with remote-bzr.

Huh?  Why do you have to be in sync with remote-bzr?  Are you sharing
code between remote-hg and remote-bzr?

> @@ -830,7 +831,7 @@ def main(args):
>
>      if alias[4:] == url:
>          is_tmp = True
> -        alias = util.sha1(alias).hexdigest()
> +        alias = hashlib.sha1(alias).hexdigest()

Did you eve bother justifying this change with a line in the commit
message?  How is the new form different from the old form?
