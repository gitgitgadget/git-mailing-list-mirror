From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Is this a bug?
Date: Tue, 19 Feb 2013 10:47:53 +0100
Message-ID: <CABPQNSY4ordHh2ee8mk-2kCD40+sMf_SxrjfzGbkyGGTNW1TzA@mail.gmail.com>
References: <937BB05095F39E46B969256AA776205322B2CF15C7@ST-EXCL29.statoil.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Wade <DAWAD@statoil.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 10:49:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7jov-0004II-I5
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 10:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758229Ab3BSJsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 04:48:35 -0500
Received: from mail-ia0-f173.google.com ([209.85.210.173]:61858 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756851Ab3BSJse (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 04:48:34 -0500
Received: by mail-ia0-f173.google.com with SMTP id h37so5931564iak.4
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 01:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=J16TkqTMY8IMjiwghkaKc27R643O8hskvlCrOcKCoG0=;
        b=BGJ4IoksEciLUkpmvYmBDruaflZdEEf1NvU9JA7+K1NJE1To5rkzRw+1Jz4IbN/8Wg
         dtiqVxAw9mYfF2WkcBtxL7OQBVp/rrgrwL1RBz1W8GRHi7NRR4TMW7PPxNgaxhw+QKsa
         joJyoDARbVAvn1zebopNC/j1luU503Jf4ZIH2RwAIekyAjmgvfE39n6VJ3o17QiQk/hK
         TwSPDVxjyFT5Eem+TKWecRbEVAYjbWsPOEIHqiA27RGwhXeQJNubFd6DdU9w0+hqNI5R
         zmqRahNZ00zlX0GlUYkXhL23guWXhML9cRcuHev52/wkQqP/rfyu14bkRGxLryN6qRWM
         BLnA==
X-Received: by 10.50.34.131 with SMTP id z3mr9010031igi.30.1361267313784; Tue,
 19 Feb 2013 01:48:33 -0800 (PST)
Received: by 10.64.164.139 with HTTP; Tue, 19 Feb 2013 01:47:53 -0800 (PST)
In-Reply-To: <937BB05095F39E46B969256AA776205322B2CF15C7@ST-EXCL29.statoil.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216586>

On Tue, Feb 19, 2013 at 10:32 AM, David Wade <DAWAD@statoil.com> wrote:
> Hi,
>
> I wrote a commit message beginning with a hash (#) character, like this: 'git commit -m "#ifdef ...." '
>
> Everything went okay when committing, but then I tried 'git commit -amend' and without editing the commit message I was told I had an empty commit message.
>
> Is this a problem with my text editor (vim 7.2) or git itself? (git version 1.7.2.2 under RedHat 5.8) Or something I'm not supposed to do ;-) ?

The problem is that when doing interactive editing of messages (like
'git commit --amend' does), git considers '#' as a comment-character.
You can disable this by using the --cleanup=verbatim switch (or some
other suiting cleanup-setting, see 'git help commit').
