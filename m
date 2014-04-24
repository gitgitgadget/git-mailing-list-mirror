From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v7 03/12] revert/cherry-pick: add --quiet option
Date: Thu, 24 Apr 2014 18:33:08 -0500
Message-ID: <53599f34e416f_523614ed2ec21@nysa.notmuch>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
 <1398307491-21314-4-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0nETYdWpTYrNGE+au-b=jAXKy3FX6YOGo5s=v_UbnYtPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 01:44:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdTJn-0006w3-JN
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 01:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbaDXXoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 19:44:08 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:59695 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbaDXXng (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 19:43:36 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so3450880obc.24
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 16:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=3MkdRi9P3FgRviwUF7VTD8lSHDbd3MaupTpfsZxMFko=;
        b=ZtILZaoO0QDvX325QNWP8oJmZkSpZdtcE7NvwWPkBVhaANAqDJiwzR2zUaYozyxxZw
         pGYmgWsAPI8GZO7vd2M9mGpxQdQeX8rEZqvDmnvgoYJ1lAn2JbTp2gjQTrCsVjAdIvSD
         VZoFWqWa5VVPDRgvKKzv5oI6TuBDfrp1lpfVsBF/L45VpjUA20gnEjRfSWlWGKElXBPn
         hC//A2LYl/a8bbU+1oVI0TO9BpVLgbgSykxp/e44hISDltAzE+GZrGWpRPXSbyqBHFpT
         dCChQEz3wlG6VkqecLq2kmY6BGt9MUdGHUSvP117g+AeDdu43KW2RwnvGG8lqr7Krry0
         Bv0A==
X-Received: by 10.182.22.18 with SMTP id z18mr3933619obe.42.1398383016269;
        Thu, 24 Apr 2014 16:43:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id sm4sm11692364obc.3.2014.04.24.16.43.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Apr 2014 16:43:35 -0700 (PDT)
In-Reply-To: <CALkWK0nETYdWpTYrNGE+au-b=jAXKy3FX6YOGo5s=v_UbnYtPA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247025>

Ramkumar Ramachandra wrote:
> Felipe Contreras wrote:
> > @@ -635,9 +637,10 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
> >         }
> >
> >         if (opts->skip_empty && is_index_unchanged() == 1) {
> > -               warning(_("skipping %s... %s"),
> > -                       find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
> > -                       msg.subject);
> > +               if (!opts->quiet)
> > +                       warning(_("skipping %s... %s"),
> > +                               find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
> > +                               msg.subject);
> 
> Personally, I don't see much value in inventing a new option for
> suppressing one message.

It's not one message; it's two messages from cherry-pick itself, and all the
messages from `git commit`. Didn't we alread discuss this?

-- 
Felipe Contreras
