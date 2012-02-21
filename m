From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/8 v6] diff --stat: use the full terminal width
Date: Tue, 21 Feb 2012 22:16:39 +0700
Message-ID: <CACsJy8AXH6xm-ShH_HF6RwATFwsYtAZQfcWoB9VpaiCMj6e8vQ@mail.gmail.com>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael J Gruber <git@drmicha.warpmail.net>,
	j.sixt@viscovery.net
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Feb 21 16:18:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzrTf-00006K-6l
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 16:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab2BUPRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 10:17:33 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64458 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab2BUPRK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 10:17:10 -0500
Received: by wgbdt10 with SMTP id dt10so5785814wgb.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 07:17:09 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.99.65 as permitted sender) client-ip=10.180.99.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.99.65 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.99.65])
        by 10.180.99.65 with SMTP id eo1mr27648387wib.13.1329837429356 (num_hops = 1);
        Tue, 21 Feb 2012 07:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KdefT5i2s19i3GvlBt8e28qo53mSHd9ha7AM0VoG7uA=;
        b=JsVT1zkRBqI3AUeNr6g7igaSd0/2awhTPfi/assLl3URoKVdrLZ8HavNCHu77RDzp8
         lZE7zWwwEcx05Be2Jmoxi6GT1KfvXxhl5cwLjNn7oAprEburJ3H2v19WSxBWULhsmz+5
         7RcMdknY1OiJ0UsjtxOSytxEDKvBCFvHo4zH8=
Received: by 10.180.99.65 with SMTP id eo1mr23138678wib.13.1329837429271; Tue,
 21 Feb 2012 07:17:09 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Tue, 21 Feb 2012 07:16:39 -0800 (PST)
In-Reply-To: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191164>

Not related to changes in the series, but on the same topic. Have you
considered grouping pathnames to reduce pressure on truncating them?
Instead of showing

a/b/c | ++--
a/b/d | --++

you could show

a/b:
c | ++--
d | --++

Optimal grouping strategy could be hard, but at least we could use it
for the case "git diff --stat -- one/path/deep/in/here"
-- 
Duy
