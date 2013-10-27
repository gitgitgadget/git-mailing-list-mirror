From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 07/10] fast-import: add support to delete refs
Date: Sun, 27 Oct 2013 06:24:04 -0400
Message-ID: <CAPig+cRDwrofbWOoZLnk9abUXmZWUQvmNLmRk9A+Kv7hcQLUXw@mail.gmail.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
	<1382857521-7005-10-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 27 11:24:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaNWC-0002ys-8g
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 11:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab3J0KYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 06:24:08 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:38178 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab3J0KYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 06:24:06 -0400
Received: by mail-lb0-f182.google.com with SMTP id w6so1941122lbh.41
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 03:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ZEQDJGIZRbWdrhnnEsRgND78N4cM4Xg83kGzrW4fd3s=;
        b=glbXbRyWUrY0D4nVQRlylxTSnz6P0DUeE0UvyvSmeWMgYAyOLSqfp7UfJROzDMMRBA
         ZJ8+OHHHxZTItbEj9u2qBSQTcYbj58SnqBoB7Z7h/5DcqZI0UYpojtT+bKNWCk4uf54B
         aKF60HMs9BBSauxKlUTTI6/b5hkVv7MiKugm52Qol7X8lV6e8IvDtI2W7NMBP6Jc911h
         aQaQ3o4yxvpkN40Gw7WB3gP33K80hH+wfKsyMcRFax1GebWm/ATaftPVUsDFMioFK4Cl
         kyLbonLu6CJ2hrxuyET6ksVapcDFf/Cl3qfd+MmdmyNmWDGSddviHyIaWgenuAdXqO0E
         ihVQ==
X-Received: by 10.112.131.68 with SMTP id ok4mr7390947lbb.13.1382869444315;
 Sun, 27 Oct 2013 03:24:04 -0700 (PDT)
Received: by 10.114.200.180 with HTTP; Sun, 27 Oct 2013 03:24:04 -0700 (PDT)
In-Reply-To: <1382857521-7005-10-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: 0r0uLn0-ubGLv57vDgd0Cc16fjc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236799>

On Sun, Oct 27, 2013 at 3:05 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-fast-import.txt |  3 +++
>  fast-import.c                     | 13 ++++++++++---
>  t/t9300-fast-import.sh            | 18 ++++++++++++++++++
>  3 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index 73f9806..c49ede4 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -483,6 +483,9 @@ Marks must be declared (via `mark`) before they can be used.
>  * Any valid Git SHA-1 expression that resolves to a commit.  See
>    ``SPECIFYING REVISIONS'' in linkgit:gitrevisions[7] for details.
>
> +* The special null SHA-1 (40 zeros) specifices that the branch is to be

s/specifices/specifies/

> +  removed.
> +
>  The special case of restarting an incremental import from the
>  current branch value should be written as:
>  ----
