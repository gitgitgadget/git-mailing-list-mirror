From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: odd behavior with export LESS=i
Date: Tue, 14 Jul 2009 10:32:04 -0700
Message-ID: <fabb9a1e0907141032o6b1aac51yb42a640249f04050@mail.gmail.com>
References: <3a69fa7c0907141018l4f6fb773o219b6a18effc393d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 19:32:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQlro-0003bD-0A
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 19:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbZGNRc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 13:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbZGNRc1
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 13:32:27 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:58993 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbZGNRc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 13:32:26 -0400
Received: by ewy26 with SMTP id 26so3454380ewy.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=yK11xihKeqs0K5kjx5tGFGL5vQSVz+Em89f5gaXbgg0=;
        b=HeQ8rpMQdbO4JyyTa8suXafkDs+8SYwoza0sJSOdIkqWDBhxofC8J/tXuZJxUd5rWc
         Su519h07jebIEkSfRBZtSe/0yE08LpLY9+ADem0Vw5+YxgcBkK/eWa6MbHqB3loekPAX
         8aJpuQMQ2nrE+o8LzeOC5mPhd1A6yksVyrSIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=L+3TOdlYjvWiC1IN8m83WH4rQPM7KwdqR6Ody9dfvLTWtxZZZIbM6956fCJsUTT+8o
         dodpbAR3hBffijjiE5T1MvwL+5D3GkibqiuplVVb4j82ZVrf2yfOgxJzV044vTCn/8i1
         qZLXnagt3pgt/C27X+O7UcEk90fIAsXDpqIHE=
Received: by 10.216.17.213 with SMTP id j63mr1768447wej.140.1247592745108; 
	Tue, 14 Jul 2009 10:32:25 -0700 (PDT)
In-Reply-To: <3a69fa7c0907141018l4f6fb773o219b6a18effc393d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123258>

Heya,

On Tue, Jul 14, 2009 at 10:18, E R<pc88mxer@gmail.com> wrote:
> export LESS
> LESS=i git log
>
> then I see things like ESC[33m instead of colored text.

That's because (as you could read in less'
way-too-long-for-a-damn-pager man page), you did not specify the magic
"-R" make-everything-work-like-it-should option, which turns on the
display of escape sequences (which are used to color your terminal).


> If I run:
>
> unset LESS
> git log
>
> then I get colored text.

That's because if not set, git default to setting LESS to -FXRS (which
includes the -R option). Solution is to either not set LESS, or to
include -R if that's indeed what you want.

-- 
Cheers,

Sverre Rabbelier
