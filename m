From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Mon, 13 May 2013 12:33:20 -0700
Message-ID: <20130513193320.GC3657@google.com>
References: <7vipezaaig.fsf@alter.siamese.dyndns.org>
 <1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
 <CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
 <20130511055647.GA3262@iris.ozlabs.ibm.com>
 <20130511061322.GB3394@elie>
 <20130511094119.GA6196@iris.ozlabs.ibm.com>
 <CACPiFCKkzSCaSfqExZggFHBAmcPBTYYhyauOa2h1dXiYqKZMxA@mail.gmail.com>
 <20130513185551.GB3657@google.com>
 <CAAhxitGFhVa6+8x_rgNz5dgyr6m4S11fVU2eJNnMuWimGiM8aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Langhoff <martin@laptop.org>
X-From: git-owner@vger.kernel.org Mon May 13 21:33:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbyV0-0001Uz-EJ
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 21:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781Ab3EMTd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 15:33:26 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:54392 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab3EMTdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 15:33:25 -0400
Received: by mail-pa0-f52.google.com with SMTP id bg2so4860727pad.25
        for <git@vger.kernel.org>; Mon, 13 May 2013 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FWWKihu5GHfhF69vR6RHiQdN1XgpqE/kgLLPcnu0nko=;
        b=YuEpwji+uzfalHJlNUzQbfyOmd21F0NmPZIom6i9sOU2b3IIDMSkQ0ytlt+xUS0KMm
         QXUaXSmCw678bDJij2e+IpIdS8qM7Es7OjHhVapcE+bsPXJJ4Th2trY3CnjU3bGkMI3t
         ODzSl22u06hHwugRNRBA2C71VlmKx16KyqZdO6VurQG5YAcAlV/ZQ7fDTHNzAqTVanZO
         9yVbn/xfBIsD3L+XtjPHzuP9eT+corY/vsj02Gw23NcnGM3CBOyPk6pEf9EUSmzM5L/6
         zGcYJXJ+G+nHF36QTWsjaS+2PSWDFDDG1C+YjKa+3G9OCXt5snyV1cKmY+7cUf0z1YCE
         mNPA==
X-Received: by 10.68.99.226 with SMTP id et2mr30445071pbb.91.1368473605046;
        Mon, 13 May 2013 12:33:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id az5sm15094770pbc.18.2013.05.13.12.33.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 12:33:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAAhxitGFhVa6+8x_rgNz5dgyr6m4S11fVU2eJNnMuWimGiM8aQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224197>

Martin Langhoff wrote:
> On Mon, May 13, 2013 at 2:55 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> My experience is the opposite.  I wonder "What did the author of this
>> nonsense comment mean?" or "What is the purpose of this strange
>> condition in this if () statement?".  Then "git log -S" finds the
>> culprit
>
> Only if that if () statement looks that way from a single commit.
> That's my point. If the line code bit you are looking at is the result
> of several changes, your log -S will grind a while and find you
> nothing.

Well, no, it should find the final change that brought it into the
current form.  Just like "git blame".

Has it been finding zero results in some cases where the current code
matches the pattern?  That sounds like a bug.
