From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v3 3/3] Smart-http tests: Test http-backend without
	curl or a webserver
Date: Sat, 2 Jan 2010 13:41:07 -0800
Message-ID: <20100102214107.GO6914@spearce.org>
References: <905315641001021244o522ac092g7fdaaab83a2609e2@mail.gmail.com> <1262465119-96115-3-git-send-email-tarmigan+git@gmail.com> <20100102210318.GN6914@spearce.org> <905315641001021337v238515c8s34d820236dac698d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 22:41:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRBiu-0000nz-0T
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 22:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992Ab0ABVlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 16:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030Ab0ABVlL
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 16:41:11 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:52463 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab0ABVlK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 16:41:10 -0500
Received: by yxe17 with SMTP id 17so12908712yxe.33
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 13:41:09 -0800 (PST)
Received: by 10.100.24.9 with SMTP id 9mr22286985anx.186.1262468469346;
        Sat, 02 Jan 2010 13:41:09 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm16060248iwn.0.2010.01.02.13.41.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 13:41:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <905315641001021337v238515c8s34d820236dac698d@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136058>

Tarmigan <tarmigan+git@gmail.com> wrote:
> On Sat, Jan 2, 2010 at 1:03 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Tarmigan Casebolt <tarmigan+git@gmail.com> wrote:
> >> ?GET() {
> >> - ? ? return 0
> >> + ? ? REQUEST_METHOD="GET" \
> >> + ? ? run_backend "/repo.git/$1" &&
> >> + ? ? grep "Status" act.out >act
> >> + ? ? if [ $? -eq 1 ];
> >
> > I think this should be spelled as:
> >
> > ? ? ? ?if ! grep "Status" act.out >act; then
> > ? ? ? ? ? ? ? ?printf "Status: 200 OK\r\n" > act
> > ? ? ? ?fi
> 
> OK.  I had figured the "1" would mean "no matches not found"  rather
> than some other error like "file does not exist".  Not sure how
> portable that error value convention is for greps though, so I've
> changed it as you suggested.

Your v3 series still shows it the old way...

-- 
Shawn.
