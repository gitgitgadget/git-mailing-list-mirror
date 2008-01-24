From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: I'm a total push-over..
Date: Thu, 24 Jan 2008 19:28:28 +0300
Message-ID: <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
	 <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>
	 <4797095F.9020602@op5.se>
	 <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>
	 <4797518A.3040704@op5.se>
	 <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com>
	 <4798B633.8040606@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Marko Kreen" <markokr@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Jan 24 17:29:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI4wp-0002Jg-5R
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 17:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbYAXQ2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 11:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbYAXQ2b
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 11:28:31 -0500
Received: from el-out-1112.google.com ([209.85.162.179]:44004 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbYAXQ2a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 11:28:30 -0500
Received: by el-out-1112.google.com with SMTP id v27so25383ele.23
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 08:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XNvT6euaXB+yoZARXCZmExjU9CpXm24ao1nMhkVn9Zg=;
        b=pTpqbRWC8fg9xtWh3BVJHwCWV4F7m/gBHTSlgve3SA6lmA67QId+YZ1i4O/HJB6IpU08m1VgW8kAaYhvp9J9/p5ShDwLGwHHLWxbIN66XWxyYISLvCUPiav4l7xa5+WB/JeKlSQzwkRHw5DexDqUSvbD2D8ClCPSYjJCywspvmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i8lkv2FjdjBE3W3O+NIlkfVnaN2+ZlfoL6sqQDEj3hXzccQjPeesFNlp2fW1+vDOEe1QfqmtfziF91JHaGus6ZjfziC/XUWyyPZ2sb6wjlqTHyoXIviiNM0W5zIMqaw/Qi+D/Z3n1fSDeMqQqz7b9Mh6fdNajdD/CemZX/8YQbg=
Received: by 10.142.237.20 with SMTP id k20mr475060wfh.228.1201192108811;
        Thu, 24 Jan 2008 08:28:28 -0800 (PST)
Received: by 10.143.157.20 with HTTP; Thu, 24 Jan 2008 08:28:28 -0800 (PST)
In-Reply-To: <4798B633.8040606@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71631>

On Jan 24, 2008 7:00 PM, Andreas Ericsson <ae@op5.se> wrote:
> Marko Kreen wrote:
> >
> > Jenkins hash is fast because it does not look at individual bytes.
> > If you _do_ want to look at them for unrelated reasons, (case-insensitive,
> > unicode-juggling), then it obiously loses the point.  That is, if you
> > want to process the string in one go.
> >
>
> I believe the ability to add unicode-juggling was a major point
> with the patch, so perhaps Jenkins' isn't such a good option.

I don't think you can any meaningful unicode-juggling without converting
symbols to UCS-4, and after that it makes much more sense to operate
with uint32 than bytes. So, Jenkins' hash is still relevant, just because
it does not operate on single bytes, but using uint32.

Dmitry
