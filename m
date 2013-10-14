From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 12/20] alias: trivial style fix
Date: Mon, 14 Oct 2013 16:21:43 -0500
Message-ID: <525c6067716ea_197a905e84a2@nysa.notmuch>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
 <1381561636-20717-18-git-send-email-felipe.contreras@gmail.com>
 <52590E97.6060308@googlemail.com>
 <20131014141806.GB21200@google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 23:37:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVpps-0005Qb-6l
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 23:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757101Ab3JNVhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 17:37:52 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:54840 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756735Ab3JNVhv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 17:37:51 -0400
Received: by mail-ob0-f169.google.com with SMTP id wp4so5302650obc.28
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 14:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=mh9A45asOqQtBbfWF/gNPeN804opWK/+OpFU0tgo67o=;
        b=SkwV434D7V9QHrLaSlo7LfH64SlO+Anhvz7ovDGubioZwHcVPqGeA4zneREOd2m3Fv
         L74HqoMM8V7pZwyaJ3qoC6W6+GTvWo1D8FSFIqbeFs3h0HJJ48QVM+fY2gAZBX5jpz5Y
         4jEiGKBnJa8IUPn5bFOLV2NfEyD2zEb5BzIEhcEW9yJ4Kp95eK2F5gofNFxLP3czDFye
         PI2c4QiffKZVc3NikFn7Kod4XobzdV1u2246nB6x1h0bqtzYc1HuMUCaXiwoWmfH1AGS
         j2zLxprcDrs+/4a3NbSvgsCd8buCLNtzSQKqOv52wUoGvVC/zmXuCPLbcuUKLMTK+JNx
         uzrA==
X-Received: by 10.60.59.99 with SMTP id y3mr33843oeq.70.1381786670698;
        Mon, 14 Oct 2013 14:37:50 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm121503518oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 14:37:49 -0700 (PDT)
In-Reply-To: <20131014141806.GB21200@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236120>

Jonathan Nieder wrote:
> Stefan Beller wrote:
> > On 10/12/2013 09:07 AM, Felipe Contreras wrote:
> 
> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >
> > Not sure if it's worth by a newcomer. ;)
> 
> A second set of eyes is always welcome.
> 
> My thoughts: I have to admit I don't see much value in mechanical
> replacements like this one when done piecemeal and without other more
> significant changes on top.

A code-style fix is a code-style fix. If you don't send and apply code-style
fixes, your code would remain forever inconsistent, and not following the
style.

It's interesting how the most successfull project in history has a different
take on this:

http://article.gmane.org/gmane.linux.acpi.devel/42407

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=915ea7e41439efa7793814cdf4338cb6b003538a
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=21fcb34e28e99291e91d83422f2824f11b3c9ce9
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=28ee793e7ad4a00e41c6267075501694c94451fb

> >> --- a/alias.c
> >> +++ b/alias.c
> >> @@ -5,7 +5,7 @@ static char *alias_val;
> >>  
> >>  static int alias_lookup_cb(const char *k, const char *v, void *cb)
> >>  {
> >> -	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key)) {
> >> +	if (!prefixcmp(k, "alias.") && !strcmp(k + 6, alias_key)) {
> 
> does not look worth the churn and mailing list noise to me.
> 
> A patch that globally took care of these var+constant constructs
> without surrounding space and did nothing else, once and for all to
> avoid later noise, may or may not be useful.  I suspect even that
> wouldn't be worth it, since "k+6" already seems perfectly readable.

This comes from the Linux kernel code-style:

----
Use one space around (on each side of) most binary and ternary operators,
such as any of these:

	=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :
----

So no, to me and a huge lot of developers it's not "perfectly readable".

-- 
Felipe Contreras
