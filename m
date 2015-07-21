From: David Turner <dturner@twopensource.com>
Subject: Re: What's cooking in git.git (Jul 2015, #05; Mon, 20)
Date: Tue, 21 Jul 2015 12:36:50 -0400
Organization: Twitter
Message-ID: <1437496610.30911.15.camel@twopensource.com>
References: <xmqqwpxuwh8d.fsf@gitster.dls.corp.google.com>
	 <1437439832.30911.12.camel@twopensource.com>
	 <xmqqsi8iw0pz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 18:36:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHaXH-0005uE-TG
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 18:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbbGUQgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 12:36:50 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33782 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421AbbGUQgu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 12:36:50 -0400
Received: by qkdl129 with SMTP id l129so136541884qkd.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 09:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=FG+mhH6ccFjigYh7GMnvPoRk44bub6qwcHyye8O0ibk=;
        b=kISwBWtcmBzBUsMn3NOtrdh3YO7q/MkPJjSAFNKiWnW/g3lfFadaAQSn/IddwTbr4/
         rXKAR4jJ1rJGGfcaxHrlS081+7tqqirvuiXyXI1B+HChpOS0WqTm3sD+N91v3SfO1GSB
         LfHjoeZx3+8GzbBvNyDDZA40+V/HTh21L3tRcnhDFyHlLgQSXuXJX++8ItLCnzoiGhz3
         jqSDTEWZhtcOSn3OxEWHHWm6TFGw4fKq47d3AoTkQQgg/9un7Epnox3+uGVQOFl5tfI5
         oOsy0vUj/8SItm8l3m6CONsE7IMJaPpncB4zlfr4sKm5mbW7pgS9AGNkIjb1lcWX1JxD
         qQsw==
X-Gm-Message-State: ALoCoQnRISxF44K7bRk6YmUPZBYK880fdij4h5wnpF+fk9zCtasMhGly06uwOOXpnwnulJLaTwQ/
X-Received: by 10.140.93.200 with SMTP id d66mr17577855qge.62.1437496609372;
        Tue, 21 Jul 2015 09:36:49 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g92sm13009611qgf.20.2015.07.21.09.36.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2015 09:36:48 -0700 (PDT)
In-Reply-To: <xmqqsi8iw0pz.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274388>

On Mon, 2015-07-20 at 22:15 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> >> * dt/refs-backend-preamble (2015-07-13) 7 commits
> >>  - git-stash: use update-ref --create-reflog instead of creating files
> >>  - update-ref and tag: add --create-reflog arg
> >>  - refs: add REF_FORCE_CREATE_REFLOG flag
> >>  - git-reflog: add exists command
> >>  - refs: new public ref function: safe_create_reflog
> >>  - refs: Break out check for reflog autocreation
> >>  - refs.c: add err arguments to reflog functions
> >> ...
> >>  Still under discussion.
> >> 
> >>  Will hold.
> >
> > What's left to discuss on this one? I think the latest version addresses
> > all concerns, but I'm happy to do another reroll or discuss further if
> > necessary.
> 
> I think I found the series more or less ready when I saw v7, but
> there was a good discussion between Michael Haggerty and you on that
> round after I thought so, and then you posted the reroll (v8) which
> is what is queued above.  As I was not closely following the earlier
> exchange, I wanted to hear from Michael if everything is now good
> with v8, which hasn't happened as far as I recall.

Thanks.  I've incorporated Michael Haggerty's suggestions into v9.

> Also in $gmane/273828 [*1*] you hinted (but without showing a firm
> commitment) that there might be a reroll coming, which was another
> reason why I wasn't in a hurry to merge v8 iteration down to 'next'.

The current version does not use the term "pseudoref" (it is used in the
refs backend series, and added to the glossary in those patches).
