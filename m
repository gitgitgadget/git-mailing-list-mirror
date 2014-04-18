From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v9 0/6] transport-helper: fixes
Date: Fri, 18 Apr 2014 18:32:49 -0500
Message-ID: <5351b6219fce_3497cdf30c6e@nysa.notmuch>
References: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq61mbod8y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Richard Hansen <rhansen@bbn.com>,
	Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 01:43:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbIR7-0005FN-ME
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 01:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbaDRXnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 19:43:09 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:37694 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922AbaDRXnI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 19:43:08 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn1so2316939obc.4
        for <git@vger.kernel.org>; Fri, 18 Apr 2014 16:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=1FYG1N+8b1usX5dVGQ40pnP+27OhgVtw8S8K5H9WKc0=;
        b=IQgSHhKsOTtPF6B5o4P8st+BzAhcXBADHxKe4ahL5hcPl+EJIq2fMU1tWDoj4fR1mB
         V+wYpNCXVKjayP9CfHFuvgI6dDd9g+oAUMBKmfyJH+W8kcvXE1gRbDlETg+WoLlzPFQ6
         JRDfzNCzaFZHle1ZgpzB7IswMkCYrAw9e51LMI5CXiHULGKfRMHKSCyTxYTYQY5wIqTk
         I9Bi/nAerH+ZgZjanB+vmuQTho8C14Fd3Z63GcouyTxN1gZcE0aeQ5tZDvDgZRMqQTBP
         kR5R646zhI4xT+Kd2FDtuD+xFwxqkee6AezlUj1jyOH3DQuUvZUB9xL3EA6gBRfRMG+V
         dykw==
X-Received: by 10.60.102.241 with SMTP id fr17mr98765oeb.64.1397864587613;
        Fri, 18 Apr 2014 16:43:07 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id l5sm55429380obh.15.2014.04.18.16.43.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Apr 2014 16:43:06 -0700 (PDT)
In-Reply-To: <xmqq61mbod8y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246490>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > These patches add support for remote helpers --force, --dry-run, and reporting
> > forced update.
> >
> > Changes since v8:
> >
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -734,7 +734,7 @@ static int push_update_ref_status(struct strbuf *buf,
> >         }
> >  
> >         (*ref)->status = status;
> > -       (*ref)->forced_update = forced;
> > +       (*ref)->forced_update |= forced;
> >         (*ref)->remote_status = msg;
> >         return !(status == REF_STATUS_OK);
> >  }
> 
> Hmph, isn't v8 already in 'master' as of 90e6255a (Merge branch
> 'fc/transport-helper-fixes', 2014-03-18)?

I think I saw gitk report "Branches: remotes/origin/pu", but OK.

-- 
Felipe Contreras
