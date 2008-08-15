From: "Bryan Donlan" <bdonlan@gmail.com>
Subject: Re: Git tree/blob and corresponding commit
Date: Fri, 15 Aug 2008 15:39:14 -0400
Message-ID: <3e8340490808151239u4572f5e4l11c16e0225509224@mail.gmail.com>
References: <489F208B.2070006@obry.net>
	 <Pine.GSO.4.62.0808101519220.16851@harper.uchicago.edu>
	 <Pine.GSO.4.62.0808101542140.17376@harper.uchicago.edu>
	 <48A43AEC.6000904@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jonathan Nieder" <jrnieder@uchicago.edu>,
	"git list" <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Fri Aug 15 21:40:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU59m-0005G0-UP
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 21:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758094AbYHOTjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 15:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758089AbYHOTjQ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 15:39:16 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:37186 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756119AbYHOTjP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 15:39:15 -0400
Received: by gxk9 with SMTP id 9so3554578gxk.13
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8pC84hXQaQ0bKQA1gAj+WZL4h1LUtEUrIHhpYr5RE1I=;
        b=nV46lkFUnABOCt/JtVSNHC+G/CK7XKj7YL9JEiS0u0cF5IG1MkyitYlVHr7R8grhUV
         sqdNsbfOiufevb3wsjot+nJBknLWqCk9MHnZUaPzlUTFc1g+jC9ruBPBLgSJ2i2IOw7l
         w4xMYPjBA1ouulMlrOBw9KXSwe4jzUnUEpXAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JgJAxDClWvTt8PoE3x09j/oKrSi3vgJJsaXrgnVMDUf51p/6Q9OB0FeoP5hFn7694r
         zwZFpk25eKXcMu7lqCY7RElQfVN2uTJrnISmFhub7QGNwwMyccTlu5PCK0yQGiyaeE3L
         oZQgoKxvdrGzi86rud/5Z63pDX7kXGBScpnSw=
Received: by 10.151.114.6 with SMTP id r6mr4458790ybm.84.1218829154668;
        Fri, 15 Aug 2008 12:39:14 -0700 (PDT)
Received: by 10.65.234.13 with HTTP; Fri, 15 Aug 2008 12:39:14 -0700 (PDT)
In-Reply-To: <48A43AEC.6000904@obry.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92513>

On Thu, Aug 14, 2008 at 10:02 AM, Pascal Obry <pascal@obry.net> wrote:
> Jonathan,
>
>> but I actually meant
>>
>> <http://thread.gmane.org/gmane.comp.version-control.git/44750/focus=44849>.
>> Anyway, the whole thread is interesting.  Sorry for the noise.
>
> Thanks, I had a look. This is indeed giving some procedure... I was hopping
> for something faster (git rev-list takes some time!).

It's not really meant to be a common case; if the same file is created
under different names by different commits that aren't ancestors of
each other, then it's unclear which should be reported. As such,
there's no index or other such thing to quickly find the commits
corresponding to a blob, so you just have to walk the entire history.
