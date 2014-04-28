From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 04/12] Makefile: introduce CROSS_COMPILE variable
Date: Mon, 28 Apr 2014 12:34:41 -0500
Message-ID: <535e91317d381_45651483310d4@nysa.notmuch>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-5-git-send-email-marat@slonopotamus.org>
 <20140428162536.GB13002@google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:43:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerSf-00049v-Sk
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034AbaD1Tmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:42:44 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:37392 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaD1Tmm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:42:42 -0400
Received: by mail-oa0-f47.google.com with SMTP id i11so7769671oag.20
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=t+VX3YF6HemjlvFJFEFAAEXKG9/LB3NtOi6TbN8QLNk=;
        b=UqdHilXyD2rjHWoemJOCSB7/GgX9E/n3kkbY6LA67YUxtr373puwHxhTmQ2Yxrp+m1
         ykGuJ7bvkZIInqRJaY4XmtclD+altxam/4CDWNxi+LxzpInt+YZaGgRtU/50onqKIdfT
         ukHpn89g6MdzyiUCK4AnpJS7dUxJspiyMmjRH4Sy3Km3iY6n6q2hMd7V7ZtGFqMoDAhE
         D7SxFUHzcA8Ll7xBtMpLgv2TFGlnozD6eJOGsTYgieVs9pHqbT8voa7iMgHJJG2+Y+9A
         nGj0WrfEsZqGCbPEhIlaCV3LbGbTd9CLr+xA9s2NhlBaIzIyhHbMI7W/lCywn6Sja0M2
         AkXw==
X-Received: by 10.182.233.201 with SMTP id ty9mr23667788obc.29.1398707117462;
        Mon, 28 Apr 2014 10:45:17 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id h1sm38085015obr.15.2014.04.28.10.45.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 10:45:15 -0700 (PDT)
In-Reply-To: <20140428162536.GB13002@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247418>

Jonathan Nieder wrote:
> Marat Radchenko wrote:

> Does the effect of this setting depend on whether CC=gcc (i.e., is the
> Makefile checking the value of CC and ignoring CROSS_COMPILE when it
> is e.g. the Intel compiler)?

If the user is doing 'make CC=gcc', the CROSS_COMPILE setting shouldn't be
appended.

> [...]
> > -STRIP ?= strip
> > +STRIP = $(CROSS_COMPILE)strip
> 
> Before, STRIP from the environment took precedence over STRIP from the
> makefile.  Switching to the more usual 'environment can't be trusted'
> convention is a good change, but please mention it in the commit
> message.

That's only if you run make without -e. If somebody wants the environment to be
trusted, they should run 'make -e' in my opinion.

-- 
Felipe Contreras
