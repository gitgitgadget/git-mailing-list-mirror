From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 23:26:44 +0700
Message-ID: <CACsJy8B3PpzidvAHado=y3ZromzROidmHh_OW9ZCOoFegzmQ3Q@mail.gmail.com>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
 <87zjwguq8t.fsf@linux-k42r.v.cablecom.net> <20130430150430.GA13398@lanh> <7vehdsf19m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 18:27:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXDOx-0004yS-EW
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 18:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559Ab3D3Q1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 12:27:24 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:60296 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932267Ab3D3Q1P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 12:27:15 -0400
Received: by mail-ob0-f173.google.com with SMTP id xn12so608827obc.18
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 09:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=oKEBVb5o018dcPELlFn4JmhECbdGKljC0fHnS81AR1o=;
        b=nyviWPW5bMcO6qBgK7TuzbGmbktfi/oZkC3r/hOTWW3MBIrzC2rNsS2ApbsdAujfSt
         WBh+IoHXAuYuwpIdHGkjW5HwyGsqL8z7AtP3lja593LADbre843gn9wJNJBKs6SgMcvD
         Jz9C/yab75ZEzM2X2OlXmRfYfhtLYYxKSy3xgg5vWWvZab3Ulc6kdLg2GMuBiIlqD7+d
         dqRkSv35hD/TRFQvM1drzfF9UsMD1ST6pXtvmo3IJswF82vpA9FFbnFauomL+dp9AJpK
         QN7mN03vV39OKkt+0i/1XM3Haz1zxLKIxeKim0if5hzaGpHVbRsUjKegXLFwXk6SDal9
         aaEw==
X-Received: by 10.182.148.231 with SMTP id tv7mr25304686obb.38.1367339234803;
 Tue, 30 Apr 2013 09:27:14 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Tue, 30 Apr 2013 09:26:44 -0700 (PDT)
In-Reply-To: <7vehdsf19m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222945>

On Tue, Apr 30, 2013 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> It's not hard to do. The below patch makes "." equivalent to HEAD and
>> ".U" -> "@{u}". Refs are not supposed to have '.' at the beginning, so
>> it's easy ...
>
> How is the equivalent of master..@{u} expressed?  master...U?  How is
> it disambiguated from a symmetric difference between master and U?
>
> There are reasons why some characters are forbidden from appearing
> at certain places in refname component. Anybody who designs a new
> syntax needs to think _why_.

I figured it had something to do with hidden filenames, not "..".
There's only one char left for ref alias, the leading forward slash.
But than opens another can of worms.. We could put still ref aliases
into the same ref namespace, with lower precedence that actual refs,
so no new syntax required.
--
Duy
