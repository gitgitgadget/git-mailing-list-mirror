From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 22:51:04 +0100
Message-ID: <e5bfff550801101351w257975b1q9391d556c7af22a0@mail.gmail.com>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
	 <7v4pdmfw27.fsf@gitster.siamese.dyndns.org>
	 <47855765.9090001@vilain.net>
	 <alpine.LSU.1.00.0801092328580.31053@racer.site>
	 <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net>
	 <20080110091607.GA17944@artemis.madism.org>
	 <alpine.LFD.1.00.0801101332150.3054@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Pierre Habouzit" <madcoder@debian.org>,
	"Sam Vilain" <sam@vilain.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:51:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD5JK-0007d6-6G
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 22:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbYAJVvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 16:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbYAJVvJ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 16:51:09 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:20119 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbYAJVvG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 16:51:06 -0500
Received: by py-out-1112.google.com with SMTP id u52so1249696pyb.10
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 13:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xYfzkDGfH9KgMjho1kOePYDRuHqDuivyKk04n3TyLcA=;
        b=W2IgP6IR/P7epAhvs4vpD4wvdK+5mRi4S9X5gm6ur1LVHOA5a8qR4+WU0rlhYxennI3NrAVaySRoZJvGUiJHXCj8Ohkak3DCjlBJ9gtIQYGvCh5rJkn1anZNIhzN5S4hYp3oJ2wQfDJ4bA1ifi7YIGWm45dTogR24dxAS7Z3nNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DVvHJzDhVJq5BS3uNz0zVQ0r4+bb+QzQ0f2wylFJ7ob3bHb08XjJsyRBbiMm60oq+Qg4T8fTTwYOcun8tDBZmXd6IWXLtyMSM6yV/tW5LZ1sLyo87GjSYMp06kUImJNy3GpEq44PTemPyWp6ntV8en9d+/20V7aquV10BqAFGzQ=
Received: by 10.140.199.19 with SMTP id w19mr1537797rvf.104.1200001864566;
        Thu, 10 Jan 2008 13:51:04 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 13:51:04 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801101332150.3054@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70099>

On Jan 10, 2008 9:39 PM, Nicolas Pitre <nico@cam.org> wrote:
>
> Right.  Abstracting the zlib code and having different compression
> algorithms tested in the Git context is the only way to do meaningful
> comparisons.
>

The first thing I would like to test when zlib abstraction is ready is
to test with NULL compressor, i.e. not compression/decompression at
all and see if 'git log' and friends are happy.

BTW would be possible to test git with zlib disabled also now? I mean
there is a quick hack to disable zlib not only in writing but also in
reading, so that we can see what happens when running a repository
packed without compression?


Thanks
Marco
